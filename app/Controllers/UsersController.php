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
            http_response_code(200);
            $this->respond(['message' => 'Por favor forneceder token', 'status'=> 401]);
        }
        try {
            JWT::decode($params['token'], new Key(JWT_SECRET, 'HS256'));
        } catch(\Exception $e) {
            http_response_code(200);
            $this->respond(['message' => $e->getMessage(), 'status'=> 401]);
        }
        http_response_code(200);
        return $this->respond(['message' => 'Validado', 'status'=> 200]);
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
    * Logar com o Gmail
    *
    * @param   Request     $request    Objeto de requisição
    * @param   Response    $response   Objeto de resposta
    * @return  Json
    */
    public function loginGmail($request, $response)
    {
        $return = [];
        $params = $request->getParams();
        try {
            $googleClient = new \Google_Client();
            $googleClient->setClientId(CLIENT_ID);
            $googleClient->setClientSecret(CLIENT_SECRET_ID);
            // continue
        } catch(\Exception $e) {
            $return = array('response'=>'Gmail SDK returned an error: ' . $e->getMessage());
        }

        http_response_code(200);
        $this->respond($return);
    }

}
