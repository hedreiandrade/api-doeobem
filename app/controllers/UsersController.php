<?php

namespace App\Controllers;

use App\Models\Users;

class UsersController extends AbstractController
{
    public function index($request, $response)
    {
        $users = new \App\Models\Users;
        $id = $request->getAttribute('id');
        $result = array();

        if ($id) {
            $result = $users->findById($id);
        } else {
            $result = $users->findAll();
        }

        return $this->respond($result);
    }

    public function insert($request, $response)
    {
    }

    public function update($request, $response)
    {
    }

    public function delete($request, $response)
    {
    }
}
