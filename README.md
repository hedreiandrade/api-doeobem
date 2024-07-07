Login API with Docker, SLIM 3, Composer, JWT security and CRUD for your new Models, you can use PostMan for test this API.

---------------------------------------------------------------------------------------------

RUN By Docker : 

Clone the project :

```
git clone https://github.com/hedreiandrade/api-doeobem.git
```

Inside your project api-doeobem, RUN :

```
docker-compose up -d --build
```

RUN the attached sql file(dblLoginAPI.sql) inside mysql in container(mysqlslim).

RUN ```composer update``` at the root of the project, inside the container(api-doeobem)

Create files and Configure \api-doeobem\app\Config
- db.php
- jwt.php
- facebook.php
- google.php

Configure in app/Config/db.php :

	const DRIVER = 'mysql';
	const HOST = 'mysqlslim';
	const DATA_BASE = 'api-doeobem';
	const USER_NAME = 'root';
	const PASSWORD = '123';
	const CHARSET = 'utf8';
	const COLLATION = 'utf8_general_ci';

Test by Postman import the configuration(api-login.postman_collection.json) in attached

Login

{
	"email":"admin@user.com",
	"password":"123"
}

---------------------------------------------------------------------------------------------

RUN By Wamp64/Xampp/Linux :

Clone the project, RUN :

```
git clone https://github.com/hedreiandrade/api-doeobem.git 
```

RUN ```composer update``` at the root of the project in your directory

Run the attached sql file(dblLoginAPI.sql).

Create files and Configure \api-doeobem\app\Config
- db.php
- jwt.php
- facebook.php
- google.php

Test by Postman import the configuration(api-login.postman_collection.json) in attached

Login

{
	"email":"admin@user.com",
	"password":"123"
}

---------------------------------------------------------------------------------------------

Now, RUN the project https://github.com/hedreiandrade/login_react_apidoeobem

---------------------------------------------------------------------------------------------

Enjoy.
