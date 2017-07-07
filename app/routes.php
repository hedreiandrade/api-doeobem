<?php

$app->get('/', function ($request, $response) {
    return 'HOME';
});

$app->group('/v1', function () use ($app) {

    // Home
    $app->get('/', function ($request, $response) {
        return 'HOME V1';
    });

    // Lista todos
    $app->get('/users', 'App\Controllers\UsersController:listing');

    // Lista por Id
    $app->get('/users/{id}', 'App\Controllers\UsersController:get');

    // Alteração do registro'
    $app->put('/users/{id}', 'App\Controllers\UsersController:update')
        ->add(App\Controllers\UsersController::getValidators());

    // Inserção do registro
    $app->post('/users', 'App\Controllers\UsersController:insert')
        ->add(App\Controllers\UsersController::getValidators());

    // Deleta registro
    $app->delete('/users/{id}', 'App\Controllers\UsersController:delete');

    // Login
    $app->post('/login', 'App\Controllers\UsersController:login');

    /*

    // Logout
    $app->post('/user', 'App\Controllers\UsersController:logout')
        ->add(App\Controllers\UsersController::getValidators());

    //Recuperação de Senha - Na verdade envia md5 para alterar senha
    $app->get('/user/password-recovery', 'App\Controllers\UsersController:passwordRecovery')
        ->add(App\Controllers\UsersController::getValidators());

    // Alterar Senha
    $app->put('/user/password-reset', 'App\Controllers\UsersController:passwordReset')
        ->add(App\Controllers\UsersController::getValidators());

    */
});
