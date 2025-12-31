<?php

use Firebase\JWT\JWT;
use Symfony\Component\HttpFoundation\Response as HttpResponse;

$database = database();
$data = json_decode(file_get_contents("php://input"), true);
if (empty($data)) {
    return Response::error("Invalid request", HttpResponse::HTTP_UNPROCESSABLE_ENTITY);
}
if (!empty($data)) {
    $username = $data['email'] ?? null;
    $password = $data['password'] ?? null;
    if (empty($username) && empty($password)) {
        return Response::error("Email dan pasword tidak boleh kosong");
    }
    $user = database()->get("users", ['email', 'password', 'id', 'name'], [
        'email' => $username,
    ]);
    if ($user) {
        if (password_verify($password, $user['password'])) {
            $user = array_intersect_key($user, array_flip(['id', 'email', 'name']));
            $jwt = JWT::encode([
                'iss' => 'lugwa.com',
                'aud' => 'lugwa.com',
                'user' => $user,
                'iat' => time(),
                'exp' => time() + (60 * 60),
            ], JWT_TOKEN, 'HS256');
            return Response::success([
                'token' => $jwt,
                'user' => $user,
            ]);
        }
    }
    return Response::error("Akun tidak ditemukan / email atau password salah $username,$password", HttpResponse::HTTP_UNPROCESSABLE_ENTITY);
}
