<?php

namespace App\Http\Repositories\Eloquent;

use App\Http\Repositories\ProvinceRepositoryInterface;
use App\Models\Province;
use Illuminate\Database\Eloquent\Collection;

class ProvinceRepository extends BaseRepository implements ProvinceRepositoryInterface
{
    /**
     * Get model
     *
     * @return string
     */
    public function getModel(): string
    {
        return Province::class;
    }

    /**
     * Find province by code
     *
     * @param string $code
     * @return Province|null
     */
    public function findByCode(string $code): ?Province
    {
        return $this->model->where('code', $code)->first();
    }
}
