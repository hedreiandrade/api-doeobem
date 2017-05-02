<?php

$app->get('/', function ($request, $response) {
    return 'HOME';
});

$app->get('/users', function ($request, $response) {
    $userController = new \App\Controllers\UsersController;
    $jsonUsers = $userController->index($request, $response);

    return $jsonUsers;
});

$app->get('/users/{id}', function ($request, $response) {

    $userController = new \App\Controllers\UsersController;
    $jsonUser = $userController->index($request, $response);

    return $jsonUser;
});
