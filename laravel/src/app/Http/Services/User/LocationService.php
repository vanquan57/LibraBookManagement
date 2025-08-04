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
     * Get all districts by province code
     *
     * @param int $provinceCode
     *
     * @return Collection|null
     */
    public function getDistrictsByProvinceCode(int $provinceCode): ?Collection
    {
        try {
            $province = $this->provinceRepository->findByCode($provinceCode);
            Log::info($province);
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
     * Get all wards by district code
     *
     * @param string $districtCode
     *
     * @return Collection|null
     */
    public function getWardsByDistrictCode(string $districtCode): ?Collection
    {
        try {
            $district = $this->districtRepository->findByCode($districtCode);

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
