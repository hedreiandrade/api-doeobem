<?php

require __DIR__ . '/../vendor/autoload.php';

// Config do Banco de Dados
require __DIR__ . '/../app/Config/db.php';

// Config para acesso APIs do google
require __DIR__ . '/../app/Config/google.php';

# === Para mostrar todos erros
error_reporting(E_ERROR | E_WARNING | E_PARSE | E_NOTICE);
ini_set('display_errors', 'On');

$app = new \Slim\App([
  'settings' => [
        'displayErrorDetails' => true,
        'db' => [
            'driver' => DRIVER,
            'host' => HOST,
            'database' => DATABASE,
            'username' => USERNAME,
            'password' => PASSWORD,
            'charset' => CHARSET,
            'collation' => COLLATION,
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

$container['UsersController'] = function ($app) {
    return new App\Controllers\UsersController($app);
};

require __DIR__ . '/../app/routes.php';
