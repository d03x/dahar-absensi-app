<?php
define("BASE_PATH", __DIR__ . DIRECTORY_SEPARATOR);
$autoload_file = __DIR__ . DIRECTORY_SEPARATOR . "vendor/autoload.php";
require_once $autoload_file;
//include response helpers
require BASE_PATH . "helpers/ResponseHelpers.php";
$file = cleanPath($_GET['endpoint'] ?? "home") ?? null;
$isApi = str_starts_with($file, "api/");
if ($isApi) {
    header("Content-Type: application/json");
    header("Access-Control-Allow-Origin: *");
}
$targetFile = __DIR__ . DIRECTORY_SEPARATOR . $file . ".php";
require BASE_PATH . "config/database.php";
if (file_exists($targetFile)) {
    require_once $targetFile;
} else {
    http_response_code(404);
    if ($isApi) {
        echo json_encode(["error" => "Endpoint not found"]);
    } else {
        echo "404 Not Found";
    }
}
function cleanPath(String $path)
{
    return preg_replace('/[^a-zA-Z0-9\/_-]/', '', $path);
}
