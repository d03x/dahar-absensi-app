<?php

use Symfony\Component\HttpFoundation\JsonResponse;

class Response
{

    public static function json($data = [], int $status = 200)
    {
        $response = new JsonResponse($data, $status);
        $response->send(true);
    }

    public static function success($data, string $message = "Success")
    {
        return self::json([
            'status' => true,
            'message' => $message,
            'data' => $data
        ], 200);
    }


    public static function error(string $message, int $code = 400)
    {
        return self::json([
            'status' => false,
            'message' => $message,
            'data' => null
        ], $code);
    }
}
