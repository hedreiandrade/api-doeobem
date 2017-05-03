<?php

namespace App\Controllers;

use App\Models\Users;

class UsersController extends AbstractController
{
    // Lista de Usuarios(Com removal_date null)
    public function index($request, $response)
    {
        $id = $request->getAttribute('id');
        $result = array();
        if ($id) {
            $result = Users::where('id', '=', $id)
                           ->whereNull('deleted_at')
                           ->get();
        } else {
            $result = Users::whereNull('deleted_at')
                           ->get();
        }

        return $this->respond($result);
    }
    // Inserindo Usuarios
    public function insert($request, $response)
    {
        $params = $request->getQueryParams();
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
    // Seta a data de remoção(removal_date)
    public function delete($request, $response)
    {
        $id = $request->getAttribute('id');
        $user = new Users();
        $user = $user->find($id);
        
        return $this->respond($user->delete());
    }
}
