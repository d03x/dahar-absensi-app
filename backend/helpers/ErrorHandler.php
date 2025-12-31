<?php

class ErrorHandler
{

    public static function handleException(Throwable $exception)
    {
        $statusCode = 500;

        // Cek apakah error dari PDO (Database)
        if ($exception instanceof PDOException) {
            $message = "Database Error";
        } else {
            $message = $exception->getMessage();
        }

        $response = [
            'status' => false,
            'message' => DEBUG_MODE ? $exception->getMessage() : "Terjadi kesalahan pada server (Internal Server Error)."
        ];

        if (DEBUG_MODE) {
            $response['debug'] = [
                'file' => $exception->getFile(),
                'line' => $exception->getLine(),
                'trace' => $exception->getTraceAsString() // Jejak error
            ];
        }

        Response::json($response, $statusCode);
    }

    public static function handleError($level, $message, $file, $line)
    {
        throw new ErrorException($message, 0, $level, $file, $line);
    }
}
