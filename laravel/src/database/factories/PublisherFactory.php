<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Publisher>
 */
class PublisherFactory extends Factory
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
                'Nhà xuất bản chuyên về sách giáo dục và tài liệu học tập.',
                'Đơn vị xuất bản nổi tiếng với các tác phẩm văn học kinh điển.',
                'Nhà xuất bản hàng đầu trong lĩnh vực sách khoa học phổ thông.',
                'Đơn vị chuyên xuất bản sách kỹ năng sống và phát triển bản thân.',
                'Nhà xuất bản có các bộ truyện tranh được yêu thích trên toàn quốc.',
                'Nhà xuất bản nổi bật trong lĩnh vực sách kinh doanh và khởi nghiệp.',
                'Đơn vị xuất bản sách ngoại ngữ với phương pháp học hiện đại.',
                'Nhà xuất bản uy tín về các tác phẩm lịch sử và văn hóa dân tộc.',
                'Đơn vị xuất bản sách thiếu nhi với nội dung phong phú và hấp dẫn.',
                'Nhà xuất bản chuyên về các tiểu thuyết phiêu lưu và giả tưởng.',
                'Đơn vị xuất bản các tạp chí và tài liệu nghiên cứu chuyên ngành.',
                'Nhà xuất bản nổi tiếng với sách về công nghệ và lập trình.',
                'Đơn vị xuất bản các tập thơ ca và tác phẩm lãng mạn.',
                'Nhà xuất bản chuyên cung cấp sách hướng dẫn nấu ăn và ẩm thực.',
                'Nhà xuất bản từng đoạt nhiều giải thưởng danh giá về chất lượng nội dung.'
            ]),
        ];
    }
}
