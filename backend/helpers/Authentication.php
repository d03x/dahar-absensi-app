<?php

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

function getAuthorizationHeader()
{
    $headers = null;
    if (isset($_SERVER['Authorization'])) {
        $headers = trim($_SERVER["Authorization"]);
    } else if (isset($_SERVER['HTTP_AUTHORIZATION'])) { // Nginx / FastCGI
        $headers = trim($_SERVER["HTTP_AUTHORIZATION"]);
    } elseif (function_exists('apache_request_headers')) {
        $requestHeaders = apache_request_headers();
        // Server-side fix for header casing
        $requestHeaders = array_combine(array_map('ucwords', array_keys($requestHeaders)), array_values($requestHeaders));
        if (isset($requestHeaders['Authorization'])) {
            $headers = trim($requestHeaders['Authorization']);
        }
    }
    return $headers;
}

function require_auth()
{

    $authHeader = getAuthorizationHeader();
    $jwt = null;
    if ($authHeader && preg_match('/Bearer\s(\S+)/', $authHeader, $matches)) {
        $jwt = $matches[1];
    } else {
        // Token tidak dikirim sama sekali
        http_response_code(401);
        echo json_encode([
            'status' => 'error',
            'message' => 'Token tidak ditemukan (Authorization header missing)'
        ]);
        exit();
    }

    try {
        $decoded = JWT::decode($jwt, new Key(JWT_TOKEN, 'HS256'));
        return (array) $decoded->data;
    } catch (Exception $e) {
        http_response_code(401);
        echo json_encode([
            'status' => 'error',
            'message' => 'Akses ditolak: ' . $e->getMessage()
        ]);
        exit();
    }
}
