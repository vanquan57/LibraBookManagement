<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Category>
 */
class CategoryFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $name = $this->faker->unique()->name;

        return [
            'name' => $name,
            'slug' => Str::slug($name),
            'description' => $this->faker->randomElement([
                'Sách văn học kinh điển với nội dung sâu sắc và ý nghĩa.',
                'Những cuốn sách kỹ năng sống giúp bạn phát triển bản thân.',
                'Truyện tranh hấp dẫn dành cho mọi lứa tuổi.',
                'Sách khoa học phổ thông giải đáp những câu hỏi thú vị.',
                'Sách giáo khoa và tài liệu học tập chuẩn quốc gia.',
                'Tuyển tập tiểu thuyết lãng mạn đầy cảm xúc.',
                'Sách về kinh doanh và khởi nghiệp dành cho doanh nhân.',
                'Tài liệu học ngoại ngữ với phương pháp học hiệu quả.',
                'Sách lịch sử và văn hóa khám phá những giá trị truyền thống.',
                'Các tác phẩm phiêu lưu và giả tưởng đầy kỳ thú.',
                'Sách thiếu nhi giúp nuôi dưỡng tâm hồn trẻ thơ.',
                'Tạp chí và sách tham khảo chuyên ngành đa lĩnh vực.',
                'Sách về công nghệ và lập trình dành cho người mới bắt đầu.',
                'Những bộ sưu tập thơ ca nổi tiếng trong và ngoài nước.',
                'Sách hướng dẫn nấu ăn với các công thức đặc sắc.'
            ]),
        ];
    }
}
