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
    abstract public static function getValidators();

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
     * Lista de registros específicos (Com deleted_at null)
     *
     * @param   Request     $request    Objeto de requisição
     * @param   Response    $response   Objeto de resposta
     *
     * @return  null
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
     * @return  null
     */
    public function get($request, $response)
    {
        $id = $request->getAttribute('id', false);
        $result = array();

        if ($id) {
            $result = $this->activeModel->where('id', '=', $id)->get();
        }

        return $this->respond($result);
    }

    /**
     * Insere um registro
     *
     * @param   Request     $request    Objeto de requisição
     * @param   Response    $response   Objeto de resposta
     *
     * @return  null
     */
    public function insert($request, $response)
    {
        $this->activeModel->fill($request->getQueryParams());

        if ($request->getAttribute('has_errors')) {
            $errors = $request->getAttribute('errors');
            $this->respond($errors);
          
        } else {
          //No errors
        }

        return $this->respond($this->activeModel->save());
    }

    /**
     * Altera um registro
     *
     * @param   Request     $request    Objeto de requisição
     * @param   Response    $response   Objeto de resposta
     *
     * @return  null
     */
    public function update($request, $response)
    {
        $id = $request->getAttribute('id');
        $model = $this->activeModel->find($id);
        $model->fill($request->getQueryParams());

        return $this->respond($model->save());
    }

    /**
     * Deleta um registro
     *
     * @param   Request     $request    Objeto de requisição
     * @param   Response    $response   Objeto de resposta
     *
     * @return  null
     */
    public function delete($request, $response)
    {
        $id = $request->getAttribute('id');
        $model = $this->activeModel->find($id);
        
        return $this->respond($model->delete());
    }
}
