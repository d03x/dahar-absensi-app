<?php

$host = "localhost";
$user = "root";
$password = "root";
$database = "attendance_app";
try {
    $connect = new PDO("mysql:host=$host;dbname=$database", $user, $password);
    $connect->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $connect->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_OBJ);
} catch (\Throwable $th) {
    Response::error('Opps! Error pada database', 500);
}
function database(): PDO
{
    global $connect;
    return $connect;
}
