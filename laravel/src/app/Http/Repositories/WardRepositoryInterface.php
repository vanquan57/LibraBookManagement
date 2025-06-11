<?php

namespace App\Http\Repositories;

use App\Models\District;
use Illuminate\Database\Eloquent\Collection;
use SebastianBergmann\Type\NullType;

interface WardRepositoryInterface extends BaseRepositoryInterface
{
    /**
     * Get all ward by district
     *
     * @param District $district
     *
     * @return Collection|null
     */
    public function getWardByDistrict(District $districtId): ?Collection;
}
