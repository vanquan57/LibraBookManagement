<?php

namespace Database\Seeders;

use App\Models\Province;
use Carbon\Carbon;
use Illuminate\Database\Seeder;

class ProvinceSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $currentTimestamp = Carbon::now();
        
        $provinces = [
            [
                "code" => "833",
                "name" => "An Giang",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "144",
                "name" => "Bắc Giang",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "835",
                "name" => "Bắc Kạn",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "836",
                "name" => "Bạc Liêu",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "837",
                "name" => "Bắc Ninh",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "834",
                "name" => "Bà Rịa - Vũng Tàu",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "838",
                "name" => "Bến Tre",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "826",
                "name" => "Bình Định",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "839",
                "name" => "Bình Dương",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "840",
                "name" => "Bình Phước",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "812",
                "name" => "Bình Thuận",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "841",
                "name" => "Cà Mau",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "806",
                "name" => "Cần Thơ",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "842",
                "name" => "Cao Bằng",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "843",
                "name" => "Đắk Lắk",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "844",
                "name" => "Đắk Nông",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "129",
                "name" => "Đà Nẵng",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "845",
                "name" => "Điện Biên",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "823",
                "name" => "Đồng Nai",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "846",
                "name" => "Đồng Tháp",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "847",
                "name" => "Gia Lai",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "830",
                "name" => "Hà Giang",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "805",
                "name" => "Hải Dương",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "135",
                "name" => "Hải Phòng",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "807",
                "name" => "Hà Nam",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "1",
                "name" => "Hà Nội",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "848",
                "name" => "Hà Tĩnh",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "849",
                "name" => "Hậu Giang",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "850",
                "name" => "Hòa Bình",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "816",
                "name" => "Hưng Yên",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "831",
                "name" => "Khánh Hòa",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "851",
                "name" => "Kiên Giang",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "852",
                "name" => "Kon Tum",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "853",
                "name" => "Lai Châu",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "854",
                "name" => "Lâm Đồng",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "134",
                "name" => "Lạng Sơn",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "808",
                "name" => "Lào Cai",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "855",
                "name" => "Long An",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "811",
                "name" => "Nam Định",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "821",
                "name" => "Nghệ An",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "856",
                "name" => "Ninh Bình",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "857",
                "name" => "Ninh Thuận",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "858",
                "name" => "Phú Thọ",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "869",
                "name" => "Phú Yên",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "818",
                "name" => "Quảng Bình",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "859",
                "name" => "Quảng Nam",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "860",
                "name" => "Quảng Ngãi",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "819",
                "name" => "Quảng Ninh",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "143",
                "name" => "Quảng Trị",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "861",
                "name" => "Sóc Trăng",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "130",
                "name" => "Sơn La",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "862",
                "name" => "Tây Ninh",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "863",
                "name" => "Thái Bình",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "864",
                "name" => "Thái Nguyên",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "865",
                "name" => "Thanh Hóa",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "866",
                "name" => "Thành Phố Huế",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "824",
                "name" => "Tiền Giang",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "126",
                "name" => "Tp Hồ Chí Minh",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "867",
                "name" => "Trà Vinh",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "137",
                "name" => "Tuyên Quang",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "868",
                "name" => "Vĩnh Long",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "827",
                "name" => "Vĩnh Phúc",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "132",
                "name" => "Yên Bái",
                'created_at' => $currentTimestamp,
                'updated_at' => $currentTimestamp
            ],
        ];

        Province::insert($provinces);
    }
}
