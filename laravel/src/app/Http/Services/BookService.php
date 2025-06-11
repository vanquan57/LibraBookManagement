<?php

namespace App\Http\Services;

use App\Http\Repositories\BookRepositoryInterface;
use App\Http\Repositories\ImageRepositoryInterface;
use App\Models\Book;
use Illuminate\Http\Response;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;

class BookService
{
    /**
     * Constructor
     *
     * @param BookRepositoryInterface $bookRepository
     *
     * @param ImageService $imageService
     * 
     * @param ImageRepositoryInterface $imageRepository
     */
    public function __construct(
        protected BookRepositoryInterface $bookRepository,
        protected ImageService $imageService,
        protected ImageRepositoryInterface $imageRepository
    ) {}

    /**
     * Get all books by paginate
     *
     * @param array $dataSearch
     *
     * @return LengthAwarePaginator|null
     */
    public function getAllByPagination($dataSearch): ?LengthAwarePaginator
    {
        try {
            $data = [
                'name' => $dataSearch['name'] ?? null,
                'limit' => $dataSearch['limit'] ?? config('constants.DEFAULT_LIMIT'),
                'author_id' => $dataSearch['author_id'] ?? null,
                'publisher_id' => $dataSearch['publisher_id'] ?? null,
                'category_id' => $dataSearch['category_id'] ?? null,
                'order' => $dataSearch['order'] ?? null,
                'column' => $dataSearch['column'] ?? null,
            ];

            return $this->bookRepository->getAllByPagination($data);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return null;
        }
    }

    /**
     * Store a book
     *
     * @param array $data
     *
     * @return Book|null
     */
    public function store(array $data): ?Book
    {
        try {
            DB::beginTransaction();

            $hashedName = md5(uniqid('', true) . $data['image']->getClientOriginalName()) . '.' . $data['image']->getClientOriginalExtension();

            if (Storage::disk('public')->put('images/' . $hashedName, file_get_contents($data['image']->getRealPath()))) {
                $data['image'] = $hashedName;
                $book = $this->bookRepository->store($data);

                if (!$book) {
                    throw new \Exception('Lỗi, lưu thông tin sách thất bại');
                }

                $this->addBookToCategory($book->id, $data['category_id']);
                $urls = $this->imageService->uploadImages($data['images']);

                if (empty($urls)) {
                    throw new \Exception('Lỗi, tải lên hình ảnh thất bại');
                }

                if (!$this->imageService->storeImagesByBookId($book->id, $urls)) {
                    throw new \Exception('Lỗi, lưu hình ảnh thất bại');
                }

                DB::commit();

                return $book;
            }

            return null;
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error($e->getMessage());

            if ($hashedName) {
                $this->imageService->deleteFromStorage($hashedName);
            }

            if (isset($urls)) {
                foreach ($urls as $url) {
                    $this->imageService->deleteFromStorage($url);
                }
            }

            return null;
        }
    }

    /**
     * Show a book
     *
     * @param int $id
     *
     * @return Book|null
     */
    public function show(int $id): ?Book
    {
        try {
            return $this->bookRepository->find($id);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return null;
        }
    }

    /**
     * Update a book
     *
     * @param array $data
     *
     * @param int $id
     *
     * @return bool
     */
    public function update(array $data, int $id): bool
    {
        try {
            DB::beginTransaction();

            $book = $this->bookRepository->find($id);

            if (!$book) {
                return false;
            }

            if (isset($data['image'])) {
                // Delete old image hero
                $hashedName = md5(uniqid('', true) . $data['image']->getClientOriginalName()) . '.' . $data['image']->getClientOriginalExtension();
                
                if (Storage::disk('public')->put('images/' . $hashedName, file_get_contents($data['image']->getRealPath()))) {
                    $data['image'] = $hashedName;

                    $this->imageService->deleteFromStorage($book->image);
                } else {
                    throw new \Exception('Lỗi, tải hình ảnh lên thất bại');
                }
            }

            if (
                isset($data['id_images_removed']) && isset($data['images']) &&
                count($data['images']) === count($data['id_images_removed'])
            ) {
                // Memory url image removed
                $urlOldImagesRemoved = [];

                foreach ($data['id_images_removed'] as $idImage) {
                    $urlOldImagesRemoved[] = $this->imageRepository->find($idImage)->url;
                }

                $urls = $this->imageService->uploadImages($data['images']);

                if (empty($urls)) {
                    throw new \Exception('Lỗi, tải lên hình ảnh thất bại');
                }

                //Combine id image removed with url image new for update
                $dataImagesUpdate = array_combine($data['id_images_removed'], $urls);

                foreach ($dataImagesUpdate as $idImage => $url) {
                    if (!$this->imageRepository->update($idImage, ['url' => $url])) {
                        throw new \Exception('Lỗi, cập nhật hình ảnh thất bại');
                    }
                }

                // Remove old image when has updated successfully
                foreach ($urlOldImagesRemoved as $urlOldImageRemoved) {
                    $this->imageService->deleteFromStorage($urlOldImageRemoved);
                }
            }

            // Update information book exepct image
            if (!$this->bookRepository->update($id, $data)) {
                throw new \Exception('Lỗi, cập nhật thông tin sách thất bại');
            }

            $this->updateBookInCategory($id, $data['category_id']);
            DB::commit();

            return true;
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error($e->getMessage());

            if (isset($hashedName)) {
                $this->imageService->deleteFromStorage($hashedName);
            }

            if (isset($urls)) {
                foreach ($urls as $url) {
                    $this->imageService->deleteFromStorage($url);
                }
            }

            return false;
        }
    }

    /**
     * Destroy a book
     *
     * @param int $id
     *
     * @return bool
     */
    public function destroy(int $id): bool
    {
        try {
            return $this->bookRepository->destroy($id);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return false;
        }
    }

    /**
     * Add book to category
     *
     * @param int $bookId
     *
     * @param int $categoryId
     *
     * @return bool
     */
    private function addBookToCategory(int $bookId, int $categoryId): bool
    {
        try {
            return $this->bookRepository->addBookToCategory($bookId, $categoryId);
        } catch (\Exception $e) {
            return false;
        }
    }

    /**
     * Update book in category
     *
     * @param int $bookId
     *
     * @param int $categoryId
     *
     * @return bool
     */
    private function updateBookInCategory(int $bookId, int $categoryId): bool
    {
        try {
            return $this->bookRepository->updateBookInCategory($bookId, $categoryId);
        } catch (\Exception $e) {
            return false;
        }
    }
}
