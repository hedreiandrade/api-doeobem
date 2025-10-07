<?php
/*
 * @author Hedrei Andrade <hedreiandrade@gmail.com>
 * @Version 1.0.0
 */
namespace App\Controllers;

use App\Models\Users;
use Respect\Validation\Validator as v;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;

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
        $user = Users::where('email', $params['email'])->first();
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
    * @param   Response    $response   Objeto de resposta
    * @return  Json
    */
    public function loginFacebook($request, $response)
    {
        $return = [];
        
        $params = $request->getParams();
        try {
            $fbClient = new \Facebook\Facebook([
                'app_id' => APP_ID,
                'app_secret' => APP_SECRET,
                'default_graph_version' => 'v2.10'
                //'default_access_token' => '{access-token}', // optional
            ]);
            // continue
        } catch(\Facebook\Exceptions\FacebookSDKException $e) {
            $return = array('response'=>'Facebook SDK returned an error: ' . $e->getMessage());
        }

        http_response_code(200);
        $this->respond($return);
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
                // Criar novo usuário
                $userData = [
                    'name' => $name,
                    'email' => $email,
                    'google_id' => $googleId,
                    'auth_provider' => 'google',
                    'email_verified' => 1,
                    'password' => password_hash(bin2hex(random_bytes(16)), PASSWORD_DEFAULT),
                    'active' => 1,
                    'photo' => $picture ? $this->downloadGooglePhoto($picture, $googleId) : null,
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
                    'email_verified' => 1,
                    'updated_at' => date('Y-m-d H:i:s')
                ];
                
                if (!$user->photo && $picture) {
                    $updateData['photo'] = $this->downloadGooglePhoto($picture, $googleId);
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

}
