<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::middleware(['auth:sanctum'])->get('/user', function (Request $request) {
    return $request->user();
});
Route::get('/check-env', function () {
    return response()->json(['frontend_url' => env('FRONTEND_URL')]);
});