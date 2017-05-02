<?php

namespace App\Controllers;

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
    }*/

    public function respond($value = array())
    {
        header('Content-Type: application/json; charset=utf-8');
        print json_encode($value);
    }
}
