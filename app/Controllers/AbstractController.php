<?php

namespace App\Controllers;

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
        $route = $container->request->getUri()->getPath();
        if(isset($route) && $route === '/v1/logout') {
            //session_start();
            session_unset();
            // Bug session_destroy
            if(isset($_SESSION['user'])) { 
                session_destroy();
            }
            session_write_close();
        } else {
            // Login deixa passar
            if(isset($route) && $route === '/v1/login') {
                return;
            }
            // Outros metodos verifica o tempo de login
            if($this->checkSessionTime()) {
                // Login ainda valido
                return;
            }else {
                // Expirado
                $this->respond(array('response'=>'Please log in to access Login API.'));
            }
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
     * Controla tempo da sessão de login
     * session.gc_maxlifetime doesn’t work ?
     *
     * @return boolean
     */
    public function checkSessionTime() 
    {
        $timeOutDuration = 3600; // Segundos 3600
        session_start();
        if(!isset($_SESSION['timeout'])) {
            return false;
        }
        // Calcula o tempo da sessão
        $timeOfExistence = time() - (int) $_SESSION['timeout'];
        if($timeOfExistence > $timeOutDuration) {
            session_unset();
            session_destroy();
            return false;
        }else { 
            // Sessão ainda é valida
            return true;
        }
    }

    /**
     * Criar Hash para esconder senhas
     *
     * @param   string     $password    Senha
     *
     * @return  string
     */
    public function hidePassword($password)
    {
        $hiddenPassword = '';
        // Apenas para inserção de senhas
        if (isset($password)) {
            $hiddenPassword = password_hash($password, PASSWORD_DEFAULT);
        }

        return $hiddenPassword;
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
        // Caso não encontre nenhum registro
        if (count($return) == 0) {
            $return = array('response'=>"No Users Found.");
        }
        
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
            $return = $this->activeModel->where('id', '=', $id)->get();
        }
        if (count($return) == 0) {
            $return = array('response'=>"id: $id not found the same may have been previously deleted.");
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
        // Apenas para inserção de senhas
        if (isset($params['password'])) {
            $params['password'] = $this->hidePassword($params['password']);
        }
        // Verifica formatação básica de email
        if (isset($params['email'])) {
            $this->checkEmail($params['email']);
        }
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
        // Apenas para inserção de senhas
        if (isset($params['password'])) {
            $params['password'] = $this->hidePassword($params['password']);
        }
        // Verifica formação básica de email
        if (isset($params['email'])) {
            $this->checkEmail($params['email']);
        }
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
}
