<?php
/*
 * @author Hedrei Andrade <hedreiandrade@gmail.com>
 * @Version 1.0.0
 */
namespace App\Controllers;

use App\Models\Users;
use Exception;
use Respect\Validation\Validator as v;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use PHPMailer\PHPMailer\PHPMailer;
use Aws\S3\S3Client;
use Aws\Exception\AwsException;

class UsersController extends BaseController
{

    /**
     * S3 object
     */    
    private $s3Client;

    /**
     * Construtor
     *
     * @param   Slim\Container    $Container    Container da aplicação
     *
     * @return  null
     */
    public function __construct($container)
    {
        parent::__construct($container);
        $this->activeModel = new Users();
        $config = [
            'version' => S3_VERSION,
            'region'  => S3_REGION, 
            'credentials' => [
                'key'    => S3_KEY,
                'secret' => S3_KEY_SECRET,
            ],
        ];
        try {
            $this->s3Client = new S3Client($config);
        } catch (AwsException $e) {
            echo "Erro AWS: " . $e->getMessage() . "\n";
            die('Erro na configuração S3');
        } catch (Exception $e) {
            echo "Erro: " . $e->getMessage() . "\n";
            die('Erro na configuração S3');
        }
    }

    /**
     * Retorna um objeto \DavidePastore\Slim\Validation\Validation,
     * com as regras de validação default do controller.
     *
     * @return \DavidePastore\Slim\Validation\Validation
     */
    public static function getValidators()
    {
        return new \DavidePastore\Slim\Validation\Validation(
            [
                'name' => v::notEmpty(),
                //'nickname' => v::alnum()->noWhitespace()->length(1, 40),
                'password' => v::notEmpty()->noWhitespace()->length(8, 200)->regex('/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/')->setTemplate('Enter a stronger password, with uppercase letters, lowercase letters, numbers and a special character.'),
                'email' => v::notEmpty()->noWhitespace()->length(1, 200) 
                //'state' => v::noWhitespace()->length(1, 3),
                //'country' => v::noWhitespace()->length(1, 2)
            ]
        );
    }

    /**
     * Insere um registro
     *
     * @param   Request     $request    Objeto de requisição
     * @param   Response    $response   Objeto de resposta
     *
     * @return  Json
     */
    public function insert($request, $response)
    {
        $return = [];
        $params = $request->getParams();
        $bucketName = 'hmediaha';
        try{
            // Validações pre-definidas no controller
            $this->getAttributeErrors($request);
            // Verifica formatação básica de e-mail
            $this->checkEmail($params['email']);
            // Esconde senhas
            if(isset($params['password'])){
                $params['password'] = $this->hidePassword($params['password']);     
            }
            if(STORAGE === 'local'){
                if(isset($_FILES['photo'])){
                    $directory = PUBLIC_PATH.'/images/profile';
                    if (!is_dir($directory)) {
                        mkdir($directory, 0777, true);
                    }
                    $file = $_FILES['photo'];
                    $imageName = rand().$file['name'];
                    move_uploaded_file($file['tmp_name'], PUBLIC_PATH.'/images/profile/'.$imageName);
                    $params['photo'] = URL_PUBLIC.'/images/profile/'.$imageName;
                }
            }else{
                if(isset($_FILES['photo'])){
                    $file = $_FILES['photo'];
                    $imageName = rand().$file['name'];
                    $userName = strtolower(str_replace(' ', '', $params['name']));
                    $userFolder = md5($params['email']) . '_' . $userName;
                    // Criar caminho no S3
                    $s3Path = 'images/profile/' . $userFolder . '/' . $imageName;
                    // Fazer upload para o S3
                    $result = $this->s3Client->putObject([
                        'Bucket' => $bucketName,
                        'Key'    => $s3Path,
                        'Body'   => fopen($file['tmp_name'], 'rb'),
                        'ACL'    => 'public-read',
                        'ContentType' => mime_content_type($file['tmp_name']),
                        'ContentDisposition' => 'inline' // para não baixar
                    ]);
                    // URL pública do arquivo no S3
                    $params['photo'] = $result->get('ObjectURL');
                }
            }

            if(Users::where('email', $params['email'])
                    ->where('email_verified', 0)
                    ->where('auth_provider', 'local')
                    ->first()){
                $this->sendEmail($params['email']);
                $return = array('response'=>'Account created successfully! Check your email to confirm your account.');
                $this->respond($return);
            }
            if(Users::where('email', $params['email'])
                    ->where('email_verified', 1)
                    ->first()){
                $return = array('response'=>"There is an account for this e-mail, try to recover your password. ");
                $this->respond($return);
            }
            $user = Users::where('email', $params['email'])->first();
            if($user) {
                // Atualizar dados do usuário existente
                $updateData = [
                    'name' => $params['name'],
                    'email' => $params['email'],
                    'password' => $params['password'],
                    'email_verified' => 0,
                    'photo' => $params['photo'],
                    'auth_provider' => 'local',
                    'updated_at' => date('Y-m-d H:i:s')
                ];
                $user->update($updateData);
                // Atualizar último acesso
                $user->update([
                    'last_access' => date('Y-m-d H:i:s'),
                    'access_count' => ($user->access_count ?? 0) + 1
                ]);
                $user->refresh();
                $this->sendEmail($params['email']);
            }else{
                $params['google_id'] = null;
                $params['auth_provider'] = 'local';
                $params['email_verified'] = 0;
                $params['first_access'] = date('Y-m-d H:i:s');
                $return = Users::create($params);
                $this->sendEmail($params['email']);
                $return = array('id' => $return->id);
            }
            http_response_code(201);
        }catch (\Exception $e) {
            $return = array('status' => 401,
                        'response' => 'An error occurred while creating account'. $e->getMessage());
             $this->respond($return);
        }
        $this->respond($return);
    }

    /**
     * Retorna chave de autenticação do usuário logado
     *
     * @param   Request     $request    Objeto de requisição
     * @param   Response    $response   Objeto de resposta
     * @return  Json
     */
    public function login($request, $response)
    {
        $return = [];
        $params = $request->getParams();
        try{
            // Verifica se foi informado email e senha
            if (!isset($params['email']) || !isset($params['password'])) {
                $return = array('response'=>"Please, give me your email and password.");
                //http_response_code(401);
                $this->respond($return);
            }
            if(!empty($params['email']) && !empty($params['password'])){
                $this->checkEmail($params['email']);
            }else{
                $return = array('response'=>"Please, give me your email and password.");
                //http_response_code(401);
                $this->respond($return);
            }
            // Busca primeiro usuário com esse e-mail
            $user = Users::where('email', $params['email'])->where('email_verified', 1)->first();
            // Verifica email
            if (!$user) {
                $userEmail = $params['email'];
                $return = array('response'=>"The email you've entered: $userEmail doesn't match any account. Sign up for an account.");
                //http_response_code(401);
                $this->respond($return);
            }
            // Verifica senha
            if (!password_verify($params['password'], $user->password)) {
                $return = array('response'=>"Incorrect password. Try again.");
                //http_response_code(401);
            } else {
                $user->auth_provider = 'local';
                $user->google_id = null;
                $user->save();
                // Gera Token
                $token = $this->createToken();
                $token['photo'] = $user->photo;
                $token['user_id'] = $user->id;
                $token['name'] = $user->name;
                $return = array('response' => $token);
                http_response_code(200);
            }
        }catch (\Exception $e) {
            $return = array('status' => 401,
                        'response' => 'An error occurred while logging in.');
             $this->respond($return);
        }
        $this->respond($return);
    }

    /**
     * Logout
     *
     * @param   Request     $request    Objeto de requisição
     * @param   Response    $response   Objeto de resposta
     * @return  Json
     */
    public function logout($request, $response)
    {
        //session_start();
        $return = [];

        // Verifica se usuário está logado. Caso sim, realiza o logout
        if (isset($_SESSION['token'])) {
            $return = array('response'=>'UserToken successfully logged off.');
            session_unset();
        } else {
            // Nunca logou
            $return = array('response'=>'User never logged in.');
        }
        session_write_close();
        http_response_code(200);
        $this->respond($return);
    }

    /**
     * Retorna 200 para token valido e 401 para expirado ou inválido.
     *
     * @param   Request     $request    Objeto de requisição
     * @return  Json
     */
    public function verifyTokenRedirect($request) 
    {
        $params = $request->getParams();
        if($params['token'] == ''){
            http_response_code(401);
            $this->respond(['message' => 'Por favor forneceder token']);
        }
        try {
            JWT::decode($params['token'], new Key(JWT_SECRET, 'HS256'));
        } catch(\Exception $e) {
            http_response_code(401);
            $this->respond(['message' => $e->getMessage()]);
        }
        http_response_code(200);
        return $this->respond(['message' => 'Validado']);
    }

    /**
     * Altera password, precisar estar logado para poder alterar
     *
     * @param   Request     $request    Objeto de requisição
     * @param   Response    $response   Objeto de resposta
     * @return  Json
     */
    public function changePassword($request, $response)
    {
        $return = [];
        $params = $request->getParams();
        try{
            // Verifica se foi informado email, senha e nova senha
            if (!isset($params['email']) || !isset($params['password']) || !isset($params['newPassword']) || !$params['newPassword'] || !isset($params['confirmNewPassword']) || !$params['confirmNewPassword']) {
                $return = array('status' => 401, 'response'=>"Please, give me your email, password, new password and confirm new password");
                $this->respond($return);
            }
            $user = Users::where('id', $params['id'])->first();
            if($user->email !== $params['email']){
                $return = array('status' => 401, 'response'=>"The email you've entered doesn't match with account.");
                $this->respond($return);
            }
            // Verifica cadastro do email
            $user = Users::where('email', $params['email'])->first();
            if (!$user) {
                $userEmail = $params['email'];
                $return = array('status' => 401, 'response'=>"The email you've entered: $userEmail doesn't match any account. Sign up for an account.");
                $this->respond($return);
            }
            // Verifica a velha senha
            if (!password_verify($params['password'], $user->password)) {
                $return = array('status' => 401, 'response'=>"The old password is not correct. Try again.");
            } else {
                // Seta nova
                $user->password = $this->hidePassword($params['newPassword']);
                $user->save();
                $return = array('status' => 200, 'response'=>"User: $user->id password changed successfully.");
            }
            http_response_code(200);
        }catch (\Exception $e) {
            $return = array('status' => 401,
                        'response' => 'An error occurred while change password.');
             $this->respond($return);
        }
        $this->respond($return);
    }

    /**
     * Logar com o Facebook
     *
     * @param   Request     $request    Objeto de requisição
     * @return  Json
     */
    public function loginFacebook($request)
    {
        $return = [];
        $params = $request->getParams();
        try {
            if (empty($params['token'])) {
                throw new \Exception('Token do Facebook é obrigatório');
            }
            $accessToken = $params['token'];
            error_log("Token Facebook recebido: " . substr($accessToken, 0, 20) . "...");
            $fbClient = new \Facebook\Facebook([
                'app_id' => APP_ID,
                'app_secret' => APP_SECRET,
                'default_graph_version' => 'v19.0'
            ]);
            // TENTAR buscar dados COM email primeiro
            try {
                $fbResponse = $fbClient->get('/me?fields=id,name,email,first_name,last_name,picture.type(large)', $accessToken);
                $userData = $fbResponse->getGraphUser();
                
                error_log("Dados COMPLETOS do usuário Facebook: " . print_r($userData, true));
            } catch (\Exception $e) {
                error_log("Erro ao buscar dados com email: " . $e->getMessage());
                // Se falhar, buscar apenas dados públicos
                $fbResponse = $fbClient->get('/me?fields=id,name,first_name,last_name,picture.type(large)', $accessToken);
                $userData = $fbResponse->getGraphUser();
            }
            // Verificar se temos dados básicos
            if (empty($userData['id'])) {
                throw new \Exception('ID do Facebook não encontrado');
            }
            $facebookId = $userData['id'];
            $name = $userData['name'] ?? '';
            $firstName = $userData['first_name'] ?? '';
            $lastName = $userData['last_name'] ?? '';
            // CORREÇÃO: Acessar a URL da foto corretamente
            $picture = $userData['picture'] ? $userData['picture']->getUrl() : null;
            // TENTAR obter email, se não conseguir usar fallback
            $email = $userData['email'] ?? null;
            if (empty($email)) {
                // Fallback: criar email baseado no Facebook ID
                $email = 'fb_' . $facebookId . '@facebook.com';
                $emailVerified = 0;
                error_log("Email não disponível, usando fallback: $email");
            } else {
                $emailVerified = 1;
                error_log("Email obtido do Facebook: $email");
            }
            error_log("Facebook Login - Usuário: $name, Email: $email, Facebook ID: $facebookId");
            // Buscar usuário pelo Facebook ID PRIMEIRO
            $user = Users::where('facebook_id', $facebookId)->first();
            if (!$user && $email) {
                // Se não encontrou pelo Facebook ID, tentar pelo email
                $user = Users::where('email', $email)->first();
            }
            if (!$user) {
                // Criar novo usuário
                $userData = [
                    'name' => $name,
                    'email' => $email,
                    'facebook_id' => $facebookId,
                    'auth_provider' => 'facebook',
                    'password' => password_hash(bin2hex(random_bytes(16)), PASSWORD_DEFAULT),
                    'active' => 1,
                    'photo' => URL_PUBLIC.'/images/profile/' .$picture ? URL_PUBLIC.'/images/profile/' .$this->downloadFacebookPhoto($picture, $facebookId) : null,
                    'created_at' => date('Y-m-d H:i:s'),
                    'first_access' => date('Y-m-d H:i:s')
                ];
                $user = Users::create($userData);
                error_log("Novo usuário criado via Facebook: $name (Email: $email)");
            } else {
                // Atualizar dados do usuário existente
                $updateData = [
                    'facebook_id' => $facebookId,
                    'auth_provider' => 'facebook',
                    'updated_at' => date('Y-m-d H:i:s')
                ];
                // Atualizar email apenas se for um email real do Facebook
                if ($emailVerified && $email !== $user->email) {
                    $updateData['email'] = $email;
                }
                if (!$user->photo && $picture) {
                    $updateData['photo'] = $this->downloadFacebookPhoto($picture, $facebookId);
                }
                $user->update($updateData);
                // Atualizar último acesso
                $user->update([
                    'last_access' => date('Y-m-d H:i:s'),
                    'access_count' => ($user->access_count ?? 0) + 1
                ]);
                $user->refresh();
                error_log("Usuário atualizado via Facebook: $name (Email: $email)");
            }
            // Gerar token JWT
            $token = $this->createToken();
            $return = [
                'response' => [
                    'token' => $token['token'],
                    'user_id' => $user->id,
                    'name' => $user->name,
                    'email' => $user->email,
                    'photo' => $user->photo,
                    'auth_provider' => $user->auth_provider,
                ]
            ];
        } catch (\Exception $e) {
            $return = array('status' => 401,
                        'response' => 'An error occurred while login with Facebook');
             $this->respond($return);
        }
        $this->respond($return);
    }

    /**
     * Download e salvar foto do Facebook (igual ao Google)
     */
    private function downloadFacebookPhoto($pictureUrl, $facebookId)
    {
        try {
            $photoContent = file_get_contents($pictureUrl);
            if ($photoContent) {
                $extension = 'jpg'; // Facebook geralmente retorna JPG
                $filename = 'facebook_' . $facebookId . '_' . time() . '.' . $extension;
                $uploadPath = PUBLIC_PATH.'/images/profile/' . $filename;
                $directory = PUBLIC_PATH.'/images/profile';
                
                // Certifique-se de que o diretório existe
                if (!is_dir($directory)) {
                    mkdir($directory, 0755, true);
                }
                
                if (file_put_contents($uploadPath, $photoContent)) {
                    return $filename; // Retornar apenas o filename como no Google
                }
            }
        } catch (\Exception $e) {
            // Log do erro, mas não interrompe o processo
            error_log('Erro ao baixar foto do Facebook: ' . $e->getMessage());
        }
        
        return null;
    }
    
    /**
     * Logar com o Google
     *
     * @param   Request     $request    Objeto de requisição
     * @param   Response    $response   Objeto de resposta
     * @return  Json
     */
    public function loginGoogle($request, $response)
    {
        $return = [];
        $params = $request->getParams();
        try {
            if (empty($params['token'])) {
                throw new \Exception('Token do Google é obrigatório');
            }
            $accessToken = $params['token'];
            // MÉTODO CORRETO: Usar access_token para buscar informações do usuário
            $userInfoUrl = "https://www.googleapis.com/oauth2/v3/userinfo";
            // Usando cURL para melhor controle
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $userInfoUrl);
            curl_setopt($ch, CURLOPT_HTTPHEADER, [
                "Authorization: Bearer " . $accessToken
            ]);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_TIMEOUT, 10);
            $userInfo = curl_exec($ch);
            $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
            curl_close($ch);
            // Verificar se a requisição foi bem sucedida
            if ($httpCode !== 200) {
                throw new \Exception('Falha ao validar token. Código HTTP: ' . $httpCode);
            }
            $userData = json_decode($userInfo, true);
            if (isset($userData['error'])) {
                throw new \Exception('Token inválido: ' . ($userData['error_description'] ?? $userData['error']));
            }
            if (empty($userData['email'])) {
                throw new \Exception('Email não encontrado nos dados do usuário');
            }
            // Dados do usuário
            $googleId = $userData['sub'];
            $email = $userData['email'];
            $name = $userData['name'] ?? '';
            $picture = $userData['picture'] ?? null;
            error_log("Google Login - Usuário: $name, Email: $email");
            // Verificar se usuário já existe
            $user = Users::where('email', $email)->first();
            if (!$user) {
                $userData = [
                    'name' => $name,
                    'email' => $email,
                    'google_id' => $googleId,
                    'auth_provider' => 'google',
                    'password' => password_hash(bin2hex(random_bytes(16)), PASSWORD_DEFAULT),
                    'active' => 1,
                    'photo' => $picture ? URL_PUBLIC . '/images/profile/' . $this->downloadGooglePhoto($picture, $googleId) : null,
                    'created_at' => date('Y-m-d H:i:s'),
                    'first_access' => date('Y-m-d H:i:s')
                ];
                $user = Users::create($userData);
                error_log("Novo usuário criado via Google: $email");
            } else {
                // Atualizar dados do usuário existente
                $updateData = [
                    'google_id' => $googleId,
                    'auth_provider' => 'google',
                    'updated_at' => date('Y-m-d H:i:s')
                ];
                if (!$user->photo && $picture) {
                    $updateData['photo'] = URL_PUBLIC . '/images/profile/' . $this->downloadGooglePhoto($picture, $googleId);
                }
                $user->update($updateData);
                // Atualizar último acesso
                $user->update([
                    'last_access' => date('Y-m-d H:i:s'),
                    'access_count' => ($user->access_count ?? 0) + 1
                ]);
                $user->refresh();
                error_log("Usuário atualizado via Google: $email");
            }
            // Gerar token JWT (use seu método existente)
            $token = $this->createToken();
            $return = [
                'response' => [
                    'token' => $token['token'],
                    'user_id' => $user->id,
                    'name' => $user->name,
                    'email' => $user->email,
                    'photo' => $user->photo,
                    'auth_provider' => $user->auth_provider
                ]
            ];
        } catch (\Exception $e) {
            $return = array('status' => 401,
                        'response' => 'An error occurred while login with Google');
             $this->respond($return);
        }
        $this->respond($return);
    }

    /**
     * Download e salvar foto do Google
     */
    private function downloadGooglePhoto($photoUrl, $googleId)
    {
        try {
            $photoContent = file_get_contents($photoUrl);
            if ($photoContent) {
                $extension = 'jpg'; // Google geralmente retorna JPG
                $filename = 'google_' . $googleId . '_' . time() . '.' . $extension;
                $uploadPath = PUBLIC_PATH.'/images/profile/' . $filename;
                $directory = PUBLIC_PATH.'/images/profile';
                
                // Certifique-se de que o diretório existe
                if (!is_dir($directory)) {
                    mkdir($directory, 0755, true);
                }
                
                if (file_put_contents($uploadPath, $photoContent)) {
                    return $filename;
                }
            }
        } catch (\Exception $e) {
            // Log do erro, mas não interrompe o processo
            error_log('Erro ao baixar foto do Google: ' . $e->getMessage());
        }
        
        return null;
    }

    /**
     * Quando o usuário confirma por email
     *
     * @param Request $request Objeto de requisição

     * @return Json
     */
    public function confirmedByEmail($request)
    {
        $return = [];
        $email = $request->getAttribute('email', false);
        $token = $request->getParam('token', false);

        if ($email == '' || $token == '') {
            $return = array('status' => 401, 
                            'data' => 'Informe seu token e e-mail.');
            http_response_code(200);
            $this->respond($return);
        }
        try {
            JWT::decode($token, new Key(JWT_SECRET_EMAIL, 'HS256'));
            $this->checkEmail($email);
            // Verifica cadastro do email
            $user = Users::where('email', $email)->first();
            $user->active = 1;
            $user->email_verified = 1;
            $user->save();
            $return = array('status' => 200,
                            'message' => 'O email: '.$email.' foi confirmado com sucesso.');
            http_response_code(200);
            $this->respond($return);
        } catch (\Exception $e) {
            $return = array('status' => 401,
                        'message' => 'Invalid Token');
             $this->respond($return);
        }
    }

    /**
     * Envia emails para primeiro acesso a conta
     */
    public function sendEmail($emailTo = '') 
    {
        $mail = new PHPMailer(true);
        $token = $this->createEmailToken();
        $user = Users::where('email', $emailTo)->first();
        try {
            //Server settings
            $mail->SMTPDebug = false; 
            $mail->isSMTP();                                          
            $mail->Host = SMTP_HOST;                 
            $mail->SMTPAuth = true; 
            $mail->Username = SMTP_USERNAME;                   
            $mail->Password = SMTP_PASSWORD;                           
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;         
            $mail->Port = 587;    
            $mail->CharSet = 'UTF-8';                               
            //Recipients
            $mail->setFrom('hedreiandrade@gmail.com', 'H Media');
            $mail->addAddress($emailTo, $user->name);              
            // Create the email HTML
            $confirmationLink = URL_PUBLIC.'/v1/confirmedByEmail/'.$emailTo.'?token='.$token['token'];
            $emailBody = '
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Confirm Your Email - H Media</title>
                <style>
                    body { font-family: Arial, sans-serif; line-height: 1.6; margin: 0; padding: 0; background-color: #f4f4f4; }
                    .container { max-width: 600px; margin: 0 auto; background: #ffffff; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
                    .header { text-align: center; padding: 20px 0; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 10px 10px 0 0; color: white; }
                    .header h1 { margin: 0; font-size: 28px; }
                    .content { padding: 30px 20px; text-align: center; }
                    .welcome-text { font-size: 24px; color: #333; margin-bottom: 20px; font-weight: bold; }
                    .message { font-size: 16px; color: #666; margin-bottom: 30px; line-height: 1.8; }
                    .button { display: inline-block; padding: 15px 30px; background: #0D6EFD; color: #FFF !important; text-decoration: none; border-radius: 25px; font-size: 16px; font-weight: bold; margin: 20px 0; transition: all 0.3s ease; }
                    .button:hover { background: #0B5ED7; transform: translateY(-2px); box-shadow: 0 5px 15px rgba(13,110,253,0.3); }
                    .footer { text-align: center; padding: 20px; color: #888; font-size: 14px; border-top: 1px solid #eee; }
                    .security-note { background: #f8f9fa; padding: 15px; border-radius: 5px; margin: 20px 0; font-size: 14px; color: #666; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>H Media</h1>
                    </div>
                    
                    <div class="content">
                        <div class="welcome-text">
                            Welcome to H Media, '.$user->name.'! 🎉
                        </div>
                        
                        <div class="message">
                            <p>We\'re thrilled to have you join our community! Your journey to amazing content and connections starts here.</p>
                            
                            <p>To complete your registration and unlock all the features of H Media, please confirm your email address by clicking the button below:</p>
                        </div>
                        
                        <a href="'.$confirmationLink.'" class="button">
                            Confirm my email address
                        </a>
                        
                        <div class="security-note">
                            <strong>Security Note:</strong> This link will expire in 8 hours for your protection. 
                            If you didn\'t create an account with H Media, please ignore this email.
                        </div>
                        
                        <div class="message">
                            <p>Once confirmed, you\'ll be able to:</p>
                            <ul style="text-align: left; display: inline-block; margin: 0;">
                                <li>Access exclusive content</li>
                                <li>Connect with other members</li>
                                <li>Personalize your experience</li>
                                <li>And much more!</li>
                            </ul>
                        </div>
                    </div>
                    
                    <div class="footer">
                        <p>If the button doesn\'t work, copy and paste this link into your browser:</p>
                        <p style="word-break: break-all; color: #0D6EFD; font-size: 12px;">'.$confirmationLink.'</p>
                        
                        <p>&copy; H Media. All rights reserved.</p>
                    </div>
                </div>
            </body>
            </html>';
            //Content
            $mail->isHTML(true);                                  
            $mail->Subject = 'Welcome to H Media - Confirm your email address';
            $mail->Body = $emailBody;
            // Add plain text version for email clients that don't support HTML
            $mail->AltBody = "Welcome to H Media, ".$user->name."!\n\n"
                ."Please confirm your email address by clicking the following link:\n"
                .$confirmationLink."\n\n"
                ."If you didn't create an account with H Media, please ignore this email.\n\n"
                ."Best regards,\n"
                ."H Media Team";
            $mail->send();
        } catch (Exception $e) {
            $return = array('status' => 401,
                        'response' => 'An error occurred while sent email confirmation');
            $this->respond($return);
        }
    }

    /**
     * Envia emails para trocar senha
     *
     */
    public function sendEmailForgotPassword($emailTo = '') 
    {
        $mail = new PHPMailer(true);
        $token = $this->createEmailForgotToken();
        $user = Users::where('email', $emailTo)->first();
        
        try {
            //Server settings
            $mail->SMTPDebug = false; 
            $mail->isSMTP();                                          
            $mail->Host = SMTP_HOST;                 
            $mail->SMTPAuth = true; 
            $mail->Username = SMTP_USERNAME;                   
            $mail->Password = SMTP_PASSWORD;                           
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;         
            $mail->Port = 587;    
            $mail->CharSet = 'UTF-8';                               
            
            //Recipients
            $mail->setFrom('hedreiandrade@gmail.com', 'H Media');
            $mail->addAddress($emailTo, $user->name);              
            
            // Create the email HTML
            $resetLink = REACT_URL.'/forgot-password/'.$emailTo.'?token='.$token['token'];
            $emailBody = '
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Reset Your Password - H Media</title>
                <style>
                    body { font-family: Arial, sans-serif; line-height: 1.6; margin: 0; padding: 0; background-color: #f4f4f4; }
                    .container { max-width: 600px; margin: 0 auto; background: #ffffff; padding: 20px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
                    .header { text-align: center; padding: 20px 0; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 10px 10px 0 0; color: white; }
                    .header h1 { margin: 0; font-size: 28px; }
                    .content { padding: 30px 20px; text-align: center; }
                    .welcome-text { font-size: 24px; color: #333; margin-bottom: 20px; font-weight: bold; }
                    .message { font-size: 16px; color: #666; margin-bottom: 30px; line-height: 1.8; }
                    .button { display: inline-block; padding: 15px 30px; background: #0D6EFD; color: #FFF !important; text-decoration: none; border-radius: 25px; font-size: 16px; font-weight: bold; margin: 20px 0; transition: all 0.3s ease; }
                    .button:hover { background: #0B5ED7; transform: translateY(-2px); box-shadow: 0 5px 15px rgba(13,110,253,0.3); }
                    .footer { text-align: center; padding: 20px; color: #888; font-size: 14px; border-top: 1px solid #eee; }
                    .security-note { background: #f8f9fa; padding: 15px; border-radius: 5px; margin: 20px 0; font-size: 14px; color: #666; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>H Media</h1>
                    </div>
                    
                    <div class="content">
                        <div class="welcome-text">
                            Password reset request, '.$user->name.'! 🔒
                        </div>
                        
                        <div class="message">
                            <p>We received a request to reset your password for your H Media account.</p>
                            
                            <p>To proceed with resetting your password and secure your account, please click the button below. You will be redirected to our secure password reset form where you can create a new password.</p>
                        </div>
                        
                        <a href="'.$resetLink.'" class="button">
                            Reset my password
                        </a>
                        
                        <div class="security-note">
                            <strong>Security Note:</strong> This password reset link will expire in 8 hour for your protection. 
                            If you didn\'t request a password reset, please ignore this email and your password will remain unchanged.
                        </div>
                        
                        <div class="message">
                            <p>For your security, please remember to:</p>
                            <ul style="text-align: left; display: inline-block; margin: 0;">
                                <li>Create a strong, unique password</li>
                                <li>Use a combination of letters, numbers, and symbols</li>
                                <li>Avoid using personal information in your password</li>
                                <li>Never share your password with anyone</li>
                            </ul>
                        </div>
                    </div>
                    
                    <div class="footer">
                        <p>If the button doesn\'t work, copy and paste this link into your browser:</p>
                        <p style="word-break: break-all; color: #0D6EFD; font-size: 12px;">'.$resetLink.'</p>
                        
                        <p>&copy; H Media. All rights reserved.</p>
                    </div>
                </div>
            </body>
            </html>';
            
            //Content
            $mail->isHTML(true);                                  
            $mail->Subject = 'H Media - Password reset request';
            $mail->Body = $emailBody;
            
            // Add plain text version for email clients that don't support HTML
            $mail->AltBody = "Password reset request, ".$user->name."!\n\n"
                ."We received a request to reset your password for your H Media account.\n\n"
                ."To reset your password, please click the following link:\n"
                .$resetLink."\n\n"
                ."You will be redirected to our secure password reset form where you can create a new password.\n\n"
                ."If you didn't request a password reset, please ignore this email and your password will remain unchanged.\n\n"
                ."Best regards,\n"
                ."H Media Team";
                
            $mail->send();
        } catch (Exception $e) {
            $return = array('status' => 401,
                        'response' => 'An error occurred while sent email forgot password');
            $this->respond($return);
        }
    }
    /**
     * Email para trocar senha
     *
     * @param Request $request Objeto de requisição

     * @return Json
     */
    public function emailForgotPassword($request)
    {
        try{
            $email = $request->getAttribute('email', false);
            if ($email == '') {
                $return = array('status' => 401, 
                                'data' => 'Informe seu e-mail.');
                $this->respond($return);
            }
            // Verifica formatação básica de e-mail
            $validatedEmail = $this->errorEmail($email);
            if (!$validatedEmail['flEmail']) {
                $this->respond(array('status' => 203, 'response'=>$validatedEmail['response']));
            }
            $return = $this->sendEmailForgotPassword($email);
            if($return['response']['status'] === 401){
                $this->respond($return);
            }
        }catch (Exception $e) {
            $return = array('status' => 401,
                        'response' => 'An error occurred while sent email forgot password');
             $this->respond($return);
        }
        $this->respond(array('status' => 200, 'response'=>"Email to change password sent"));
    }

    /**
     * Verifica token para trocar senha
     *
     * @param   Request     $request    Objeto de requisição
     * @param   Response    $response   Objeto de resposta
     * @return  Json
     */
    public function verifyTokenForgotPassword($request, $response)
    {
        $token = $request->getParam('token', false);
        if ($token == '') {
            $return = array('status' => 401, 
                            'data' => 'Please give me a token');
            $this->respond($return);
        }
        try {
            JWT::decode($token, new Key(JWT_SECRET_EMAIL_FORGOT, 'HS256'));
            $return = array('status' => 200, 
                            'data' => 'Token valid');
             $this->respond($return);
        } catch (\Exception $e) {
            $return = array('status' => 401,
                        'message' => 'Invalid Token');
             $this->respond($return);
        }
    }

    /**
     * Reset password
     *
     * @param   Request     $request    Objeto de requisição
     * @param   Response    $response   Objeto de resposta
     * @return  Json
     */
    public function resetPassword($request, $response)
    {
        $return = [];
        $params = $request->getParams();
        try{
            JWT::decode($params['token'], new Key(JWT_SECRET_EMAIL_FORGOT, 'HS256'));
            // Verifica se foi informado email e senha
            if (!isset($params['token']) || !isset($params['email']) || !isset($params['newPassword']) || !isset($params['confirmPassword'])) {
                $return = array('status' => 401, 'message'=>"Please, give me your token, email, new password and confirm password.");
                //http_response_code(401);
                $this->respond($return);
            }else{
                $this->checkEmail($params['email']);
            }
            // Busca primeiro usuário com esse e-mail
            $user = Users::where('email', $params['email'])->where('email_verified', 1)->first();
            // Verifica email
            if (!$user) {
                $return = array('status' => 401, 'message'=>"The email you've entered: ".$params['email']."doesn't match any account. Sign up for an account.");
                //http_response_code(401);
                $this->respond($return);
            }else{
                $user->password = $this->hidePassword($params['newPassword']);
                $user->save();
            }
            $return = array('status' => 200, 'message'=>"Password changed successfully");
            //http_response_code(200);
            $this->respond($return);
        }catch (\Exception $e) {
            $return = array('status' => 401,
                        'message' => 'Invalid or expired token');
             $this->respond($return);
        }
    }

}
