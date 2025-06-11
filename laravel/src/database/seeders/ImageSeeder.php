<?php

namespace Database\Seeders;

use App\Models\Book;
use App\Models\Image;
use Illuminate\Database\Seeder;

class ImageSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $urls = [
            'sach1.jpg',
            'sach2.jpg',
            'sach3.jpg',
            'sach4.jpg',
        ];
    
        $books = Book::all();
        $imagesData = [];
    
        foreach ($books as $book) {
            $randomUrls = array_map(fn() => $urls[array_rand($urls)], range(1, 4));
    
            foreach ($randomUrls as $url) {
                $imagesData[] = [
                    'book_id' => $book->id,
                    'url' => $url,
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
            }
        }

        Image::insert($imagesData);
    }
}
