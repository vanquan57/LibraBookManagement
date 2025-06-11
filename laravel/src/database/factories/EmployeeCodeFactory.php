<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\EmployeeCode>
 */
class EmployeeCodeFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        static $counter = 1;

        $code = 'K00' . str_pad($counter, 3, '0', STR_PAD_LEFT);
        $counter++;

        return [
            'code' => $code,
            'email' => $this->faker->unique()->userName . '@vku.udn.vn',
            'name' => $this->faker->name,
        ];
    }
}
