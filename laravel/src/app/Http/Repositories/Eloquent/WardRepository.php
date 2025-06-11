<?php

namespace App\Http\Repositories\Eloquent;

use App\Http\Repositories\WardRepositoryInterface;
use App\Models\District;
use App\Models\Ward;
use Illuminate\Database\Eloquent\Collection;

class WardRepository extends BaseRepository implements WardRepositoryInterface
{
    /**
     * Get model
     *
     * @return string
     */
    public function getModel(): string
    {
        return Ward::class;
    }

    /**
     * Get all ward by district
     *
     * @param District $district
     *
     * @return Collection
     */
    public function getWardByDistrict(District $district): Collection
    {
        return $district->wards;
    }
}
