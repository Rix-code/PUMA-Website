<?php

use App\Http\Middleware\HandleCors;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\NewsController;
use App\Http\Controllers\DivisionsController;

Route::get('/', function () {
    return view('welcome');
});


Route::middleware([HandleCors::class])->group(function () {
    Route::get('/api/news', [NewsController::class, 'index']);
    Route::get('/api/news/{id}', [NewsController::class, 'show']);

    Route::get('/api/divisions', [DivisionsController::class, 'index']);
    Route::get('/api/divisions/{id}', [DivisionsController::class, 'show']);
    
});