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

    public function findById()
    {
    	$users = array();
        $users = Users::where('id', 1)->first();

        return $users;
    }
}
