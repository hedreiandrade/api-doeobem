
Login API with SLIM 3, Composer, JWT security and CRUD for your new Models, you can use PostMan for test this API.

Clone the project (git clone https://github.com/hedreiandrade/api-doeobem.git)
RUN (composer update) at the root of the project in your directory

Run the attached sql file(dblLoginAPI.sql).

Configure \api-doeobem\app\Config
- db.php
- jwt.php

Test by Postman import the configuration(api-login.postman_collection.json) in attached

Login

{
	"email":"admin@user.com",
	"password":"123"
}

Enjoy.
