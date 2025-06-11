<?php

namespace App\Http\Repositories\Eloquent;

use App\Http\Repositories\AuthorRepositoryInterface;
use App\Models\Author;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Pagination\LengthAwarePaginator;

class AuthorRepository extends BaseRepository implements AuthorRepositoryInterface
{
    /**
     * Get model
     *
     * @return string
     */
    public function getModel(): string
    {
        return Author::class;
    }

    /**
     * Get all authors by paginate
     *
     * @param $data
     *
     * @return LengthAwarePaginator
     */
    public function getAllByPaginate(array $data): LengthAwarePaginator
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
     * Destroy a author
     *
     * @param int $id
     *
     * @return bool
     */
    public function destroy(int $id): bool
    {
        $author = $this->model->find($id);

        if ($author->books->isEmpty()) {
            return $this->model->destroy($id);
        }

        return false;
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param array $attributes
     *
     * @return Model
     */
    public function store(array $attributes): Model
    {
        return $this->model->create([
            'name' => $attributes['name'],
            'description' => $attributes['description'],
            'slug' => $attributes['name'],
        ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param int $id
     * 
     * @param array $attributes
     *
     * @return bool
     */
    public function update(int $id, array $attributes): bool
    {
        return $this->model->find($id)->update([
            'name' => $attributes['name'],
            'description' => $attributes['description'],
            'slug' => $attributes['name'],
        ]);
    }
}
