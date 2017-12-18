<?php

namespace App\Controllers;

use App\Models\Users;
use Respect\Validation\Validator as v;

class UsersController extends AbstractController
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
                'nickname' => v::alnum()->noWhitespace()->length(1, 40),
                'email' => v::notEmpty()->noWhitespace()->length(1, 200),
                'password' => v::notEmpty()->noWhitespace()->length(1, 200)
                //'state' => v::noWhitespace()->length(1, 3),
                //'country' => v::noWhitespace()->length(1, 2)
            ]
        );
    }

    /**
     * Retorna chave de autenticação do usuario logado
     *
     * @param   Request     $request    Objeto de requisição
     * @param   Response    $response   Objeto de resposta
     * @return  Json
     */
    public function login($request, $response)
    {
        $return = array();
        $params = $request->getParams();
        // Verifica se foi informado email e senha
        if (!isset($params['email']) || !isset($params['password'])) {
            $return = array('response'=>"Please, give me your email and password.");
            $this->respond($return);
        }
        // Busca usuário
        $user = Users::where('email', $params['email'])->first();
        // Verifica email
        if (!$user) {
            $userEmail = $params['email'];
            $return = array('response'=>"The email you've entered: $userEmail doesn't match any account. Sign up for an account.");
            $this->respond($return);
        }
        // Verifica senha
        if(!password_verify($params['password'], $user->password)){
            $return = array('response'=>"User: $user->id Incorrect password. Try again.");
        }else{
            // Inicia sessão
            session_start();
			session_cache_limiter(false);
            $_SESSION['user'] = $user->id;
            session_write_close();
            $return = array('response'=>"User: $user->id logged in successfully.");
        }

        $this->respond($return);
    }

    /**
     * Logout
     * @param   Request     $request    Objeto de requisição
     * @param   Response    $response   Objeto de resposta
     * @return  Json
     */
    public function logout($request, $response)
    {
        session_start();
        // Verifica se usuário está logado. Caso sim, realiza o logout
        if(isset($_SESSION['user'])){
            $return = array('response'=>'User: '.$_SESSION['user'].' successfully logged off.');
            unset($_SESSION['user']);
        }else{ 
            // Nunca logou
            $return = array('response'=>'User was not logged in.');
        }
        session_write_close();

        $this->respond($return);
    }

    /**
     * Altera password
     * @param   Request     $request    Objeto de requisição
     * @param   Response    $response   Objeto de resposta
     * @return  Json
     */
    public function changePassword($request, $response)
    {
        $return = array();
        $params = $request->getParams();
        // Verifica se foi informado email, senha e nova senha
        if (!isset($params['email']) || !isset($params['password']) || !isset($params['newPassword']) || !$params['newPassword']){
            $return = array('response'=>"Please, give me your email, password and the new password.");
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
        if(!password_verify($params['password'], $user->password)){
            $return = array('response'=>"The old password is not correct. Try again.");
        }else{ 
            // Seta nova
            $user->password = $this->hidePassword($params['newPassword']);
            $user->save();
            $return = array('response'=>"User: $user->id password changed successfully."); 
        }
        
        $this->respond($return);
    }

    /**
     * Logar com o Facebook
     * @param   Request     $request    Objeto de requisição
     * @param   Response    $response   Objeto de resposta
     * @return  Json
     */
    public function loginFacebook($request, $response)
    {
        $return = array();
        $params = $request->getParams();

        $this->respond($return);
    }

}
