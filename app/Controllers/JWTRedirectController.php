<?php
/*
 * @author Hedrei Andrade <hedreiandrade@gmail.com>
 * @Version 1.0.0
 */
namespace App\Controllers;

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

class JWTRedirectController
{

    public function verifyTokenRedirect($request) {
        $params = $request->getParams();
        if($params['token'] == ''){
            http_response_code(200);
            $this->respond(['message' => 'Por favor forneceder token', 'status'=> 401]);
        }
        try {
            JWT::decode($params['token'], new Key(JWT_SECRET, 'HS256'));
        } catch(\Exception $e) {
            http_response_code(200);
            $this->respond(['message' => $e->getMessage(), 'status'=> 401]);
        }
        http_response_code(200);
        return $this->respond(['message' => 'Validado', 'status'=> 200]);
    }

    public function respond($value = array())
    {
        header('Content-type: application/json');
        print json_encode($value);
        die;
    }
}