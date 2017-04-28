<?php

namespace App\Controllers;

use Slim\Views\Twig as View;

class HomeController extends Controller {

	public function index($request, $response) {
		$modelHome = new \App\Models\Home;
		$data = $modelHome->index();

		//$user = $this->db->table('users')->where('id', 1) ;
		//var_dump($user);
		//http://api-doeobem:8888/public/?name=hedrei
		//var_dump($request->getPaam('name'));
		print_r($data);

		/// Como enviar essa informacao $data array() para home.html(view) ?
		return $this->view->render($response, 'home.html'/*, $data*/);
	}

}
