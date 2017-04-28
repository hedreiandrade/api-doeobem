<?php

namespace App\Controllers;

use Slim\Views\Twig as View;

class HomeController extends Controller {

	public function index($request, $response) {
		$home = new \App\Models\Home;
		$data = $home->index();

		print_r( $home->index());
		//http://api-doeobem:8888/public/?name=hedrei
		//var_dump($request->getPaam('name'));

		/// Como enviar essa informacao $data array() para home.html(view) ?
		return $this->view->render($response, 'home.html', $data);
	}

}
