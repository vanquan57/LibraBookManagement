<?php

namespace App\Http\Repositories\Eloquent;

use App\Http\Repositories\DistrictRepositoryInterface;
use App\Models\District;
use App\Models\Province;
use Illuminate\Database\Eloquent\Collection;

class DistrictRepository extends BaseRepository implements DistrictRepositoryInterface
{
    /**
     * Get model
     *
     * @return string
     */
    public function getModel(): string
    {
        return District::class;
    }

    /**
     * Get all district by province
     *
     * @param Province $province
     *
     * @return Collection
     */
    public function getDistrictByProvince(Province $province): Collection
    {
        return $province->districts;
    }

    /**
     * Find district by code
     *
     * @param string $code
     *
     * @return District|null
     */
    public function findByCode(string $code): ?District
    {
        return $this->model->where('code', $code)->first();
    }
}
