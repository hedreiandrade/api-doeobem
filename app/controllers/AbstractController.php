<?php

namespace App\Controllers;

//use Slim\Slim as Slim;

abstract class AbstractController
{

    /*protected $container;

    public function __construct($container)
    {
        $this->container = $container;
    }

    public function __get($property)
    {
        if ($this->container->{$property}) {
            return $this->container->{$property};
        }
    }
    public $app;

    public function __construct()
    {
        $this->app = Slim::getInstance();
    }
    */
    public function respond($value = array())
    {
        header('Content-Type: application/json; charset=utf-8');
        print json_encode($value);
    }
}
