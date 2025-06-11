<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Arr;
use Illuminate\Support\Str;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Book>
 */
class BookFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $urls = [
            'sach1.jpg',
            'sach2.jpg',
            'sach3.jpg',
            'sach4.jpg',
        ];

        $name = $this->faker->unique()->name;

        return [
            'name' => $name,
            'slug' => Str::slug($name),
            'mini_description' => $this->faker->randomElement([
                'Cuốn sách giúp cải thiện kỹ năng giao tiếp trong công việc.',
                'Một câu chuyện kỳ thú về tình bạn và lòng trung thực.',
                'Hướng dẫn chi tiết để bắt đầu kinh doanh từ con số 0.',
                'Khám phá những bí ẩn của vũ trụ qua ngôn ngữ khoa học.',
                'Tuyển tập truyện ngắn đầy ý nghĩa về cuộc sống thường nhật.',
                'Cẩm nang học tiếng Anh hiệu quả cho người mới bắt đầu.',
                'Cuốn tiểu thuyết giả tưởng về một thế giới huyền bí.',
                'Sách tham khảo cho học sinh với kiến thức tổng hợp đầy đủ.',
                'Bộ sưu tập thơ ca hiện đại mang đậm cảm xúc lãng mạn.',
                'Cuốn sách giúp bạn đạt được sự cân bằng trong cuộc sống.'
            ]),
            'details_description' => $this->faker->randomElement([
                'Cuốn sách này cung cấp các bài học về giao tiếp hiệu quả trong môi trường doanh nghiệp, từ cách thuyết trình đến nghệ thuật đàm phán.',
                'Câu chuyện xoay quanh hai nhân vật chính và những thử thách mà họ phải vượt qua để bảo vệ tình bạn của mình.',
                'Tác giả chia sẻ kinh nghiệm thực tiễn để xây dựng một doanh nghiệp từ những bước đi nhỏ nhất, kèm theo các ví dụ thực tế.',
                'Khám phá cách thức vận hành của các hành tinh, hố đen và những bí mật mà con người chưa từng biết về vũ trụ.',
                'Tuyển tập các câu chuyện ngắn xoay quanh các mối quan hệ gia đình, bạn bè và những bài học quý giá từ cuộc sống.',
                'Hướng dẫn từng bước học tiếng Anh từ ngữ pháp, từ vựng đến kỹ năng nghe và nói, giúp bạn tự tin giao tiếp.',
                'Cuốn sách đưa bạn vào một thế giới kỳ ảo, nơi các nhân vật phải chiến đấu với những thế lực đen tối để bảo vệ hòa bình.',
                'Tổng hợp các kiến thức quan trọng từ nhiều môn học, giúp học sinh dễ dàng ôn tập và nâng cao kết quả học tập.',
                'Bộ thơ này là hành trình cảm xúc của tác giả, mang đến cho độc giả những phút giây lắng đọng và suy tư.',
                'Tác phẩm chia sẻ các phương pháp đơn giản nhưng hiệu quả để đạt được sự cân bằng giữa công việc, gia đình và sở thích cá nhân.'
            ]),
            'publication_date' => $this->faker->date(),
            'quantity' => $this->faker->numberBetween(1, 500),
            'size' => $this->faker->randomElement(['Small', 'Medium', 'Large']),
            'page' => $this->faker->numberBetween(100, 1000),
            'cover_type' => $this->faker->numberBetween(1, 2),
            'views' => $this->faker->numberBetween(0, 100000),
            'borrowing_number' => $this->faker->numberBetween(0, 5000),
            'image' => $urls[$this->faker->numberBetween(0, 3)],
        ];
    }

    public function withRandomData($authorIds, $publisherIds)
    {
        return $this->state(function (array $attributes) use ($authorIds, $publisherIds) {
            return [
                'author_id' => Arr::random($authorIds),
                'publisher_id' => Arr::random($publisherIds),
            ];
        });
    }
}
