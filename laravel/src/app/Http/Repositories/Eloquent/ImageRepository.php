<?php

namespace App\Http\Repositories\Eloquent;

use App\Http\Repositories\ImageRepositoryInterface;
use App\Models\Image;
use Carbon\Carbon;

class ImageRepository extends BaseRepository implements ImageRepositoryInterface
{
    /**
     * Get model
     *
     * @return string
     */
    public function getModel(): string
    {
        return Image::class;
    }

    /**
     * Store multiple images by book id
     *
     * @param int $bookId
     *
     * @param array $images
     *
     * @return bool
     */
    public function storeImagesByBookId(int $bookId, array $images): bool
    {
        $dataImages = [];

        foreach ($images as $image) {
            $dataImages[] = [
                'book_id' => $bookId,
                'url' => $image,
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now(),
            ];
        }

        return $this->model->insert($dataImages);
    }

    /**
     * destroy images
     *
     * @param int $bookId
     *
     * @return bool
     */
    public function destroy(int $bookId): bool
    {
        return $this->model->where('book_id', $bookId)->delete();
    }

    /**
     * Get all images by bookId
     *
     * @param int $bookId
     *
     * @return array
     */
    public function getAllByBookId(int $bookId): array
    {
        return $this->model->where('book_id', $bookId)->get()->toArray();
    }
}
