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
     * @return  null
     */
    public function __construct($container)
    {
    }

    /**
     * Retorna um objeto \DavidePastore\Slim\Validation\Validation,
     * com as regras de validação default do controller.
     *
     * @return \DavidePastore\Slim\Validation\Validation
     */
    //abstract public static function getValidators();

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
        if(count($return) == 0){
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
        if (count($return) > 0) {
            $this->respond($return);
        } else {
            $this->respond(array('response'=>"id: $id not found the same may have been previously deleted."));
        }
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
        // Apenas para inserção de senhas
        if (isset($params['password'])) {
            $params['password'] = $this->hidePassword($params['password']);
        }
        // Verifica formação básica de email
        // Não setado ou errado fica por conta do fill
        if(isset($params['email']))
            $this->checkEmail($params['email']);
        // Verifica criterios para inserção
        $this->activeModel->fill($params);
        if ($request->getAttribute('has_errors')) {
            $return = $request->getAttribute('errors');
            $this->respond($return);
        } else {
          //No errors-return
        }
        // Usar create para retornar id do registro
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
        // Apenas para inserção de senhas
        if (isset($params['password'])) {
            $params['password'] = $this->hidePassword($params['password']);
        }
        // Verifica formação básica de email
        if(isset($params['email']))
            $this->checkEmail($params['email']);
        // Verifica existencia do registro
        $id = $request->getAttribute('id');
        $model = $this->activeModel->find($id);
        if (!isset($model)) {
            $result = array('response'=>"id: $id not found the same may have been previously deleted.");
            $this->respond($result);
        }
        // Verifica criterios para atualização
        $model->fill($params);
        if ($request->getAttribute('has_errors')) {
            $return = $request->getAttribute('errors');
            $this->respond($return);
        }
        // Atualiza registro
        if ($model->save()) {
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
     * Chama verificação básica para email
     *
     * @param   email     email a ser validado
     *
     * @return  boolean
     */
    public function checkEmail($email = '')
    {
        $validatedEmail = $this->errorEmail($email);
        if(!$validatedEmail['flEmail']){
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

        if(!isset($email)){
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
