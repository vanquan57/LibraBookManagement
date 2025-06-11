<?php

namespace Database\Seeders;

use App\Models\Author;
use App\Models\Book;
use App\Models\Publisher;
use Illuminate\Database\Seeder;

class BookSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $authorIds = Author::all()->pluck('id')->toArray();
        $publisherIds = Publisher::all()->pluck('id')->toArray();

        Book::factory()->count(50)->withRandomData($authorIds, $publisherIds)->create();
    }
}
