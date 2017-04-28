<?php


// chamando controller que passa por model e printa retorno do model
// sem interacao com o view
$app->get('/', 'homeController:index');

// Chamando controler que passa por model e retorna informacao
/// Verificar como enviar essa informacao array() para o home.html(view)
$app->get('/home', function ($request, $response) {

	$homeController = new homeController();
	$dataControlModelHome = $homeController->index();


    return $this->view->render($response, 'home.html' /*, $dataControlModelHome*/ );

});

$app->get('/users', function ($request, $response) {

    return 'Listar usuarios cadastrados';

});