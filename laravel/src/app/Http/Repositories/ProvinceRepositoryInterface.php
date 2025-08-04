<?php

namespace App\Http\Repositories;

use App\Models\Province;

interface ProvinceRepositoryInterface extends BaseRepositoryInterface {

    /**
     * Find province by code
     *
     * @param string $code
     * @return \App\Models\Province|null
     */
    public function findByCode(string $code): ?Province;
}
