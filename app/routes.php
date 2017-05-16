<?php

$app->get('/', function ($request, $response) {
    return 'HOME';
});

$app->group('/v1', function () use ($app) {
    $app->get('/', function ($request, $response) {
        return 'HOME V1';
    });

    // Users
    $app->get('/users', 'App\Controllers\UsersController:listing');
    $app->get('/users/{id}', 'App\Controllers\UsersController:get');
    $app->delete('/users/{id}', 'App\Controllers\UsersController:delete');
    $app->post('/users', 'App\Controllers\UsersController:insert')
        ->add(App\Controllers\UsersController::getValidators());
    $app->put('/users/{id}', 'App\Controllers\UsersController:update')
        ->add(App\Controllers\UsersController::getValidators());

    // Login
    // Logout
    // Esqueci a senha
    // Resetar senha
});
