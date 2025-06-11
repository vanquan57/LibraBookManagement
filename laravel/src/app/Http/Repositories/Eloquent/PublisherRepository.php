<?php

namespace App\Http\Repositories\Eloquent;

use App\Http\Repositories\PublisherRepositoryInterface;
use App\Models\Publisher;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Pagination\LengthAwarePaginator;

class PublisherRepository extends BaseRepository implements PublisherRepositoryInterface
{
    /**
     * Get model.
     *
     * @return string
     */
    public function getModel()
    {
        return Publisher::class;
    }

    /**
     * Get all publishers by paginate.
     *
     * @param array $data
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
     * Destroy a publisher.
     *
     * @param int $id
     *
     * @return bool
     */
    public function destroy(int $id): bool
    {
        $publisher = $this->model->find($id);

        if ($publisher->books->isEmpty()) {
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
