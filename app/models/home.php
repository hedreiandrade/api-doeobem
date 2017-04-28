<?php

namespace App\Models;

class Home {

	public function index(){

		$data = array();

		$data = array ( 'Models/Home' => 'true' );

		return $data ;
	}
   
}
