<?php

declare(strict_types=1);

use Slim\Factory\AppFactory;

require __DIR__ . '/../vendor/autoload.php';

$app = AppFactory::create();

$app->addRoutingMiddleware();

$displayErrorDetails = (bool) (getenv('APP_DEBUG') ?: false);
$app->addErrorMiddleware($displayErrorDetails, true, true);

(require __DIR__ . '/../src/routes.php')($app);

$app->run();