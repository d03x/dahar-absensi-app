<?php

define('DEBUG_MODE', true);
########### SETTING UP DEBUG MODE ##################
if (DEBUG_MODE) {
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
} else {
    ini_set('display_errors', 0);
    error_reporting(0);
}
define("BASE_PATH", __DIR__ . DIRECTORY_SEPARATOR);
$autoload_file = __DIR__ . DIRECTORY_SEPARATOR . "vendor/autoload.php";
if (!file_exists($autoload_file)) {
    die("Not found autoload file this app requires this file");
}
require_once $autoload_file;
############## INCLUDE HELPERS
require BASE_PATH . "helpers/ResponseHelpers.php";
require_once __DIR__ . "/helpers/ErrorHandler.php";
################### SET ERROR HANDLER 
set_exception_handler(['ErrorHandler', 'handleException']);
set_error_handler(['ErrorHandler', 'handleError']);

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
