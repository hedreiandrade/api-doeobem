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
        $result = $this->activeModel->get();
        return $this->respond($result);
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
        $id = $request->getAttribute('id', false);
        $return = array();
        if ($id) {
            $return = $this->activeModel->where('id', '=', $id)->get();
        }
        if (count($return) > 0) {
            return $this->respond($return);
        } else {
            return $this->respond(array('response'=>"id: $id não encontado o mesmo pode ter sido deletado anteriormente"));
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

        return $this->respond(array('id' => $return->id));
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
        // Verifica existencia do registro
        $id = $request->getAttribute('id');
        $model = $this->activeModel->find($id);
        if (!isset($model)) {
            $result = array('response'=>"id: $id não encontado o mesmo pode ter sido deletado anteriormente");
            return $this->respond($result);
        }
        // Verifica criterios para atualização
        $model->fill($params);
        if ($request->getAttribute('has_errors')) {
            $return = $request->getAttribute('errors');
            $this->respond($return);
        }
        // Atualiza registro
        if ($model->save()) {
            $return = array('response'=>"id: $id atualizado com sucesso.");
        } else {
            $return = array('response'=>"ERRO: id: $id não pode ser atualizado.");
        }

        return $this->respond($return);
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
            $return = array('response'=>"id: $id não encontado o mesmo pode ter sido deletado anteriormente");
            return $this->respond($return);
        }
        // Deleta
        if ($model->delete()) {
            $return = array('response'=>"id: $id deletado com sucesso.");
        } else {
            $return = array('response'=>"ERRO: id: $id não pode ser deletado.");
        }

        return $this->respond($return);
    }
}
