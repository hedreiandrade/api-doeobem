<?php

$app->get('/', function ($request, $response) {
    return 'HOME';
});

$app->group('/v1', function () use ($app) {

    // Home
    $app->get('/', function ($request, $response) {
        return 'HOME V1';
    });

    // List All
    $app->get('/users', 'App\Controllers\UsersController:listing');

    // List by Id
    $app->get('/user/{id}', 'App\Controllers\UsersController:get');

    // Registry Insert
    $app->post('/users', 'App\Controllers\UsersController:insert')
        ->add(App\Controllers\UsersController::getValidators());

    // Registry Update
    $app->put('/user/{id}', 'App\Controllers\UsersController:update')
        ->add(App\Controllers\UsersController::getValidators());

    // Change Password
    $app->post('/changePassword', 'App\Controllers\UsersController:changePassword');

    // Login
    $app->post('/login', 'App\Controllers\UsersController:login');

    // Logout
    $app->post('/logout', 'App\Controllers\UsersController:logout');

    // Registry Delete
    $app->delete('/user/{id}', 'App\Controllers\UsersController:delete');

    // Login with Facebbok
    $app->post('/loginFacebook', 'App\Controllers\UsersController:loginFacebook');

    // Login with Gmail
    $app->post('/loginGmail', 'App\Controllers\UsersController:loginGmail');
    
});
