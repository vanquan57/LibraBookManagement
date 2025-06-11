<?php

namespace Database\Factories;

use App\Models\Order;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Arr;
use Illuminate\Support\Str;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Order>
 */
class OrderFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Order::class;

    public function definition(): array
    {
        $listStatus = [Order::STATUS_OVERDUE, Order::STATUS_BORROWING, Order::STATUS_MISSING, Order::STATUS_RETURNED];
        static $counter = 1;
        $orderCode = 'HD' . str_pad($counter, 5, '0', STR_PAD_LEFT);
        $counter++;

        return [
            'code' => $orderCode,
            'phone' => $this->faker->numerify('09#########'),
            'email' => $this->faker->unique()->safeEmail,
            'address' => $this->faker->address,
            'status' => Arr::random($listStatus),
        ];
    }

    public function withRandomData($userIds, $provinceIds, $districtIds, $wardIds)
    {
        return $this->state(function (array $attributes) use ($userIds, $provinceIds, $districtIds, $wardIds) {
            return [
                'user_id' => Arr::random($userIds),
                'province_id' => Arr::random($provinceIds),
                'district_id' => Arr::random($districtIds),
                'ward_id' => Arr::random($wardIds),
            ];
        });
    }
}
