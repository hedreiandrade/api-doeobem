<?php

$app->get('/', function ($request, $response) {
    return 'HOME';
});

$app->group('/v1', function () use ($app) {

    // Home
    $app->get('/', function ($request, $response) {
        return 'HOME V1';
    });

    // List all
    $app->get('/users', 'App\Controllers\UsersController:listing');

    // List by Id
    $app->get('/user/{id}', 'App\Controllers\UsersController:get');

    // Registry insert
    $app->post('/users', 'App\Controllers\UsersController:insert')
        ->add(App\Controllers\UsersController::getValidators());

    // Registry update
    $app->put('/user/{id}', 'App\Controllers\UsersController:update')
        ->add(App\Controllers\UsersController::getValidators());

    // Change Password
    $app->post('/changePassword', 'App\Controllers\UsersController:changePassword');

    // Login
    $app->post('/login', 'App\Controllers\UsersController:login');

    // Logout
    $app->post('/logout', 'App\Controllers\UsersController:logout');

    // Registry delete
    $app->delete('/user/{id}', 'App\Controllers\UsersController:delete');

    // Login with Facebbok
    $app->post('/loginFacebook', 'App\Controllers\UsersController:loginFacebook');

    //$facebook->api('/me/feed/', 'post', array('message' => 'I want to display this message on my wall'));

    /*

    //Recuperação de Senha - Na verdade envia md5 para alterar senha
    $app->post('/user/password-recovery', 'App\Controllers\UsersController:passwordRecovery')
        ->add(App\Controllers\UsersController::getValidators());

    */
});
