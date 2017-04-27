<?php


$app->get('/', 'homeController:index');


$app->get('/home', function ($request, $response) {


    return $this->view->render($response, 'home.twig');

});

$app->get('/users', function ($request, $response) {


    return 'Listar usuarios cadastrados';

});