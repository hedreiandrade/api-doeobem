<?php

require __DIR__ . '/../vendor/autoload.php';

# === Para mostrar todos erros
error_reporting(E_ERROR | E_WARNING | E_PARSE | E_NOTICE);
ini_set('display_errors', 'On');

# === Session
session_cache_limiter(false);
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

$services = new SlimServices\ServiceManager( $app );
$services->registerServices(array(
  'Illuminate\Events\EventServiceProvider',
  'Illuminate\Database\DatabaseServiceProvider',
  'Illuminate\Filesystem\FilesystemServiceProvider',
  'Illuminate\Translation\TranslationServiceProvider',
  'Illuminate\Validation\ValidationServiceProvider'
));

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

# === Slim Services
//require __DIR__ . '/../app/config/services.php';

require __DIR__ . '/../app/routes.php';
