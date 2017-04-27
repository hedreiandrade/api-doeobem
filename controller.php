<?php

namespace App\Controllers;

class HomeController {

   public function index($request, $response){

   	//http://api-doeobem:8888/public/?name=hedrei
   	//var_dump($request->getParam('name'));

   	return 'Home controller';

   }

}
