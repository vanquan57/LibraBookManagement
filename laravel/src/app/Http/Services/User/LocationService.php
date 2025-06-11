<?php

namespace App\Http\Services\User;

use App\Http\Repositories\DistrictRepositoryInterface;
use App\Http\Repositories\ProvinceRepositoryInterface;
use App\Http\Repositories\WardRepositoryInterface;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Support\Facades\Log;

class LocationService
{
    /**
     * Constructor
     *
     * @param ProvinceRepositoryInterface $provinceRepository
     * 
     * @param DistrictRepositoryInterface $districtRepository
     * 
     * @param WardRepositoryInterface $wardRepository
     */
    public function __construct(
        protected ProvinceRepositoryInterface $provinceRepository,
        protected DistrictRepositoryInterface $districtRepository,
        protected WardRepositoryInterface $wardRepository
    ) {}

    /**
     * Get all provinces
     *
     * @return Collection|null
     */
    public function getAllProvinces(): ?Collection
    {
        try {
            return $this->provinceRepository->getAll();
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return null;
        }
    }

    /**
     * Get all districts by province id
     *
     * @param int $provinceId
     *
     * @return Collection|null
     */
    public function getDistrictsByProvinceId(int $provinceId): ?Collection
    {
        try {
            $province = $this->provinceRepository->find($provinceId);

            if(!$province) {
                return null;
            }

            return $this->districtRepository->getDistrictByProvince($province);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return null;
        }
    }

    /**
     * Get all wards by district id
     *
     * @param int $districtId
     *
     * @return Collection|null
     */
    public function getWardsByDistrictId(int $districtId): ?Collection
    {
        try {
            $district = $this->districtRepository->find($districtId);

            if (!$district) {
                return null;
            }

            return $this->wardRepository->getWardByDistrict($district);
        } catch (\Exception $e) {
            Log::error($e->getMessage());

            return collect();
        }
    }
}
