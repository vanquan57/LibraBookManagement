<?php

namespace Database\Seeders;

use App\Models\Book;
use App\Models\Feedback;
use App\Models\User;
use Illuminate\Database\Seeder;

class FeedbackSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $users = User::where('role', User::ROLE_USER)->get();
        $books = Book::all();

        $feedbackData = [];

        foreach ($users as $user) {
            foreach ($books as $book) {
                $feedbackData[] = [
                    'user_id' => $user->id,
                    'book_id' => $book->id,
                    'content' => 'Sách rất hay, tôi rất thích!',
                    'star' => rand(1, 5),
                    'status' => rand(0, 1),
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
            }
        }
        
        Feedback::insert($feedbackData);
    }
}
