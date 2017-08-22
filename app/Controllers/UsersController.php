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
                'password' => v::notEmpty()->noWhitespace()->length(1, 200),
                //'state' => v::noWhitespace()->length(1, 3),
                //'country' => v::noWhitespace()->length(1, 2)
            ]
        );
    }

    /**
     * Retorna chave de autenticação do usuario logado
     * @param   Request     $request    Objeto de requisição
     * @param   Response    $response   Objeto de resposta
     * @return Array
     */
    public function login($request, $response)
    {
        $return = array();
        $params = $request->getParams();

        // Verifica se foi informado email e senha
        if (!isset($params['email']) || !isset($params['password'])) {
            $return = array('response'=>"Please, give me your email and password.");
        }

        // Verifica existencia do usuario
        $user = Users::where('email', $params['email'])->first();
        if (!$user) {
            $userEmail = $params['email'];
            $return = array('response'=>"The email you’ve entered: $userEmail doesn’t match any account. Sign up for an account.");
        }

        return $this->respond($return);
    }
}
