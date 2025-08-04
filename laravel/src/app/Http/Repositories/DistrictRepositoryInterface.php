<?php

namespace App\Http\Repositories;

use App\Models\District;
use App\Models\Province;
use Illuminate\Database\Eloquent\Collection;

interface DistrictRepositoryInterface extends BaseRepositoryInterface
{
    /**
     * Get all district by province
     *
     * @param Province $province
     *
     * @return Collection|null
     */
    public function getDistrictByProvince(Province $province): ?Collection;

    /**
     * Find district by code
     *
     * @param string $code
     *
     * @return App/Models/District|null
     */
    public function findByCode(string $code): ?District;
}
