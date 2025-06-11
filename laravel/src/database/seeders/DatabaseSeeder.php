<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $this->call([
            ProvinceSeeder::class,
            DistrictSeeder::class,
            WardSeeder::class,
            EmployeeCodeSeeder::class,
            UserSeeder::class,
            CategorySeeder::class,
            AuthorSeeder::class,
            PublisherSeeder::class,
            BookSeeder::class,
            BookCategorySeeder::class,
            ImageSeeder::class,
            CartSeeder::class,
            OrderSeeder::class,
            FeedbackSeeder::class,
            WishListSeeder::class,
        ]);
    }
}
