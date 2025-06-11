<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('books', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('author_id');
            $table->unsignedBigInteger('publisher_id');
            $table->string('name', 255)->unique();
            $table->string('slug', 255)->unique();
            $table->string('mini_description', 255);
            $table->text('details_description');
            $table->date('publication_date');
            $table->smallInteger('quantity')->unsigned();
            $table->string('size', 50)->nullable();
            $table->smallInteger('page')->unsigned()->nullable();
            $table->tinyInteger('cover_type')->unsigned()->nullable()->comment('1: Cứng, 2: Mềm');
            $table->bigInteger('views')->unsigned()->nullable()->default(0);
            $table->bigInteger('borrowing_number')->unsigned()->nullable()->default(0);
            $table->string('image', 255)->nullable();
            $table->softDeletes();
            $table->timestamps();

            $table->foreign('author_id')->references('id')->on('authors')->onDelete('cascade');
            $table->foreign('publisher_id')->references('id')->on('publishers')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('books');
    }
};
