<?php
/*
 * @author Hedrei Andrade <hedreiandrade@gmail.com>
 * @Version 1.0.0
 */
namespace App\Controllers;

use Datetime;
use Firebase\JWT\JWT;
use App\Models\Users;

abstract class BaseController
{
    
    /**
     * Construtor
     *
     * @var Abstract elequent Model
     *
     * @return  null
     */
    protected $activeModel = null;

    /**
     * Construtor
     *
     * @param   Slim\Container    $Container    Container da aplicação
     *
     * @return  
     */
    public function __construct($container)
    {
    }

    public function respond($value = array())
    {
        header('Content-type: application/json');
        print json_encode($value);
        die;
    }

    /**
     * Esconder senhas
     *
     * @param   string     $password    Senha
     *
     * @return  string
     */
    public function hidePassword($password)
    {
        return password_hash($password, PASSWORD_DEFAULT);
    }

    /**
     * Cria um novo token
     *
     * @return string|Json
     */
    public function createToken() {
        $return = [];

        JWT::$leeway = LEE_WAY;
        try {
            $payLoad = $this->payLoad();
            $return['token'] = JWT::encode($payLoad, JWT_SECRET, 'HS256');
            $return['expire'] = $payLoad['exp'];
            session_start();
            // Talvez seja errado fornecer token 
            // via session
            $_SESSION['token'] = '-.-';
            session_write_close();
            return $return;
        } catch (\Firebase\JWT\ExpiredException $e) { 
            $return = array('response'=>$e->getMessage());
            http_response_code(200);
            $this->respond($return);
        }
    }

    /**
     * Cria um novo token
     *
     * @return string|Json
     */
    public function createEmailToken() {
        $return = [];

        JWT::$leeway = LEE_WAY;
        try {
            $payLoad = $this->payLoad();
            $return['token'] = JWT::encode($payLoad, JWT_SECRET_EMAIL, 'HS256');
            $return['expire'] = $payLoad['exp'];
            session_start();
            // Talvez seja errado fornecer token 
            // via session
            $_SESSION['token'] = '-.-';
            session_write_close();
            return $return;
        } catch (\Firebase\JWT\ExpiredException $e) { 
            $return = array('response'=>$e->getMessage());
            http_response_code(200);
            $this->respond($return);
        }
    }

        /**
     * Cria um novo token
     *
     * @return string|Json
     */
    public function createEmailForgotToken() {
        $return = [];

        JWT::$leeway = LEE_WAY;
        try {
            $payLoad = $this->payLoad();
            $return['token'] = JWT::encode($payLoad, JWT_SECRET_EMAIL_FORGOT, 'HS256');
            $return['expire'] = $payLoad['exp'];
            session_start();
            // Talvez seja errado fornecer token 
            // via session
            $_SESSION['token'] = '-.-';
            session_write_close();
            return $return;
        } catch (\Firebase\JWT\ExpiredException $e) { 
            $return = array('response'=>$e->getMessage());
            http_response_code(200);
            $this->respond($return);
        }
    }

    /**
     * Lista de registros específicos (Com deleted_at null)
     *
     * @param   Request     $request    Objeto de requisição
     * @param   Response    $response   Objeto de resposta
     *
     * @return  Json
     */
    public function listing($request, $response)
    {
        $page = $request->getAttribute('page', false);
        $perPage = $request->getAttribute('perPage', false);

        $return = $this->activeModel->paginate($perPage, $columns = ['*'], 'page', $page);

        $this->respond($return);
    }

    /**
     * Obtém um registro específico
          * @param   Request     $request    Objeto de requisição
     * @param   Response    $response   Objeto de resposta
     *
     * @return  Json
     */
    public function get($request, $response)
    {
        $return = [];

        $id = $request->getAttribute('id', false);
        if ($id) {
            $return = $this->activeModel->whereKey($id)
                                        ->first();
            // Retorna null caso não exista
            // Passo para array []
            if(!$return) {
                $return = [];
            }
        }
        http_response_code(200);
        $this->respond($return);
    }

    /**
     * Insere um registro
     *
     * @param   Request     $request    Objeto de requisição
     * @param   Response    $response   Objeto de resposta
     *
     * @return  Json
     */
    public function insert($request, $response)
    {
        $return = [];
        
        $params = $request->getParams();
        // Validações pre-definidas no controller
        $this->getAttributeErrors($request);
        // Verifica se e-mail já não está registrado
        $this->checkEmailRegistered($params['email']);
        // Esconde senhas
        if(isset($params['password'])){
            $params['password'] = $this->hidePassword($params['password']);     
        }
        if(isset($_FILES['photo'])){
            $directory = PUBLIC_PATH.'/images/profile';
            if (!is_dir($directory)) {
                mkdir($directory, 0777, true);
            }
            $file = $_FILES['photo'];
            $imageName = rand().$file['name'];
            move_uploaded_file($file['tmp_name'], PUBLIC_PATH.'/images/profile/'.$imageName);
            $params['photo'] = URL_PUBLIC.'/images/profile/'.$imageName;
        }
        // Verifica formatação básica de e-mail
        $this->checkEmail($params['email']);
        // Realiza inserção retornando id
        $return = $this->activeModel->create($params);
        $return = array('id' => $return->id);
        http_response_code(201);
        $this->respond($return);
    }

    /**
     * Altera um registro
     *
     * @param   Request     $request    Objeto de requisição
     * @param   Response    $response   Objeto de resposta
     *
     * @return  Json
     */
    public function update($request, $response)
    {
        $return = [];
        try{
            $params = $request->getParams();
            $id = $request->getAttribute('id');
            // Verifica se e-mail já não está registrado
            if(isset($params['email'])){
                $this->checkEmailRegisteredUpdate($params['email'], $id);
            }
            // Esconde senhas
            if(isset($params['password'])){
                $params['password'] = $this->hidePassword($params['password']);
            }
            if(isset($_FILES['photo'])){
                $directory = PUBLIC_PATH.'/images/profile';
                if (!is_dir($directory)) {
                    mkdir($directory, 0777, true);
                }
                $file = $_FILES['photo'];
                $imageName = rand().$file['name'];
                move_uploaded_file($file['tmp_name'], PUBLIC_PATH.'/images/profile/'.$imageName);
                $params['photo'] = URL_PUBLIC.'/images/profile/'.$imageName;
            }
            if(isset($_FILES['cover_photo'])){
                $directory = PUBLIC_PATH.'/images/cover';
                if (!is_dir($directory)) {
                    mkdir($directory, 0777, true);
                }
                $file = $_FILES['cover_photo'];
                $imageName = rand().$file['name'];
                move_uploaded_file($file['tmp_name'], PUBLIC_PATH.'/images/cover/'.$imageName);
                $params['cover_photo'] = URL_PUBLIC.'/images/cover/'.$imageName;
            }
            // Verifica formação básica de e-mail
            if(isset($params['email'])){
                $validatedEmail = $this->errorEmail($params['email']);
                if (!$validatedEmail['flEmail']) {
                    $this->respond(array('status' => 401, 'response'=>$validatedEmail['response']));
                }
            }
            // Verifica existência do registro
            $model = $this->activeModel->find($id);
            if (!isset($model)) {
                $result = array('response'=>"id: $id not found the same may have been previously deleted.");
                $this->respond($result);
            }
            // Enche model com os dados para o save
            $model->fill($params);
            if ($model->save()) { // Atualiza registro
                $return = $model->toArray();
            } else {
                $return = array('response'=>"ERRO: id: $id can not be updated.");
            }
        }catch (\Exception $e) {
            $return = array('status' => 401,
                        'response' => 'An error occurred while update profile');
             $this->respond($return);
        }
        http_response_code(200);
        $this->respond($return);
    }

    /**
     * Deleta um registro
     *
     * @param   Request     $request    Objeto de requisição
     * @param   Response    $response   Objeto de resposta
     *
     * @return  Json
     */
    public function delete($request, $response)
    {
        $return = [];

        // Verifica existência do registro
        $id = $request->getAttribute('id');
        $model = $this->activeModel->find($id);
        if (!isset($model)) {
            $return = array('response'=>"id: $id not found the same may have been previously deleted.");
            $this->respond($return);
        }
        // Deleta
        if ($model->delete()) {
            $return = array('response'=>"id: $id deleted successfully.");
        } else {
            $return = array('response'=>"ERRO: id: $id can not be deleted.");
        }

        http_response_code(200);
        $this->respond($return);
    }

    /**
     * Verifica erros da validação
     * Validações pre-definidas no controller
     *
     * @return boolean|json 
     */
    public function getAttributeErrors($request)
    {
        $return = [];

        // Erros
        if ($request->getAttribute('has_errors')) {
            $return = $request->getAttribute('errors');
            $this->respond($return);
        }

        return true;
    }

    /**
     * Verifica se e-mail já não está registrado
     * Pode dar erro de senha pq pega o 1º e-mail
     * e poderia ter o mesmo e-mail com outra senha
     * se não existisse essa conferencia =)
     *
     * @param   e-mail para verificar existência
     *
     * @return  boolean|json 
     */
    public function checkEmailRegistered($email = '')
    {
        $user = Users::where('email', $email)->first();
        if($user) {
            $result = array('response'=>"There is an account for this e-mail, try to recover your password.");
            $this->respond($result);
        }
        return true;
    }

        /**
     * Verifica se e-mail já não está registrado
     * Pode dar erro de senha pq pega o 1º e-mail
     * e poderia ter o mesmo e-mail com outra senha
     * se não existisse essa conferencia =)
     *
     * @param   e-mail para verificar existência
     *
     * @return  boolean|json 
     */
    public function checkEmailRegisteredUpdate($email = '', $id)
    {
        $user = Users::find($id);
        if($user->email === $email){
            return true;
        }else{
            $otherUser = Users::where('email', $email)->first();
            if($otherUser){
                http_response_code(203);
                $result = array('status' => 203, 'response'=>"There is an account for this e-mail, try to recover your password.");
                $this->respond($result);
            }else{
                return true;
            }
        }
        return true;
    }

    /**
     * Chama verificação básica para e-mail
     *
     * @param   e-mail a ser validado
     *
     * @return  boolean|json 
     */
    public function checkEmail($email = '')
    {
        $validatedEmail = $this->errorEmail($email);
        if (!$validatedEmail['flEmail']) {
            $this->respond(array('response'=>$validatedEmail['response']));
        }

        return true;
    }

    /**
     * Verifica validações básicas para e-mail
     *
     * @param   e-mail     e-mail a ser validado
     *
     * @return  Array
     */
    public function errorEmail($email)
    {
        $return = [];

        if (!isset($email)) {
            $return = array('response'=>"E-mail address '$email' is considered invalid.",
                            'flEmail'=>0);
        }
        if (filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $return = array('response'=>"E-mail address '$email' is considered valid.",
                            'flEmail'=>1);
        } else {
            $return = array('response'=>"E-mail address '$email' is considered invalid.",
                            'flEmail'=>0);
        }

        return $return;
    }

    /**
     * Retorna array padrão para geração encode JWT
     *
     * @return  Array
     */
    public function payLoad() {
        $now = new DateTime();
        $future = new DateTime();
        $exp = new DateTime('+ 8 hours');
        $payLoad = array(
            'iss' => 'http://github.com/hedreiandrade',
            'aud' => 'http://twitter.com',
            'iat' => $now->getTimeStamp(),
            'nbf' => $future->getTimeStamp(),
            'exp' => $exp->getTimeStamp()
        );

        return $payLoad;
    }
}