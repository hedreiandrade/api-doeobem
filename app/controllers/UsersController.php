<?php

namespace App\Controllers;

use App\Models\Users;
use Illuminate\Support\Facades\Validator as Validator;
//use Validator;

class UsersController extends AbstractController
{

    private function getUsersValidationRules()
    {
        return array(
            'name' => 'required',
            'email' => 'required', // |email|unique:users
            'password' => 'required|min:8'
        );
    }

    private function getUsersValidationMessages()
    {
        return array(
            'required' => 'O campo :attribute é obrigatorio',
            'integer' => 'O campo :attribute deve ser inteiro',
            'exists' => 'O valor do campo :attribute deve exitir na tabela: :exists',
            'string' => 'O campo :attribute deve ser texto',
            'max' => 'O campo :attribute deve ter o tamanho máximo de :max caracteres'
        );
    }

    private function usersValidationFails($params)
    {
        $post      = $params;
        $rules     = $this->getUsersValidationRules();
        $messages  = $this->getUsersValidationMessages();
        
        die('HAHHAHAAH');

        $validator = $this->app->validator->make($post, $rules, $messages);

        //print_r($validator);
        //die('validator');

        return $validator->fails() ? $validator->errors()->getMessages() : false;
    }

    // Lista de Usuarios(Com deleted_at null)
    public function index($request, $response)
    {
        $id = $request->getAttribute('id');
        $result = array();
        if ($id) {
            $result = Users::where('id', '=', $id)
                           ->get();
        } else {
            $result = Users::get();
        }

        return $this->respond($result);
    }
    // Inserindo Usuarios
    public function insert($request, $response)
    {
        $params = $request->getQueryParams();

        print_r( $this->usersValidationFails($params) );
        
        $users = new Users();
        if (isset($params['name'])) {
            $users->name =  $params['name'];
        }
        if (isset($params['nickname'])) {
            $users->nickname =  $params['nickname'];
        }
        if (isset($params['phone1'])) {
            $users->phone1 =  $params['phone1'];
        }

        return $this->respond($users->save());
    }
    // Alterando Usuarios
    public function update($request, $response)
    {
        $id = $request->getAttribute('id');
        $params = $request->getQueryParams();
        $users = Users::find($id);

        if (isset($params['name'])) {
            $users->name =  $params['name'];
        }
        if (isset($params['nickname'])) {
            $users->nickname =  $params['nickname'];
        }
        if (isset($params['phone1'])) {
            $users->phone1 =  $params['phone1'];
        }

        return $this->respond($users->save());
    }
    // Seta a data de remoção(deleted_at)
    public function delete($request, $response)
    {
        $id = $request->getAttribute('id');
        $user = new Users();
        $user = $user->find($id);
        
        return $this->respond($user->delete());
    }
}
