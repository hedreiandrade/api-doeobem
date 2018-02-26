<?php

namespace App\Controllers;

use Datetime;
use Firebase\JWT\JWT;

abstract class AbstractController
{
    
    /**
     * Construtor
     *
     * @var Abstract elequent Model
     *
     * @return  null
     */
    protected $activeModel = null;

    /**
     * Construtor
     *
     * @param   Slim\Container    $Container    Container da aplicação
     *
     * @return  
     */
    public function __construct($container)
    {
        $token = '';
        $route = $container->request->getUri()->getPath();
        // Login deixa passar
        if(isset($route) && $route === '/v1/login') {
            return;
        } else {
            // Baerer Token ou OAuth 2.0
            if(isset($container->request->getHeaders()['HTTP_AUTHORIZATION'][0])){
                $token = $container->request->getHeaders()['HTTP_AUTHORIZATION'][0];
            } 
            // Pega token
            if(isset(explode('Bearer ', $token)[1])){
                $token = explode('Bearer ', $token)[1];
            }
            // Verifica validade do token
            // Caso não expirou continua
            $this->verifyToken($token);
        }
    }

    /**
     * Factory que gera uma instância do controller
     *
     * @return  AbstractController
     */
    public static function make()
    {
        return new static;
    }

    public function respond($value = array())
    {
        header('Content-type: application/json');
        print json_encode($value);
        die;
    }

    /**
     * Esconder senhas
     *
     * @param   string     $password    Senha
     *
     * @return  string
     */
    public function hidePassword($password)
    {
        return password_hash($password, PASSWORD_DEFAULT);
    }

    /**
     * Verifica token fornecido
     * Usar tipos Baerer Token ou OAuth 2.0
     *
     * @param   String     $token    Token
     *
     * @return Json
     */
    public function verifyToken($token = '') {
        $return = '';
        if( $token === '') {
            $return = array('response'=>'Please give me a token authorization.');
            $this->respond($return);
        }
        try {
            /* 
                Erros que podem ser retornados no decode
                caso token esteja com erro de digitação:
                UnexpectedValueException | Message: Wrong number of segments
                DomainException | Message: Unexpected control character found
                SignatureInvalidException | Message: Signature verification failed
                Retorno apenas o de ExpiredException
            */
            JWT::decode($token, JWT_SECRET, array('HS256'));
        } catch (\Firebase\JWT\ExpiredException $e) { 
            // Expirou JWT
            $return = array('response'=>$e->getMessage());
            $this->respond($return);
        }
    }

    /**
     * Cria um novo token
     *
     * @return string|Json
     */
    public function createToken() {
        $return = array();
        JWT::$leeway = LEE_WAY;
        try {
            $payLoad = $this->payLoad();
            $return['token'] = JWT::encode($payLoad, JWT_SECRET);
            $return['expire'] = $payLoad['exp'];
            session_start();
            // Talvez seja errado fornecer token 
            // verdadeiro via session
            // JWT controla token por aplicação ?
            $_SESSION['token'] = '-.-';
            session_write_close();
            return $return;
        } catch (\Firebase\JWT\DomainException $e) { 
            $return = array('response'=>$e->getMessage());
            $this->respond($return);
        }
    }

    /**
     * Lista de registros específicos (Com deleted_at null)
     *
     * @param   Request     $request    Objeto de requisição
     * @param   Response    $response   Objeto de resposta
     *
     * @return  Json
     */
    public function listing($request, $response)
    {
        $return = $this->activeModel->get();
        
        $this->respond($return);
    }

    /**
     * Obtém um registro específico
     *
     * @param   Request     $request    Objeto de requisição
     * @param   Response    $response   Objeto de resposta
     *
     * @return  Json
     */
    public function get($request, $response)
    {
        $return = array();
        $id = $request->getAttribute('id', false);
        if ($id) {
            $return = $this->activeModel->whereKey($id)
                                        ->first();
            // Retorna null caso não exista
            // Passo para array []
            if(!$return){
                $return = [];
            }
        }

        $this->respond($return);
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
        $return = array();
        $params = $request->getParams();
        // Validações pre-definidas no controller
        $this->getAttributeErrors($request);
        // Esconde senhas
        $params['password'] = $this->hidePassword($params['password']);
        // Verifica formatação básica de email
        $this->checkEmail($params['email']);
        // Realiza inserção retornando id
        $return = $this->activeModel->create($params);
        $return = array('id' => $return->id);

        $this->respond($return);
    }

    /**
     * Altera um registro
     *
     * @param   Request     $request    Objeto de requisição
     * @param   Response    $response   Objeto de resposta
     *
     * @return  Json
     */
    public function update($request, $response)
    {
        $return = array();
        $params = $request->getParams();
        // Validações pre-definidas no controller
        $this->getAttributeErrors($request);
        // Esconde senhas
        $params['password'] = $this->hidePassword($params['password']);
        // Verifica formação básica de email
        $this->checkEmail($params['email']);
        // Verifica existência do registro
        $id = $request->getAttribute('id');
        $model = $this->activeModel->find($id);
        if (!isset($model)) {
            $result = array('response'=>"id: $id not found the same may have been previously deleted.");
            $this->respond($result);
        }
        // Enche model com os dados para o save
        $model->fill($params);
        if ($model->save()) { // Atualiza registro
            $return = array('response'=>"id: $id updated successfully.");
        } else {
            $return = array('response'=>"ERRO: id: $id can not be updated.");
        }

        $this->respond($return);
    }

    /**
     * Deleta um registro
     *
     * @param   Request     $request    Objeto de requisição
     * @param   Response    $response   Objeto de resposta
     *
     * @return  Json
     */
    public function delete($request, $response)
    {
        $return = array();
        // Verifica existencia do registro
        $id = $request->getAttribute('id');
        $model = $this->activeModel->find($id);
        if (!isset($model)) {
            $return = array('response'=>"id: $id not found the same may have been previously deleted.");
            $this->respond($return);
        }
        // Deleta
        if ($model->delete()) {
            $return = array('response'=>"id: $id deleted successfully.");
        } else {
            $return = array('response'=>"ERRO: id: $id can not be deleted.");
        }

        $this->respond($return);
    }

    /**
     * Verifica erros da validação
     * Validações pre-definidas no controller
     *
     * @return boolean|json 
     */
    public function getAttributeErrors($request)
    {
        $return = array();
        // Erros
        if ($request->getAttribute('has_errors')) {
            $return = $request->getAttribute('errors');
            $this->respond($return);
        }

        return true;
    }

    /**
     * Chama verificação básica para email
     *
     * @param   email     email a ser validado
     *
     * @return  boolean|json 
     */
    public function checkEmail($email = '')
    {
        $validatedEmail = $this->errorEmail($email);
        if (!$validatedEmail['flEmail']) {
            $this->respond(array('response'=>$validatedEmail['response']));
        }

        return true;
    }

    /**
     * Verifica validações básicas para email
     *
     * @param   email     email a ser validado
     *
     * @return  Array
     */
    public function errorEmail($email)
    {
        $return = array();
        if (!isset($email)) {
            $return = array('response'=>"Email address '$email' is considered invalid.",
                            'flEmail'=>0);
        }
        if (filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $return = array('response'=>"Email address '$email' is considered valid.",
                            'flEmail'=>1);
        } else {
            $return = array('response'=>"Email address '$email' is considered invalid.",
                            'flEmail'=>0);
        }

        return $return;
    }

    /**
     * Retorna array padrão para geração encode JWT
     *
     * @return  Array
     */
    public function payLoad() {
        $now = new DateTime();
        $future = new DateTime();
        $exp = new DateTime('+ 1 minutes');
        $payLoad = array(
            'iss' => 'http://github.com/hedreiandrade',
            'aud' => 'http://twitter.com',
            'iat' => $now->getTimeStamp(),
            'nbf' => $future->getTimeStamp(),
            'exp' => $exp->getTimeStamp()
        );

        return $payLoad;
    }

}
