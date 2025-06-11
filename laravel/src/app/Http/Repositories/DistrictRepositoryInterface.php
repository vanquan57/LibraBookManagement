<?php

namespace App\Http\Repositories;

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
}
