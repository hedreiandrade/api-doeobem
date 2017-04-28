<?php

namespace App\Controllers;

use Slim\Views\Twig as View;

class HomeController extends Controller {

	public function index($request, $response) {
		//http://api-doeobem:8888/public/?name=hedrei
		//var_dump($request->getParam('name'));

		$home = new \App\Models\Home;
		$data = $home->index();

		print_r( $home->index());

		return $this->view->render($response, 'home.twig', $data);
	}

}
