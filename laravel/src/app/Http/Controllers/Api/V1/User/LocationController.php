<?php

namespace App\Http\Controllers\Api\V1\User;

use App\Http\Controllers\Controller;
use App\Http\Services\User\LocationService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Response;

class LocationController extends Controller
{
    /**
     * The constructor
     * 
     * @param LocationService $locationService
     */
    public function __construct(
        protected LocationService $locationService
    ) {}


    /**
     * Get all provinces
     *
     * @return JsonResponse
     */
    public function getAllProvinces(): JsonResponse
    {
        if (!$provinces = $this->locationService->getAllProvinces()) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                Response::HTTP_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau.'
            );
        }
        
        return responseOkAPI($provinces);
    }

    /**
     * Get all districts by province id
     *
     * @param int $provinceId
     *
     * @return JsonResponse
     */
    public function getDistrictsByProvinceId(int $provinceId): JsonResponse
    {
        if (!$districts = $this->locationService->getDistrictsByProvinceId($provinceId)) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                Response::HTTP_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau.'
            );
        }

        return responseOkAPI($districts);
    }

    /**
     * Get all wards by district id
     *
     * @param int $districtId
     *
     * @return JsonResponse
     */
    public function getWardsByDistrictId(int $districtId): JsonResponse
    {
        if (!$wards = $this->locationService->getWardsByDistrictId($districtId)) {
            return responseErrorAPI(
                Response::HTTP_BAD_REQUEST,
                Response::HTTP_BAD_REQUEST,
                'Không thể xử lý yêu cầu, vui lòng thử lại sau.'
            );
        }

        return responseOkAPI($wards);
    }
}
