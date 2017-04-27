<?php

namespace App\Models;

class Users {

   public function insert(){
		//print_r( DBconnection()->query("select * from users")->fetchAll() );

   		//print_r( $this->db->table('users')->where('id', 10) );

        echo '-model/users-';
   }

}
