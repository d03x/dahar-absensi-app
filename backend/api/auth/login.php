<?php
$database = database();
$data = json_decode(file_get_contents("php://input"), true);
$data = database()->select('users', ['id']);
Response::error("Login endpoint is under construction", 501);
