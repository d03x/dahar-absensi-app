<?php

use Medoo\Medoo;

$host = "localhost";
$user = "root";
$password = "root";
$database = "attendance_app";
try {
    $connect =  new Medoo([
        'type' => 'mysql',
        'host' => $host,
        'database' => $database,
        'username' => $user,
        'password' => $password
    ]);
} catch (\Throwable $th) {
    Response::error('Opps! Error pada database', 500);
}
function database(): Medoo
{
    global $connect;
    return $connect;
}
