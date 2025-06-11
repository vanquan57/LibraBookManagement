<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Author>
 */
class AuthorFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $name = $this->faker->name;

        return [
            'name' => $name,
            'slug' => Str::slug($name),
            'description' => $this->faker->randomElement([
                'Tác giả chuyên viết tiểu thuyết lịch sử nổi tiếng.',
                'Chuyên gia trong lĩnh vực kỹ năng sống và phát triển bản thân.',
                'Nhà văn trẻ với những tác phẩm phiêu lưu mạo hiểm hấp dẫn.',
                'Tác giả nổi tiếng về các sách khoa học phổ thông.',
                'Nhà giáo với nhiều năm kinh nghiệm trong lĩnh vực giáo dục.',
                'Nhà thơ với những vần thơ lãng mạn đầy cảm xúc.',
                'Tác giả chuyên viết sách kinh doanh và khởi nghiệp.',
                'Giáo viên dạy ngoại ngữ với nhiều đầu sách nổi tiếng.',
                'Nhà nghiên cứu lịch sử và văn hóa dân gian.',
                'Tác giả sáng tạo các bộ truyện tranh được yêu thích.',
                'Chuyên gia ẩm thực với các cuốn sách hướng dẫn nấu ăn.',
                'Nhà văn viết sách thiếu nhi với phong cách vui nhộn, dễ hiểu.',
                'Tác giả chuyên viết tiểu thuyết giả tưởng và kỳ ảo.',
                'Nhà phát triển công nghệ, chuyên viết sách về lập trình.',
                'Tác giả từng đoạt nhiều giải thưởng văn học danh giá.'
            ]),
        ];
    }
}
