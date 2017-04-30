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

    	if($id){
    			$result = $users->findById();
    	}else{
    		$result = $users->findAll();
    	}

        //print_r( $this->db->table('users')->find(1) );
        //print_r( Users::find(1)->name );
        //die('---');

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
