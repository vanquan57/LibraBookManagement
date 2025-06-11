<?php

namespace Database\Seeders;

use App\Models\EmployeeCode;
use Illuminate\Database\Seeder;

class EmployeeCodeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        EmployeeCode::factory()->count(300)->create();
    }
}
