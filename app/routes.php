<?php
/*
 * @author Hedrei Andrade <hedreiandrade@gmail.com>
 * @Version 1.0.0
 */
$app->get('/', function ($request, $response) {
    return 'HOME';
});

// Registry Insert
$app->post('/v1/user', 'App\Controllers\UsersController:insert')
    ->add(App\Controllers\UsersController::getValidators());

// Login
$app->post('/v1/login', 'App\Controllers\UsersController:login');

// Verify token
$app->post('/v1/verifyTokenRedirect', 'App\Controllers\UsersController:verifyTokenRedirect');

$app->group('/v1', function () use ($app) {
    // Home
    $app->get('/', function ($request, $response) { return 'HOME V1';});
    // List with page and perPage
    $app->get('/users/{page}/{perPage}', 'App\Controllers\UsersController:listing');

    // List by Id
    $app->get('/user/{id}', 'App\Controllers\UsersController:get');

    // Registry Update
    $app->post('/user/{id}', 'App\Controllers\UsersController:update')
        ->add(App\Controllers\UsersController::getValidators());

    // Registry Delete
    $app->delete('/user/{id}', 'App\Controllers\UsersController:delete');

    // Change Password
    $app->post('/changePassword', 'App\Controllers\UsersController:changePassword');

    // Logout
    $app->post('/logout', 'App\Controllers\UsersController:logout');

    // Login with Facebbok
    $app->post('/loginFacebook', 'App\Controllers\UsersController:loginFacebook');

    // Login with Gmail
    $app->post('/loginGmail', 'App\Controllers\UsersController:loginGmail');
    
})->add($app->getContainer()->get('Authenticate'));
