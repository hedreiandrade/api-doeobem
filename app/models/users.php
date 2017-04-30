<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Users extends Model
{
	protected $table = 'users';

	/*protected $fillable [
		'name'
	];*/

    public function findAll()
    {
    	$users = array();
    	$users = Users::all();

        return $users;
    }

    public function findById($id)
    {
    	$users = array();
        $users = Users::where('id', $id)->first();

        return $users;
    }
}
