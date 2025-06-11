<?php

namespace Database\Seeders;

use App\Models\Book;
use App\Models\User;
use App\Models\WishList;
use Carbon\Carbon;
use Illuminate\Database\Seeder;

class WishListSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $wishListsData = [];
        $books = Book::all();

        foreach (User::all() as $user) {
            $randomBooks = $books->random(rand(1, 3));

            foreach ($randomBooks as $book) {
                $wishListsData[] = [
                    'user_id' => $user->id,
                    'book_id' => $book->id,
                    'created_at' => Carbon::now(),
                    'updated_at' => Carbon::now(),
                ];
            }
        }
        
        WishList::insert($wishListsData);
    }
}
