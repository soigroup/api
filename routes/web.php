<?php

use App\Http\Controllers\AdminController;
use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;

// التوجيه الافتراضي
Route::get('/', function () {
    return redirect('/dashboard');
});

// مسارات الملف الشخصي
Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

// مسارات لوحة التحكم
Route::get('/dashboard', [AdminController::class, 'dashboard'])->name('dashboard');

// مسارات المستخدمين
Route::get('/users', [AdminController::class, 'users'])->name('users');

// مسارات المهام
Route::get('/tasks', [AdminController::class, 'tasks'])->name('tasks');
Route::get('/tasks/create', [AdminController::class, 'createTask'])->name('tasks.create');
Route::post('/tasks', [AdminController::class, 'storeTask'])->name('tasks.store');

// مسارات المهام اليومية
Route::get('/daily-tasks', [AdminController::class, 'dailyTasks'])->name('daily_tasks.index');
Route::get('/daily-tasks/create', [AdminController::class, 'createDailyTask'])->name('daily_tasks.create');
Route::post('/daily-tasks', [AdminController::class, 'storeDailyTask'])->name('daily_tasks.store');

// ملاحظة: تم إلغاء استيراد auth.php لأن المصادقة غير مطلوبة
// require __DIR__.'/auth.php';
