<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Inventario\EquipoController;
use App\Http\Controllers\Inventario\InventarioController;
use App\Http\Controllers\Inventario\ModeloEquipoController;
use App\Http\Controllers\Inventario\MovimientoController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::apiResource('equipos', EquipoController::class);
Route::apiResource('inventario', InventarioController::class);
Route::apiResource('modelos', ModeloEquipoController::class);
Route::apiResource('movimientos', MovimientoController::class);
