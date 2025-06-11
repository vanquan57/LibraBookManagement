<?php

namespace Database\Seeders;

use App\Models\Book;
use App\Models\BookCategory;
use App\Models\Category;
use Carbon\Carbon;
use Illuminate\Database\Seeder;

class BookCategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $books = Book::all();
        $categories = Category::all();

        $bookCategoryData = [];

        foreach ($books as $book) {
            $randomCategories = $categories->random(rand(1, 3));

            foreach ($randomCategories as $category) {
                $bookCategoryData[] = [
                    'book_id' => $book->id,
                    'category_id' => $category->id,
                    'created_at' => Carbon::now(),
                    'updated_at' => Carbon::now(),
                ];
            }
        }

        BookCategory::insert($bookCategoryData);
    }
}
