<?php

namespace App\Http\Repositories;

use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;

interface BaseRepositoryInterface
{
    /**
     * Get all
     *
     * @return Collection
     */
    public function getAll(): Collection;

    /**
     * Get one
     *
     * @param int $id
     *
     * @return Model|null
     */
    public function find(int $id): ?Model;

    /**
     * Store a newly created resource in storage.
     *
     * @param array $attributes
     *
     * @return Model|null
     */
    public function store(array $attributes): ?Model;

    /**
     * Update
     *
     * @param $id
     *
     * @param array $attributes
     *
     * @return bool
     */
    public function update(int $id, array $attributes): bool;

    /**
     * Delete
     *
     * @param int $id
     *
     * @return bool
     */
    public function destroy(int $id): bool;
}
