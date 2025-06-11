<?php

namespace App\Http\Services;

use App\Http\Repositories\ImageRepositoryInterface;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;

class ImageService
{
    /**
     * Constructor
     *
     * @param ImageRepositoryInterface $imageRepository
     */
    public function __construct(
        protected ImageRepositoryInterface $imageRepository
    ) {}

    /**
     * Store the image(s) to the storage
     *
     * @param array $images
     *
     * @return array
     */
    public function uploadImages(array $images): array
    {
        $urls = [];

        try {
            foreach ($images as $image) {
                if ($image && $image->isValid()) {
                    $hashedName = md5(uniqid('', true) . $image->getClientOriginalName()) . '.' . $image->getClientOriginalExtension();
                    Storage::disk('public')->put('images/' . $hashedName, file_get_contents($image->getRealPath()));
                    $urls[] = $hashedName;
                }
            }
        } catch (\Exception $e) {
            Log::error('Image upload failed: ' . $e->getMessage());

            return [];
        }

        return $urls;
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
        try {
            return $this->imageRepository->storeImagesByBookId($bookId, $images);
        } catch (\Exception $e) {
            return false;
        }
    }

    /**
     * DeleteToStorage image in storage
     *
     * @param string $url
     *
     * @return bool
     */
    public function deleteFromStorage(string $url): bool
    {
        try {
            return Storage::disk('public')->delete('images/' . $url);
        } catch (\Exception $e) {
            return false;
        }
    }

    /**
     * Destroy images by book id
     *
     * @param int $bookId
     *
     * @return bool
     */
    public function destroy(int $bookId): bool
    {
        try {
            return $this->imageRepository->destroy($bookId);
        } catch (\Exception $e) {
            return false;
        }
    }
}
