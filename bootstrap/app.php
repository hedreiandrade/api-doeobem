<?php

require __DIR__ . '/../vendor/autoload.php';

session_start();

$app = new \Slim\App([
  'settings' => [
        'displayErrorDetails' => true ,
        'db' => [
            'driver' => 'mysql',
            'host' => '127.0.0.1',
            'database' => 'donatethegood',
            'username' => 'root',
            'password' => '',
            'charset' => 'utf8',
            'collation' => 'utf8_general_ci',
            'prefix' => ''
        ]
    ]
]);

$container = $app->getContainer();

$capsule = new \Illuminate\Database\Capsule\Manager;
$capsule->addConnection($container['settings']['db']);
$capsule->setAsGlobal();
$capsule->bootEloquent();
$container['db'] = function ($container) use ($capsule) {
    return $capsule;
};

$container['UsersController'] = function ($container) {
    return new \App\Controllers\UsersController($container);
};

require __DIR__ . '/../app/routes.php';
