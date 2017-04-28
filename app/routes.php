<?php


// chamando controller que passa por model e printa retorno do model
// sem interacao com o view
$app->get('/', 'homeController:index');

// chamando view direto sem passar pelo model
$app->get('/home', function ($request, $response) {

    return $this->view->render($response, 'home.twig');

});

$app->get('/users', function ($request, $response) {

    return 'Listar usuarios cadastrados';

});