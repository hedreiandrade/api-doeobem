<?php

// Configuração para envio de email 
const HOST = 'smtp.elasticemail.com';
const PORT = 2525;
const SMTPAUTH = true;
const SMTPSECURE = 'tls';
const EMAILUSER = 'leonardo@kelda.com.br';
const EMAILPASSWORD = '6709eb1c-960a-4a33-ba34-008992fdfdb5';
const EMAILTO = 'hedreiandrade@gmail.com'; 
const EMAILTO2 = 'leonardo@kelda.com.br'; 
const EMAILTO3 = '';

/* 
 *  Selecione configuração para Banco conforme ambiente
    Assunto : Merging Configurations
 *  1  --->   Homologa  
 *  2  --->   Produção  
 */
const ENVIRONMENT = 2;

if(ENVIRONMENT == 1) {
    $dbConfig = array(
        'database' => array(
            'adapter'     => 'Mysql',
            'host'        => '', 
            'username'    => '', 
            'password'    => '',
            'dbname'      => '',
            'charset'     => 'utf8'
        ),
    );
}
if(ENVIRONMENT == 2) {
    $dbConfig = array(
        'database' => array(
            'adapter'     => 'Mysql',
            'host'        => '127.0.0.1;',
            'username'    => 'root', 
            'password'    => 'root', 
            'dbname'      => 'donatethegood', 
            'charset'     => 'utf8' 
        ),
    );
}
/*static public function DBconnection(){
	$db = new PDO($dbConfig);
	$db->setAttribute( \PDO::ATTR_ERRMODE,\PDO::ERRMODE_EXCEPTION );

	return $db ;
}*/

