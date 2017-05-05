<?php

use SlimServices\ServiceManager;
$services = new ServiceManager( $app );
$services->registerServices(array(
  'Illuminate\Events\EventServiceProvider',
  'Illuminate\Database\DatabaseServiceProvider',
  'Illuminate\Filesystem\FilesystemServiceProvider',
  'Illuminate\Translation\TranslationServiceProvider',
  'Illuminate\Validation\ValidationServiceProvider'
));
