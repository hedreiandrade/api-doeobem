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
                'name' => v::alnum()->noWhitespace()->length(1, 10),
                'phone1' => v::numeric()->positive()->between(1, 20)
            ]
        );
    }
}
