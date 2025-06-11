<?php

namespace App\Http\Repositories\Eloquent;

use App\Http\Repositories\CategoryRepositoryInterface;
use App\Models\Category;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;

class CategoryRepository extends BaseRepository implements CategoryRepositoryInterface
{
    public function getModel(): string
    {
        return Category::class;
    }

    /**
     * Get categories by paginate
     *
     * @param array $data
     *
     * @return LengthAwarePaginator
     */
    public function getAllByPagination(array $data): LengthAwarePaginator
    {
        $query = $this->model->query();

        if (!empty($data['name'])) {
            $query->where('name', 'like', '%' . $data['name'] . '%');
        }

        if(!empty($data['column']) && !empty($data['order'])) {
            $query->orderBy($data['column'], $data['order']);
        }

        return $query->paginate($data['limit']);
    }

    /**
     * The method destroys the model
     *
     * @param int $id
     *
     * @return bool
     */
    public function destroy(int $id): bool
    {
        $category = $this->model->find($id);

        if ($category->books->isEmpty()) {
            return $this->model->destroy($id);
        }

        return false;
    }

    /**
     * Get data for pie chart categories
     * 
     * @return Collection|null
     */
    public function getTotalBooksInCategories(): ?Collection
    {
        return $this->model->select([
            'name',
        ])->withCount('books')->get();
    }
}
