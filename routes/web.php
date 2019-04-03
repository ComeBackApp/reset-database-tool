<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {    
    $filePath = env('SCRIPT_TO_RESET_DATABASE_PATH', false);
            if($filePath){
                \Log::info(DB::unprepared(file_get_contents($filePath)));
            }
    return view('welcome');
});


