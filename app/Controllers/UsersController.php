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

class UsersController extends BaseController
{

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
        // Validações pre-definidas no controller
        $this->getAttributeErrors($request);
        // Verifica formatação básica de e-mail
        $this->checkEmail($params['email']);
        // Esconde senhas
        if(isset($params['password'])){
            $params['password'] = $this->hidePassword($params['password']);     
        }
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

        // Verifica se foi informado email, senha e nova senha
        if (!isset($params['email']) || !isset($params['password']) || !isset($params['newPassword']) || !$params['newPassword'] || !isset($params['confirmNewPassword']) || !$params['confirmNewPassword']) {
            $return = array('response'=>"Please, give me your email, password, new password and confirm new password");
            $this->respond($return);
        }
        $user = Users::where('id', $params['id'])->first();
        if($user->email !== $params['email']){
            $return = array('response'=>"The email you've entered doesn't match with account.");
            $this->respond($return);
        }
        // Verifica cadastro do email
        $user = Users::where('email', $params['email'])->first();
        if (!$user) {
            $userEmail = $params['email'];
            $return = array('response'=>"The email you've entered: $userEmail doesn't match any account. Sign up for an account.");
            $this->respond($return);
        }
          // Verifica a velha senha
        if (!password_verify($params['password'], $user->password)) {
            $return = array('response'=>"The old password is not correct. Try again.");
        } else {
            // Seta nova
            $user->password = $this->hidePassword($params['newPassword']);
            $user->save();
            $return = array('response'=>"User: $user->id password changed successfully.");
        }
        
        http_response_code(200);
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

        } catch(\Exception $e) {
            error_log("ERRO Facebook Login: " . $e->getMessage());
            $return = ['response' => 'Erro no login com Facebook: ' . $e->getMessage()];
            http_response_code(400);
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
        } catch(\Exception $e) {
            error_log("ERRO Google Login: " . $e->getMessage());
            $return = ['response' => 'Erro no login com Google: ' . $e->getMessage()];
            http_response_code(400);
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
     *
     */
    public function sendEmail($emailTo = '') 
    {
        $mail = new PHPMailer(true);
        $token = $this->createEmailToken();
        try {
            //Server settings
            $mail->SMTPDebug = false; 
            //$mail->SMTPDebug = SMTP::DEBUG_SERVER;                     
            $mail->isSMTP();                                          
            $mail->Host = SMTP_HOST;                 
            $mail->SMTPAuth = true; 
            //$mail->SMTPSecure = "tls";                                  
            $mail->Username = SMTP_USERNAME;                   
            $mail->Password = SMTP_PASSWORD;                           
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;         
            $mail->Port = 587;    
            $mail->CharSet = 'uft-8';                               

            //Recipients
            $mail->setFrom('hedreiandrade@gmail.com', 'H Media');
            $mail->addAddress($emailTo, 'H Media');              

            //Content
            $mail->isHTML(true);                                  
            $mail->Subject = 'H Media register email confirmation';
            $mail->Body = '<a href="'.URL_PUBLIC.'/v1/confirmedByEmail/'.$emailTo.'?token='.$token['token'].'">Click here to confirm your email !</a>';
            $mail->send();
            //echo 'Message has been sent';
        } catch (Exception $e) {
            echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
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
        try {
            //Server settings
            $mail->SMTPDebug = false; 
            //$mail->SMTPDebug = SMTP::DEBUG_SERVER;                     
            $mail->isSMTP();                                          
            $mail->Host = SMTP_HOST;                 
            $mail->SMTPAuth = true; 
            //$mail->SMTPSecure = "tls";                                  
            $mail->Username = SMTP_USERNAME;                   
            $mail->Password = SMTP_PASSWORD;                           
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;         
            $mail->Port = 587;    
            $mail->CharSet = 'uft-8';                               

            //Recipients
            $mail->setFrom('hedreiandrade@gmail.com', 'H Media');
            $mail->addAddress($emailTo, 'H Media');              

            //Content
            $mail->isHTML(true);                                  
            $mail->Subject = 'H Media forgot password email confirmation';
            $mail->Body = '<a href="'.REACT_URL.'/forgot-password/'.$emailTo.'?token='.$token['token'].'">Click here to change your password !</a>';
            $mail->send();
            //echo 'Message has been sent';
        } catch (Exception $e) {
            echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
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
        $this->sendEmailForgotPassword($email);
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
