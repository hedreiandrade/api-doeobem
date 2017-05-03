<?php
// Root
$app->get('/', function ($request, $response) {
    return 'HOME';
});
// List all
$app->get('/users', function ($request, $response) {
    $userController = new \App\Controllers\UsersController;
    $jsonUsers = $userController->index($request, $response);

    return $jsonUsers;
});
// List by ID
$app->get('/users/{id}', function ($request, $response) {
    $userController = new \App\Controllers\UsersController;
    $jsonUser = $userController->index($request, $response);

    return $jsonUser;
});
// Insert user
$app->post('/users', function ($request, $response) {
    $userController = new \App\Controllers\UsersController;
    $jsonUpdatedUser = $userController->insert($request, $response);

    return $jsonUpdatedUser;
});
// Update user
$app->put('/users/{id}', function ($request, $response) {
    $userController = new \App\Controllers\UsersController;
    $jsonUpdatedUser = $userController->update($request, $response);

    return $jsonUpdatedUser;
});
// Delete user
$app->delete('/users/{id}', function ($request, $response) {
    $userController = new \App\Controllers\UsersController;
    $jsonDeletedUser = $userController->delete($request, $response);

    return $jsonDeletedUser;
});
