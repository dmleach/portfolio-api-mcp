<?php

declare(strict_types=1);

namespace App\Controllers;

use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

class HealthController
{
    public function check(Request $request, Response $response): Response
    {
        $response->getBody()->write(json_encode(['status' => 'ok']));

        return $response->withHeader('Content-Type', 'application/json');
    }
}