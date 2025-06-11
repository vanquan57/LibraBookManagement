<?php

namespace Database\Seeders;

use App\Models\District;
use Carbon\Carbon;
use Illuminate\Database\Seeder;

class DistrictSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $currentTimestamp = Carbon::now();

        $districts = [
            [
                "code" => "1",
                "name" => "Quận Ba Đình",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "2",
                "name" => "Quận Hoàn Kiếm",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "3",
                "name" => "Quận Tây Hồ",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "4",
                "name" => "Quận Long Biên",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "5",
                "name" => "Quận Cầu Giấy",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "6",
                "name" => "Quận Đống Đa",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "7",
                "name" => "Quận Hai Bà Trưng",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "8",
                "name" => "Quận Hoàng Mai",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "9",
                "name" => "Quận Thanh Xuân",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "16",
                "name" => "Huyện Sóc Sơn",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "17",
                "name" => "Huyện Đông Anh",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "18",
                "name" => "Huyện Gia Lâm",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "19",
                "name" => "Quận Nam Từ Liêm",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "20",
                "name" => "Huyện Thanh Trì",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "21",
                "name" => "Quận Bắc Từ Liêm",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "250",
                "name" => "Huyện Mê Linh",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "268",
                "name" => "Quận Hà Đông",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "269",
                "name" => "Thị xã Sơn Tây",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "271",
                "name" => "Huyện Ba Vì",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "272",
                "name" => "Huyện Phúc Thọ",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "273",
                "name" => "Huyện Đan Phượng",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "274",
                "name" => "Huyện Hoài Đức",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "275",
                "name" => "Huyện Quốc Oai",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "276",
                "name" => "Huyện Thạch Thất",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "277",
                "name" => "Huyện Chương Mỹ",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "278",
                "name" => "Huyện Thanh Oai",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "279",
                "name" => "Huyện Thường Tín",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "280",
                "name" => "Huyện Phú Xuyên",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "281",
                "name" => "Huyện Ứng Hòa",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "282",
                "name" => "Huyện Mỹ Đức",
                "province_code" => "1",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "24",
                "name" => "Thành phố Hà Giang",
                "province_code" => "2",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "26",
                "name" => "Huyện Đồng Văn",
                "province_code" => "2",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "27",
                "name" => "Huyện Mèo Vạc",
                "province_code" => "2",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "28",
                "name" => "Huyện Yên Minh",
                "province_code" => "2",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "29",
                "name" => "Huyện Quản Bạ",
                "province_code" => "2",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "30",
                "name" => "Huyện Vị Xuyên",
                "province_code" => "2",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "31",
                "name" => "Huyện Bắc Mê",
                "province_code" => "2",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "32",
                "name" => "Huyện Hoàng Su Phì",
                "province_code" => "2",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "33",
                "name" => "Huyện Xín Mần",
                "province_code" => "2",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "34",
                "name" => "Huyện Bắc Quang",
                "province_code" => "2",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "35",
                "name" => "Huyện Quang Bình",
                "province_code" => "2",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "40",
                "name" => "Thành phố Cao Bằng",
                "province_code" => "4",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "42",
                "name" => "Huyện Bảo Lâm",
                "province_code" => "4",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "43",
                "name" => "Huyện Bảo Lạc",
                "province_code" => "4",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "45",
                "name" => "Huyện Hà Quảng",
                "province_code" => "4",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "47",
                "name" => "Huyện Trùng Khánh",
                "province_code" => "4",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "48",
                "name" => "Huyện Hạ Lang",
                "province_code" => "4",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "49",
                "name" => "Huyện Quảng Hòa",
                "province_code" => "4",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "51",
                "name" => "Huyện Hoà An",
                "province_code" => "4",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "52",
                "name" => "Huyện Nguyên Bình",
                "province_code" => "4",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "53",
                "name" => "Huyện Thạch An",
                "province_code" => "4",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "58",
                "name" => "Thành Phố Bắc Kạn",
                "province_code" => "6",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "60",
                "name" => "Huyện Pác Nặm",
                "province_code" => "6",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "61",
                "name" => "Huyện Ba Bể",
                "province_code" => "6",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "62",
                "name" => "Huyện Ngân Sơn",
                "province_code" => "6",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "63",
                "name" => "Huyện Bạch Thông",
                "province_code" => "6",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "64",
                "name" => "Huyện Chợ Đồn",
                "province_code" => "6",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "65",
                "name" => "Huyện Chợ Mới",
                "province_code" => "6",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "66",
                "name" => "Huyện Na Rì",
                "province_code" => "6",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "70",
                "name" => "Thành phố Tuyên Quang",
                "province_code" => "8",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "71",
                "name" => "Huyện Lâm Bình",
                "province_code" => "8",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "72",
                "name" => "Huyện Na Hang",
                "province_code" => "8",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "73",
                "name" => "Huyện Chiêm Hóa",
                "province_code" => "8",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "74",
                "name" => "Huyện Hàm Yên",
                "province_code" => "8",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "75",
                "name" => "Huyện Yên Sơn",
                "province_code" => "8",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "76",
                "name" => "Huyện Sơn Dương",
                "province_code" => "8",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "80",
                "name" => "Thành phố Lào Cai",
                "province_code" => "10",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "82",
                "name" => "Huyện Bát Xát",
                "province_code" => "10",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "83",
                "name" => "Huyện Mường Khương",
                "province_code" => "10",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "84",
                "name" => "Huyện Si Ma Cai",
                "province_code" => "10",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "85",
                "name" => "Huyện Bắc Hà",
                "province_code" => "10",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "86",
                "name" => "Huyện Bảo Thắng",
                "province_code" => "10",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "87",
                "name" => "Huyện Bảo Yên",
                "province_code" => "10",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "88",
                "name" => "Thị xã Sa Pa",
                "province_code" => "10",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "89",
                "name" => "Huyện Văn Bàn",
                "province_code" => "10",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "94",
                "name" => "Thành phố Điện Biên Phủ",
                "province_code" => "11",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "95",
                "name" => "Thị xã Mường Lay",
                "province_code" => "11",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "96",
                "name" => "Huyện Mường Nhé",
                "province_code" => "11",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "97",
                "name" => "Huyện Mường Chà",
                "province_code" => "11",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "98",
                "name" => "Huyện Tủa Chùa",
                "province_code" => "11",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "99",
                "name" => "Huyện Tuần Giáo",
                "province_code" => "11",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "100",
                "name" => "Huyện Điện Biên",
                "province_code" => "11",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "101",
                "name" => "Huyện Điện Biên Đông",
                "province_code" => "11",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "102",
                "name" => "Huyện Mường Ảng",
                "province_code" => "11",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "103",
                "name" => "Huyện Nậm Pồ",
                "province_code" => "11",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "105",
                "name" => "Thành phố Lai Châu",
                "province_code" => "12",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "106",
                "name" => "Huyện Tam Đường",
                "province_code" => "12",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "107",
                "name" => "Huyện Mường Tè",
                "province_code" => "12",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "108",
                "name" => "Huyện Sìn Hồ",
                "province_code" => "12",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "109",
                "name" => "Huyện Phong Thổ",
                "province_code" => "12",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "110",
                "name" => "Huyện Than Uyên",
                "province_code" => "12",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "111",
                "name" => "Huyện Tân Uyên",
                "province_code" => "12",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "112",
                "name" => "Huyện Nậm Nhùn",
                "province_code" => "12",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "116",
                "name" => "Thành phố Sơn La",
                "province_code" => "14",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "118",
                "name" => "Huyện Quỳnh Nhai",
                "province_code" => "14",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "119",
                "name" => "Huyện Thuận Châu",
                "province_code" => "14",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "120",
                "name" => "Huyện Mường La",
                "province_code" => "14",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "121",
                "name" => "Huyện Bắc Yên",
                "province_code" => "14",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "122",
                "name" => "Huyện Phù Yên",
                "province_code" => "14",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "123",
                "name" => "Huyện Mộc Châu",
                "province_code" => "14",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "124",
                "name" => "Huyện Yên Châu",
                "province_code" => "14",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "125",
                "name" => "Huyện Mai Sơn",
                "province_code" => "14",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "126",
                "name" => "Huyện Sông Mã",
                "province_code" => "14",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "127",
                "name" => "Huyện Sốp Cộp",
                "province_code" => "14",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "128",
                "name" => "Huyện Vân Hồ",
                "province_code" => "14",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "132",
                "name" => "Thành phố Yên Bái",
                "province_code" => "15",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "133",
                "name" => "Thị xã Nghĩa Lộ",
                "province_code" => "15",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "135",
                "name" => "Huyện Lục Yên",
                "province_code" => "15",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "136",
                "name" => "Huyện Văn Yên",
                "province_code" => "15",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "137",
                "name" => "Huyện Mù Căng Chải",
                "province_code" => "15",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "138",
                "name" => "Huyện Trấn Yên",
                "province_code" => "15",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "139",
                "name" => "Huyện Trạm Tấu",
                "province_code" => "15",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "140",
                "name" => "Huyện Văn Chấn",
                "province_code" => "15",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "141",
                "name" => "Huyện Yên Bình",
                "province_code" => "15",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "148",
                "name" => "Thành phố Hòa Bình",
                "province_code" => "17",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "150",
                "name" => "Huyện Đà Bắc",
                "province_code" => "17",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "152",
                "name" => "Huyện Lương Sơn",
                "province_code" => "17",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "153",
                "name" => "Huyện Kim Bôi",
                "province_code" => "17",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "154",
                "name" => "Huyện Cao Phong",
                "province_code" => "17",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "155",
                "name" => "Huyện Tân Lạc",
                "province_code" => "17",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "156",
                "name" => "Huyện Mai Châu",
                "province_code" => "17",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "157",
                "name" => "Huyện Lạc Sơn",
                "province_code" => "17",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "158",
                "name" => "Huyện Yên Thủy",
                "province_code" => "17",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "159",
                "name" => "Huyện Lạc Thủy",
                "province_code" => "17",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "164",
                "name" => "Thành phố Thái Nguyên",
                "province_code" => "19",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "165",
                "name" => "Thành phố Sông Công",
                "province_code" => "19",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "167",
                "name" => "Huyện Định Hóa",
                "province_code" => "19",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "168",
                "name" => "Huyện Phú Lương",
                "province_code" => "19",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "169",
                "name" => "Huyện Đồng Hỷ",
                "province_code" => "19",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "170",
                "name" => "Huyện Võ Nhai",
                "province_code" => "19",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "171",
                "name" => "Huyện Đại Từ",
                "province_code" => "19",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "172",
                "name" => "Thành phố Phổ Yên",
                "province_code" => "19",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "173",
                "name" => "Huyện Phú Bình",
                "province_code" => "19",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "178",
                "name" => "Thành phố Lạng Sơn",
                "province_code" => "20",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "180",
                "name" => "Huyện Tràng Định",
                "province_code" => "20",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "181",
                "name" => "Huyện Bình Gia",
                "province_code" => "20",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "182",
                "name" => "Huyện Văn Lãng",
                "province_code" => "20",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "183",
                "name" => "Huyện Cao Lộc",
                "province_code" => "20",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "184",
                "name" => "Huyện Văn Quan",
                "province_code" => "20",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "185",
                "name" => "Huyện Bắc Sơn",
                "province_code" => "20",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "186",
                "name" => "Huyện Hữu Lũng",
                "province_code" => "20",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "187",
                "name" => "Huyện Chi Lăng",
                "province_code" => "20",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "188",
                "name" => "Huyện Lộc Bình",
                "province_code" => "20",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "189",
                "name" => "Huyện Đình Lập",
                "province_code" => "20",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "193",
                "name" => "Thành phố Hạ Long",
                "province_code" => "22",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "194",
                "name" => "Thành phố Móng Cái",
                "province_code" => "22",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "195",
                "name" => "Thành phố Cẩm Phả",
                "province_code" => "22",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "196",
                "name" => "Thành phố Uông Bí",
                "province_code" => "22",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "198",
                "name" => "Huyện Bình Liêu",
                "province_code" => "22",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "199",
                "name" => "Huyện Tiên Yên",
                "province_code" => "22",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "200",
                "name" => "Huyện Đầm Hà",
                "province_code" => "22",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "201",
                "name" => "Huyện Hải Hà",
                "province_code" => "22",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "202",
                "name" => "Huyện Ba Chẽ",
                "province_code" => "22",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "203",
                "name" => "Huyện Vân Đồn",
                "province_code" => "22",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "205",
                "name" => "Thị xã Đông Triều",
                "province_code" => "22",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "206",
                "name" => "Thị xã Quảng Yên",
                "province_code" => "22",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "207",
                "name" => "Huyện Cô Tô",
                "province_code" => "22",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "213",
                "name" => "Thành phố Bắc Giang",
                "province_code" => "24",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "215",
                "name" => "Huyện Yên Thế",
                "province_code" => "24",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "216",
                "name" => "Huyện Tân Yên",
                "province_code" => "24",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "217",
                "name" => "Huyện Lạng Giang",
                "province_code" => "24",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "218",
                "name" => "Huyện Lục Nam",
                "province_code" => "24",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "219",
                "name" => "Huyện Lục Ngạn",
                "province_code" => "24",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "220",
                "name" => "Huyện Sơn Động",
                "province_code" => "24",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "221",
                "name" => "Huyện Yên Dũng",
                "province_code" => "24",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "222",
                "name" => "Huyện Việt Yên",
                "province_code" => "24",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "223",
                "name" => "Huyện Hiệp Hòa",
                "province_code" => "24",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "227",
                "name" => "Thành phố Việt Trì",
                "province_code" => "25",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "228",
                "name" => "Thị xã Phú Thọ",
                "province_code" => "25",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "230",
                "name" => "Huyện Đoan Hùng",
                "province_code" => "25",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "231",
                "name" => "Huyện Hạ Hoà",
                "province_code" => "25",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "232",
                "name" => "Huyện Thanh Ba",
                "province_code" => "25",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "233",
                "name" => "Huyện Phù Ninh",
                "province_code" => "25",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "234",
                "name" => "Huyện Yên Lập",
                "province_code" => "25",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "235",
                "name" => "Huyện Cẩm Khê",
                "province_code" => "25",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "236",
                "name" => "Huyện Tam Nông",
                "province_code" => "25",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "237",
                "name" => "Huyện Lâm Thao",
                "province_code" => "25",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "238",
                "name" => "Huyện Thanh Sơn",
                "province_code" => "25",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "239",
                "name" => "Huyện Thanh Thuỷ",
                "province_code" => "25",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "240",
                "name" => "Huyện Tân Sơn",
                "province_code" => "25",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "243",
                "name" => "Thành phố Vĩnh Yên",
                "province_code" => "26",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "244",
                "name" => "Thành phố Phúc Yên",
                "province_code" => "26",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "246",
                "name" => "Huyện Lập Thạch",
                "province_code" => "26",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "247",
                "name" => "Huyện Tam Dương",
                "province_code" => "26",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "248",
                "name" => "Huyện Tam Đảo",
                "province_code" => "26",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "249",
                "name" => "Huyện Bình Xuyên",
                "province_code" => "26",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "251",
                "name" => "Huyện Yên Lạc",
                "province_code" => "26",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "252",
                "name" => "Huyện Vĩnh Tường",
                "province_code" => "26",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "253",
                "name" => "Huyện Sông Lô",
                "province_code" => "26",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "256",
                "name" => "Thành phố Bắc Ninh",
                "province_code" => "27",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "258",
                "name" => "Huyện Yên Phong",
                "province_code" => "27",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "259",
                "name" => "Thị xã Quế Võ",
                "province_code" => "27",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "260",
                "name" => "Huyện Tiên Du",
                "province_code" => "27",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "261",
                "name" => "Thành phố Từ Sơn",
                "province_code" => "27",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "262",
                "name" => "Thị xã Thuận Thành",
                "province_code" => "27",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "263",
                "name" => "Huyện Gia Bình",
                "province_code" => "27",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "264",
                "name" => "Huyện Lương Tài",
                "province_code" => "27",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "288",
                "name" => "Thành phố Hải Dương",
                "province_code" => "30",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "290",
                "name" => "Thành phố Chí Linh",
                "province_code" => "30",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "291",
                "name" => "Huyện Nam Sách",
                "province_code" => "30",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "292",
                "name" => "Thị xã Kinh Môn",
                "province_code" => "30",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "293",
                "name" => "Huyện Kim Thành",
                "province_code" => "30",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "294",
                "name" => "Huyện Thanh Hà",
                "province_code" => "30",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "295",
                "name" => "Huyện Cẩm Giàng",
                "province_code" => "30",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "296",
                "name" => "Huyện Bình Giang",
                "province_code" => "30",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "297",
                "name" => "Huyện Gia Lộc",
                "province_code" => "30",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "298",
                "name" => "Huyện Tứ Kỳ",
                "province_code" => "30",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "299",
                "name" => "Huyện Ninh Giang",
                "province_code" => "30",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "300",
                "name" => "Huyện Thanh Miện",
                "province_code" => "30",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "303",
                "name" => "Quận Hồng Bàng",
                "province_code" => "31",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "304",
                "name" => "Quận Ngô Quyền",
                "province_code" => "31",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "305",
                "name" => "Quận Lê Chân",
                "province_code" => "31",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "306",
                "name" => "Quận Hải An",
                "province_code" => "31",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "307",
                "name" => "Quận Kiến An",
                "province_code" => "31",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "308",
                "name" => "Quận Đồ Sơn",
                "province_code" => "31",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "309",
                "name" => "Quận Dương Kinh",
                "province_code" => "31",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "311",
                "name" => "Huyện Thuỷ Nguyên",
                "province_code" => "31",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "312",
                "name" => "Huyện An Dương",
                "province_code" => "31",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "313",
                "name" => "Huyện An Lão",
                "province_code" => "31",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "314",
                "name" => "Huyện Kiến Thuỵ",
                "province_code" => "31",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "315",
                "name" => "Huyện Tiên Lãng",
                "province_code" => "31",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "316",
                "name" => "Huyện Vĩnh Bảo",
                "province_code" => "31",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "317",
                "name" => "Huyện Cát Hải",
                "province_code" => "31",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "318",
                "name" => "Huyện Bạch Long Vĩ",
                "province_code" => "31",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "323",
                "name" => "Thành phố Hưng Yên",
                "province_code" => "33",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "325",
                "name" => "Huyện Văn Lâm",
                "province_code" => "33",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "326",
                "name" => "Huyện Văn Giang",
                "province_code" => "33",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "327",
                "name" => "Huyện Yên Mỹ",
                "province_code" => "33",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "328",
                "name" => "Thị xã Mỹ Hào",
                "province_code" => "33",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "329",
                "name" => "Huyện Ân Thi",
                "province_code" => "33",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "330",
                "name" => "Huyện Khoái Châu",
                "province_code" => "33",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "331",
                "name" => "Huyện Kim Động",
                "province_code" => "33",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "332",
                "name" => "Huyện Tiên Lữ",
                "province_code" => "33",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "333",
                "name" => "Huyện Phù Cừ",
                "province_code" => "33",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "336",
                "name" => "Thành phố Thái Bình",
                "province_code" => "34",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "338",
                "name" => "Huyện Quỳnh Phụ",
                "province_code" => "34",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "339",
                "name" => "Huyện Hưng Hà",
                "province_code" => "34",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "340",
                "name" => "Huyện Đông Hưng",
                "province_code" => "34",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "341",
                "name" => "Huyện Thái Thụy",
                "province_code" => "34",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "342",
                "name" => "Huyện Tiền Hải",
                "province_code" => "34",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "343",
                "name" => "Huyện Kiến Xương",
                "province_code" => "34",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "344",
                "name" => "Huyện Vũ Thư",
                "province_code" => "34",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "347",
                "name" => "Thành phố Phủ Lý",
                "province_code" => "35",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "349",
                "name" => "Thị xã Duy Tiên",
                "province_code" => "35",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "350",
                "name" => "Huyện Kim Bảng",
                "province_code" => "35",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "351",
                "name" => "Huyện Thanh Liêm",
                "province_code" => "35",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "352",
                "name" => "Huyện Bình Lục",
                "province_code" => "35",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "353",
                "name" => "Huyện Lý Nhân",
                "province_code" => "35",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "356",
                "name" => "Thành phố Nam Định",
                "province_code" => "36",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "358",
                "name" => "Huyện Mỹ Lộc",
                "province_code" => "36",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "359",
                "name" => "Huyện Vụ Bản",
                "province_code" => "36",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "360",
                "name" => "Huyện Ý Yên",
                "province_code" => "36",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "361",
                "name" => "Huyện Nghĩa Hưng",
                "province_code" => "36",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "362",
                "name" => "Huyện Nam Trực",
                "province_code" => "36",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "363",
                "name" => "Huyện Trực Ninh",
                "province_code" => "36",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "364",
                "name" => "Huyện Xuân Trường",
                "province_code" => "36",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "365",
                "name" => "Huyện Giao Thủy",
                "province_code" => "36",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "366",
                "name" => "Huyện Hải Hậu",
                "province_code" => "36",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "369",
                "name" => "Thành phố Ninh Bình",
                "province_code" => "37",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "370",
                "name" => "Thành phố Tam Điệp",
                "province_code" => "37",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "372",
                "name" => "Huyện Nho Quan",
                "province_code" => "37",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "373",
                "name" => "Huyện Gia Viễn",
                "province_code" => "37",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "374",
                "name" => "Huyện Hoa Lư",
                "province_code" => "37",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "375",
                "name" => "Huyện Yên Khánh",
                "province_code" => "37",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "376",
                "name" => "Huyện Kim Sơn",
                "province_code" => "37",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "377",
                "name" => "Huyện Yên Mô",
                "province_code" => "37",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "380",
                "name" => "Thành phố Thanh Hóa",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "381",
                "name" => "Thị xã Bỉm Sơn",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "382",
                "name" => "Thành phố Sầm Sơn",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "384",
                "name" => "Huyện Mường Lát",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "385",
                "name" => "Huyện Quan Hóa",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "386",
                "name" => "Huyện Bá Thước",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "387",
                "name" => "Huyện Quan Sơn",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "388",
                "name" => "Huyện Lang Chánh",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "389",
                "name" => "Huyện Ngọc Lặc",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "390",
                "name" => "Huyện Cẩm Thủy",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "391",
                "name" => "Huyện Thạch Thành",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "392",
                "name" => "Huyện Hà Trung",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "393",
                "name" => "Huyện Vĩnh Lộc",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "394",
                "name" => "Huyện Yên Định",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "395",
                "name" => "Huyện Thọ Xuân",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "396",
                "name" => "Huyện Thường Xuân",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "397",
                "name" => "Huyện Triệu Sơn",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "398",
                "name" => "Huyện Thiệu Hóa",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "399",
                "name" => "Huyện Hoằng Hóa",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "400",
                "name" => "Huyện Hậu Lộc",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "401",
                "name" => "Huyện Nga Sơn",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "402",
                "name" => "Huyện Như Xuân",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "403",
                "name" => "Huyện Như Thanh",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "404",
                "name" => "Huyện Nông Cống",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "405",
                "name" => "Huyện Đông Sơn",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "406",
                "name" => "Huyện Quảng Xương",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "407",
                "name" => "Thị xã Nghi Sơn",
                "province_code" => "38",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "412",
                "name" => "Thành phố Vinh",
                "province_code" => "40",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "413",
                "name" => "Thị xã Cửa Lò",
                "province_code" => "40",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "414",
                "name" => "Thị xã Thái Hoà",
                "province_code" => "40",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "415",
                "name" => "Huyện Quế Phong",
                "province_code" => "40",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "416",
                "name" => "Huyện Quỳ Châu",
                "province_code" => "40",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "417",
                "name" => "Huyện Kỳ Sơn",
                "province_code" => "40",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "418",
                "name" => "Huyện Tương Dương",
                "province_code" => "40",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "419",
                "name" => "Huyện Nghĩa Đàn",
                "province_code" => "40",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "420",
                "name" => "Huyện Quỳ Hợp",
                "province_code" => "40",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "421",
                "name" => "Huyện Quỳnh Lưu",
                "province_code" => "40",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "422",
                "name" => "Huyện Con Cuông",
                "province_code" => "40",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "423",
                "name" => "Huyện Tân Kỳ",
                "province_code" => "40",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "424",
                "name" => "Huyện Anh Sơn",
                "province_code" => "40",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "425",
                "name" => "Huyện Diễn Châu",
                "province_code" => "40",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "426",
                "name" => "Huyện Yên Thành",
                "province_code" => "40",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "427",
                "name" => "Huyện Đô Lương",
                "province_code" => "40",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "428",
                "name" => "Huyện Thanh Chương",
                "province_code" => "40",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "429",
                "name" => "Huyện Nghi Lộc",
                "province_code" => "40",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "430",
                "name" => "Huyện Nam Đàn",
                "province_code" => "40",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "431",
                "name" => "Huyện Hưng Nguyên",
                "province_code" => "40",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "432",
                "name" => "Thị xã Hoàng Mai",
                "province_code" => "40",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "436",
                "name" => "Thành phố Hà Tĩnh",
                "province_code" => "42",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "437",
                "name" => "Thị xã Hồng Lĩnh",
                "province_code" => "42",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "439",
                "name" => "Huyện Hương Sơn",
                "province_code" => "42",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "440",
                "name" => "Huyện Đức Thọ",
                "province_code" => "42",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "441",
                "name" => "Huyện Vũ Quang",
                "province_code" => "42",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "442",
                "name" => "Huyện Nghi Xuân",
                "province_code" => "42",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "443",
                "name" => "Huyện Can Lộc",
                "province_code" => "42",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "444",
                "name" => "Huyện Hương Khê",
                "province_code" => "42",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "445",
                "name" => "Huyện Thạch Hà",
                "province_code" => "42",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "446",
                "name" => "Huyện Cẩm Xuyên",
                "province_code" => "42",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "447",
                "name" => "Huyện Kỳ Anh",
                "province_code" => "42",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "448",
                "name" => "Huyện Lộc Hà",
                "province_code" => "42",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "449",
                "name" => "Thị xã Kỳ Anh",
                "province_code" => "42",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "450",
                "name" => "Thành Phố Đồng Hới",
                "province_code" => "44",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "452",
                "name" => "Huyện Minh Hóa",
                "province_code" => "44",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "453",
                "name" => "Huyện Tuyên Hóa",
                "province_code" => "44",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "454",
                "name" => "Huyện Quảng Trạch",
                "province_code" => "44",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "455",
                "name" => "Huyện Bố Trạch",
                "province_code" => "44",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "456",
                "name" => "Huyện Quảng Ninh",
                "province_code" => "44",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "457",
                "name" => "Huyện Lệ Thủy",
                "province_code" => "44",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "458",
                "name" => "Thị xã Ba Đồn",
                "province_code" => "44",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "461",
                "name" => "Thành phố Đông Hà",
                "province_code" => "45",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "462",
                "name" => "Thị xã Quảng Trị",
                "province_code" => "45",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "464",
                "name" => "Huyện Vĩnh Linh",
                "province_code" => "45",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "465",
                "name" => "Huyện Hướng Hóa",
                "province_code" => "45",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "466",
                "name" => "Huyện Gio Linh",
                "province_code" => "45",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "467",
                "name" => "Huyện Đa Krông",
                "province_code" => "45",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "468",
                "name" => "Huyện Cam Lộ",
                "province_code" => "45",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "469",
                "name" => "Huyện Triệu Phong",
                "province_code" => "45",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "470",
                "name" => "Huyện Hải Lăng",
                "province_code" => "45",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "471",
                "name" => "Huyện Cồn Cỏ",
                "province_code" => "45",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "474",
                "name" => "Thành phố Huế",
                "province_code" => "46",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "476",
                "name" => "Huyện Phong Điền",
                "province_code" => "46",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "477",
                "name" => "Huyện Quảng Điền",
                "province_code" => "46",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "478",
                "name" => "Huyện Phú Vang",
                "province_code" => "46",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "479",
                "name" => "Thị xã Hương Thủy",
                "province_code" => "46",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "480",
                "name" => "Thị xã Hương Trà",
                "province_code" => "46",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "481",
                "name" => "Huyện A Lưới",
                "province_code" => "46",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "482",
                "name" => "Huyện Phú Lộc",
                "province_code" => "46",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "483",
                "name" => "Huyện Nam Đông",
                "province_code" => "46",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "490",
                "name" => "Quận Liên Chiểu",
                "province_code" => "48",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "491",
                "name" => "Quận Thanh Khê",
                "province_code" => "48",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "492",
                "name" => "Quận Hải Châu",
                "province_code" => "48",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "493",
                "name" => "Quận Sơn Trà",
                "province_code" => "48",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "494",
                "name" => "Quận Ngũ Hành Sơn",
                "province_code" => "48",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "495",
                "name" => "Quận Cẩm Lệ",
                "province_code" => "48",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "497",
                "name" => "Huyện Hòa Vang",
                "province_code" => "48",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "498",
                "name" => "Huyện Hoàng Sa",
                "province_code" => "48",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "502",
                "name" => "Thành phố Tam Kỳ",
                "province_code" => "49",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "503",
                "name" => "Thành phố Hội An",
                "province_code" => "49",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "504",
                "name" => "Huyện Tây Giang",
                "province_code" => "49",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "505",
                "name" => "Huyện Đông Giang",
                "province_code" => "49",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "506",
                "name" => "Huyện Đại Lộc",
                "province_code" => "49",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "507",
                "name" => "Thị xã Điện Bàn",
                "province_code" => "49",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "508",
                "name" => "Huyện Duy Xuyên",
                "province_code" => "49",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "509",
                "name" => "Huyện Quế Sơn",
                "province_code" => "49",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "510",
                "name" => "Huyện Nam Giang",
                "province_code" => "49",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "511",
                "name" => "Huyện Phước Sơn",
                "province_code" => "49",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "512",
                "name" => "Huyện Hiệp Đức",
                "province_code" => "49",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "513",
                "name" => "Huyện Thăng Bình",
                "province_code" => "49",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "514",
                "name" => "Huyện Tiên Phước",
                "province_code" => "49",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "515",
                "name" => "Huyện Bắc Trà My",
                "province_code" => "49",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "516",
                "name" => "Huyện Nam Trà My",
                "province_code" => "49",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "517",
                "name" => "Huyện Núi Thành",
                "province_code" => "49",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "518",
                "name" => "Huyện Phú Ninh",
                "province_code" => "49",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "519",
                "name" => "Huyện Nông Sơn",
                "province_code" => "49",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "522",
                "name" => "Thành phố Quảng Ngãi",
                "province_code" => "51",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "524",
                "name" => "Huyện Bình Sơn",
                "province_code" => "51",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "525",
                "name" => "Huyện Trà Bồng",
                "province_code" => "51",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "527",
                "name" => "Huyện Sơn Tịnh",
                "province_code" => "51",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "528",
                "name" => "Huyện Tư Nghĩa",
                "province_code" => "51",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "529",
                "name" => "Huyện Sơn Hà",
                "province_code" => "51",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "530",
                "name" => "Huyện Sơn Tây",
                "province_code" => "51",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "531",
                "name" => "Huyện Minh Long",
                "province_code" => "51",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "532",
                "name" => "Huyện Nghĩa Hành",
                "province_code" => "51",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "533",
                "name" => "Huyện Mộ Đức",
                "province_code" => "51",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "534",
                "name" => "Thị xã Đức Phổ",
                "province_code" => "51",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "535",
                "name" => "Huyện Ba Tơ",
                "province_code" => "51",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "536",
                "name" => "Huyện Lý Sơn",
                "province_code" => "51",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "540",
                "name" => "Thành phố Quy Nhơn",
                "province_code" => "52",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "542",
                "name" => "Huyện An Lão",
                "province_code" => "52",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "543",
                "name" => "Thị xã Hoài Nhơn",
                "province_code" => "52",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "544",
                "name" => "Huyện Hoài Ân",
                "province_code" => "52",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "545",
                "name" => "Huyện Phù Mỹ",
                "province_code" => "52",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "546",
                "name" => "Huyện Vĩnh Thạnh",
                "province_code" => "52",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "547",
                "name" => "Huyện Tây Sơn",
                "province_code" => "52",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "548",
                "name" => "Huyện Phù Cát",
                "province_code" => "52",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "549",
                "name" => "Thị xã An Nhơn",
                "province_code" => "52",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "550",
                "name" => "Huyện Tuy Phước",
                "province_code" => "52",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "551",
                "name" => "Huyện Vân Canh",
                "province_code" => "52",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "555",
                "name" => "Thành phố Tuy Hoà",
                "province_code" => "54",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "557",
                "name" => "Thị xã Sông Cầu",
                "province_code" => "54",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "558",
                "name" => "Huyện Đồng Xuân",
                "province_code" => "54",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "559",
                "name" => "Huyện Tuy An",
                "province_code" => "54",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "560",
                "name" => "Huyện Sơn Hòa",
                "province_code" => "54",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "561",
                "name" => "Huyện Sông Hinh",
                "province_code" => "54",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "562",
                "name" => "Huyện Tây Hoà",
                "province_code" => "54",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "563",
                "name" => "Huyện Phú Hoà",
                "province_code" => "54",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "564",
                "name" => "Thị xã Đông Hòa",
                "province_code" => "54",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "568",
                "name" => "Thành phố Nha Trang",
                "province_code" => "56",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "569",
                "name" => "Thành phố Cam Ranh",
                "province_code" => "56",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "570",
                "name" => "Huyện Cam Lâm",
                "province_code" => "56",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "571",
                "name" => "Huyện Vạn Ninh",
                "province_code" => "56",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "572",
                "name" => "Thị xã Ninh Hòa",
                "province_code" => "56",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "573",
                "name" => "Huyện Khánh Vĩnh",
                "province_code" => "56",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "574",
                "name" => "Huyện Diên Khánh",
                "province_code" => "56",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "575",
                "name" => "Huyện Khánh Sơn",
                "province_code" => "56",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "576",
                "name" => "Huyện Trường Sa",
                "province_code" => "56",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "582",
                "name" => "Thành phố Phan Rang-Tháp Chàm",
                "province_code" => "58",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "584",
                "name" => "Huyện Bác Ái",
                "province_code" => "58",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "585",
                "name" => "Huyện Ninh Sơn",
                "province_code" => "58",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "586",
                "name" => "Huyện Ninh Hải",
                "province_code" => "58",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "587",
                "name" => "Huyện Ninh Phước",
                "province_code" => "58",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "588",
                "name" => "Huyện Thuận Bắc",
                "province_code" => "58",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "589",
                "name" => "Huyện Thuận Nam",
                "province_code" => "58",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "593",
                "name" => "Thành phố Phan Thiết",
                "province_code" => "60",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "594",
                "name" => "Thị xã La Gi",
                "province_code" => "60",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "595",
                "name" => "Huyện Tuy Phong",
                "province_code" => "60",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "596",
                "name" => "Huyện Bắc Bình",
                "province_code" => "60",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "597",
                "name" => "Huyện Hàm Thuận Bắc",
                "province_code" => "60",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "598",
                "name" => "Huyện Hàm Thuận Nam",
                "province_code" => "60",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "599",
                "name" => "Huyện Tánh Linh",
                "province_code" => "60",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "600",
                "name" => "Huyện Đức Linh",
                "province_code" => "60",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "601",
                "name" => "Huyện Hàm Tân",
                "province_code" => "60",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "602",
                "name" => "Huyện Phú Quí",
                "province_code" => "60",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "608",
                "name" => "Thành phố Kon Tum",
                "province_code" => "62",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "610",
                "name" => "Huyện Đắk Glei",
                "province_code" => "62",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "611",
                "name" => "Huyện Ngọc Hồi",
                "province_code" => "62",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "612",
                "name" => "Huyện Đắk Tô",
                "province_code" => "62",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "613",
                "name" => "Huyện Kon Plông",
                "province_code" => "62",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "614",
                "name" => "Huyện Kon Rẫy",
                "province_code" => "62",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "615",
                "name" => "Huyện Đắk Hà",
                "province_code" => "62",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "616",
                "name" => "Huyện Sa Thầy",
                "province_code" => "62",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "617",
                "name" => "Huyện Tu Mơ Rông",
                "province_code" => "62",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "618",
                "name" => "Huyện Ia H' Drai",
                "province_code" => "62",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "622",
                "name" => "Thành phố Pleiku",
                "province_code" => "64",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "623",
                "name" => "Thị xã An Khê",
                "province_code" => "64",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "624",
                "name" => "Thị xã Ayun Pa",
                "province_code" => "64",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "625",
                "name" => "Huyện KBang",
                "province_code" => "64",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "626",
                "name" => "Huyện Đăk Đoa",
                "province_code" => "64",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "627",
                "name" => "Huyện Chư Păh",
                "province_code" => "64",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "628",
                "name" => "Huyện Ia Grai",
                "province_code" => "64",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "629",
                "name" => "Huyện Mang Yang",
                "province_code" => "64",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "630",
                "name" => "Huyện Kông Chro",
                "province_code" => "64",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "631",
                "name" => "Huyện Đức Cơ",
                "province_code" => "64",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "632",
                "name" => "Huyện Chư Prông",
                "province_code" => "64",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "633",
                "name" => "Huyện Chư Sê",
                "province_code" => "64",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "634",
                "name" => "Huyện Đăk Pơ",
                "province_code" => "64",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "635",
                "name" => "Huyện Ia Pa",
                "province_code" => "64",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "637",
                "name" => "Huyện Krông Pa",
                "province_code" => "64",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "638",
                "name" => "Huyện Phú Thiện",
                "province_code" => "64",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "639",
                "name" => "Huyện Chư Pưh",
                "province_code" => "64",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "643",
                "name" => "Thành phố Buôn Ma Thuột",
                "province_code" => "66",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "644",
                "name" => "Thị xã Buôn Hồ",
                "province_code" => "66",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "645",
                "name" => "Huyện Ea H'leo",
                "province_code" => "66",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "646",
                "name" => "Huyện Ea Súp",
                "province_code" => "66",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "647",
                "name" => "Huyện Buôn Đôn",
                "province_code" => "66",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "648",
                "name" => "Huyện Cư M'gar",
                "province_code" => "66",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "649",
                "name" => "Huyện Krông Búk",
                "province_code" => "66",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "650",
                "name" => "Huyện Krông Năng",
                "province_code" => "66",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "651",
                "name" => "Huyện Ea Kar",
                "province_code" => "66",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "652",
                "name" => "Huyện M'Đrắk",
                "province_code" => "66",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "653",
                "name" => "Huyện Krông Bông",
                "province_code" => "66",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "654",
                "name" => "Huyện Krông Pắc",
                "province_code" => "66",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "655",
                "name" => "Huyện Krông A Na",
                "province_code" => "66",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "656",
                "name" => "Huyện Lắk",
                "province_code" => "66",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "657",
                "name" => "Huyện Cư Kuin",
                "province_code" => "66",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "660",
                "name" => "Thành phố Gia Nghĩa",
                "province_code" => "67",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "661",
                "name" => "Huyện Đăk Glong",
                "province_code" => "67",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "662",
                "name" => "Huyện Cư Jút",
                "province_code" => "67",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "663",
                "name" => "Huyện Đắk Mil",
                "province_code" => "67",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "664",
                "name" => "Huyện Krông Nô",
                "province_code" => "67",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "665",
                "name" => "Huyện Đắk Song",
                "province_code" => "67",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "666",
                "name" => "Huyện Đắk R'Lấp",
                "province_code" => "67",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "667",
                "name" => "Huyện Tuy Đức",
                "province_code" => "67",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "672",
                "name" => "Thành phố Đà Lạt",
                "province_code" => "68",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "673",
                "name" => "Thành phố Bảo Lộc",
                "province_code" => "68",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "674",
                "name" => "Huyện Đam Rông",
                "province_code" => "68",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "675",
                "name" => "Huyện Lạc Dương",
                "province_code" => "68",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "676",
                "name" => "Huyện Lâm Hà",
                "province_code" => "68",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "677",
                "name" => "Huyện Đơn Dương",
                "province_code" => "68",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "678",
                "name" => "Huyện Đức Trọng",
                "province_code" => "68",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "679",
                "name" => "Huyện Di Linh",
                "province_code" => "68",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "680",
                "name" => "Huyện Bảo Lâm",
                "province_code" => "68",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "681",
                "name" => "Huyện Đạ Huoai",
                "province_code" => "68",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "682",
                "name" => "Huyện Đạ Tẻh",
                "province_code" => "68",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "683",
                "name" => "Huyện Cát Tiên",
                "province_code" => "68",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "688",
                "name" => "Thị xã Phước Long",
                "province_code" => "70",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "689",
                "name" => "Thành phố Đồng Xoài",
                "province_code" => "70",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "690",
                "name" => "Thị xã Bình Long",
                "province_code" => "70",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "691",
                "name" => "Huyện Bù Gia Mập",
                "province_code" => "70",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "692",
                "name" => "Huyện Lộc Ninh",
                "province_code" => "70",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "693",
                "name" => "Huyện Bù Đốp",
                "province_code" => "70",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "694",
                "name" => "Huyện Hớn Quản",
                "province_code" => "70",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "695",
                "name" => "Huyện Đồng Phú",
                "province_code" => "70",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "696",
                "name" => "Huyện Bù Đăng",
                "province_code" => "70",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "697",
                "name" => "Thị xã Chơn Thành",
                "province_code" => "70",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "698",
                "name" => "Huyện Phú Riềng",
                "province_code" => "70",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "703",
                "name" => "Thành phố Tây Ninh",
                "province_code" => "72",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "705",
                "name" => "Huyện Tân Biên",
                "province_code" => "72",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "706",
                "name" => "Huyện Tân Châu",
                "province_code" => "72",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "707",
                "name" => "Huyện Dương Minh Châu",
                "province_code" => "72",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "708",
                "name" => "Huyện Châu Thành",
                "province_code" => "72",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "709",
                "name" => "Thị xã Hòa Thành",
                "province_code" => "72",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "710",
                "name" => "Huyện Gò Dầu",
                "province_code" => "72",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "711",
                "name" => "Huyện Bến Cầu",
                "province_code" => "72",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "712",
                "name" => "Thị xã Trảng Bàng",
                "province_code" => "72",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "718",
                "name" => "Thành phố Thủ Dầu Một",
                "province_code" => "74",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "719",
                "name" => "Huyện Bàu Bàng",
                "province_code" => "74",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "720",
                "name" => "Huyện Dầu Tiếng",
                "province_code" => "74",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "721",
                "name" => "Thị xã Bến Cát",
                "province_code" => "74",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "722",
                "name" => "Huyện Phú Giáo",
                "province_code" => "74",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "723",
                "name" => "Thành phố Tân Uyên",
                "province_code" => "74",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "724",
                "name" => "Thành phố Dĩ An",
                "province_code" => "74",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "725",
                "name" => "Thành phố Thuận An",
                "province_code" => "74",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "726",
                "name" => "Huyện Bắc Tân Uyên",
                "province_code" => "74",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "731",
                "name" => "Thành phố Biên Hòa",
                "province_code" => "75",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "732",
                "name" => "Thành phố Long Khánh",
                "province_code" => "75",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "734",
                "name" => "Huyện Tân Phú",
                "province_code" => "75",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "735",
                "name" => "Huyện Vĩnh Cửu",
                "province_code" => "75",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "736",
                "name" => "Huyện Định Quán",
                "province_code" => "75",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "737",
                "name" => "Huyện Trảng Bom",
                "province_code" => "75",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "738",
                "name" => "Huyện Thống Nhất",
                "province_code" => "75",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "739",
                "name" => "Huyện Cẩm Mỹ",
                "province_code" => "75",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "740",
                "name" => "Huyện Long Thành",
                "province_code" => "75",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "741",
                "name" => "Huyện Xuân Lộc",
                "province_code" => "75",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "742",
                "name" => "Huyện Nhơn Trạch",
                "province_code" => "75",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "747",
                "name" => "Thành phố Vũng Tàu",
                "province_code" => "77",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "748",
                "name" => "Thành phố Bà Rịa",
                "province_code" => "77",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "750",
                "name" => "Huyện Châu Đức",
                "province_code" => "77",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "751",
                "name" => "Huyện Xuyên Mộc",
                "province_code" => "77",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "752",
                "name" => "Huyện Long Điền",
                "province_code" => "77",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "753",
                "name" => "Huyện Đất Đỏ",
                "province_code" => "77",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "754",
                "name" => "Thị xã Phú Mỹ",
                "province_code" => "77",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "755",
                "name" => "Huyện Côn Đảo",
                "province_code" => "77",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "760",
                "name" => "Quận 1",
                "province_code" => "79",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "761",
                "name" => "Quận 12",
                "province_code" => "79",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "764",
                "name" => "Quận Gò Vấp",
                "province_code" => "79",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "765",
                "name" => "Quận Bình Thạnh",
                "province_code" => "79",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "766",
                "name" => "Quận Tân Bình",
                "province_code" => "79",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "767",
                "name" => "Quận Tân Phú",
                "province_code" => "79",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "768",
                "name" => "Quận Phú Nhuận",
                "province_code" => "79",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "769",
                "name" => "Thành phố Thủ Đức",
                "province_code" => "79",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "770",
                "name" => "Quận 3",
                "province_code" => "79",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "771",
                "name" => "Quận 10",
                "province_code" => "79",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "772",
                "name" => "Quận 11",
                "province_code" => "79",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "773",
                "name" => "Quận 4",
                "province_code" => "79",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "774",
                "name" => "Quận 5",
                "province_code" => "79",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "775",
                "name" => "Quận 6",
                "province_code" => "79",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "776",
                "name" => "Quận 8",
                "province_code" => "79",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "777",
                "name" => "Quận Bình Tân",
                "province_code" => "79",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "778",
                "name" => "Quận 7",
                "province_code" => "79",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "783",
                "name" => "Huyện Củ Chi",
                "province_code" => "79",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "784",
                "name" => "Huyện Hóc Môn",
                "province_code" => "79",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "785",
                "name" => "Huyện Bình Chánh",
                "province_code" => "79",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "786",
                "name" => "Huyện Nhà Bè",
                "province_code" => "79",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "787",
                "name" => "Huyện Cần Giờ",
                "province_code" => "79",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "794",
                "name" => "Thành phố Tân An",
                "province_code" => "80",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "795",
                "name" => "Thị xã Kiến Tường",
                "province_code" => "80",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "796",
                "name" => "Huyện Tân Hưng",
                "province_code" => "80",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "797",
                "name" => "Huyện Vĩnh Hưng",
                "province_code" => "80",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "798",
                "name" => "Huyện Mộc Hóa",
                "province_code" => "80",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "799",
                "name" => "Huyện Tân Thạnh",
                "province_code" => "80",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "800",
                "name" => "Huyện Thạnh Hóa",
                "province_code" => "80",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "801",
                "name" => "Huyện Đức Huệ",
                "province_code" => "80",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "802",
                "name" => "Huyện Đức Hòa",
                "province_code" => "80",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "803",
                "name" => "Huyện Bến Lức",
                "province_code" => "80",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "804",
                "name" => "Huyện Thủ Thừa",
                "province_code" => "80",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "805",
                "name" => "Huyện Tân Trụ",
                "province_code" => "80",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "806",
                "name" => "Huyện Cần Đước",
                "province_code" => "80",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "807",
                "name" => "Huyện Cần Giuộc",
                "province_code" => "80",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "808",
                "name" => "Huyện Châu Thành",
                "province_code" => "80",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "815",
                "name" => "Thành phố Mỹ Tho",
                "province_code" => "82",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "816",
                "name" => "Thị xã Gò Công",
                "province_code" => "82",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "817",
                "name" => "Thị xã Cai Lậy",
                "province_code" => "82",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "818",
                "name" => "Huyện Tân Phước",
                "province_code" => "82",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "819",
                "name" => "Huyện Cái Bè",
                "province_code" => "82",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "820",
                "name" => "Huyện Cai Lậy",
                "province_code" => "82",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "821",
                "name" => "Huyện Châu Thành",
                "province_code" => "82",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "822",
                "name" => "Huyện Chợ Gạo",
                "province_code" => "82",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "823",
                "name" => "Huyện Gò Công Tây",
                "province_code" => "82",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "824",
                "name" => "Huyện Gò Công Đông",
                "province_code" => "82",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "825",
                "name" => "Huyện Tân Phú Đông",
                "province_code" => "82",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "829",
                "name" => "Thành phố Bến Tre",
                "province_code" => "83",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "831",
                "name" => "Huyện Châu Thành",
                "province_code" => "83",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "832",
                "name" => "Huyện Chợ Lách",
                "province_code" => "83",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "833",
                "name" => "Huyện Mỏ Cày Nam",
                "province_code" => "83",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "834",
                "name" => "Huyện Giồng Trôm",
                "province_code" => "83",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "835",
                "name" => "Huyện Bình Đại",
                "province_code" => "83",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "836",
                "name" => "Huyện Ba Tri",
                "province_code" => "83",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "837",
                "name" => "Huyện Thạnh Phú",
                "province_code" => "83",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "838",
                "name" => "Huyện Mỏ Cày Bắc",
                "province_code" => "83",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "842",
                "name" => "Thành phố Trà Vinh",
                "province_code" => "84",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "844",
                "name" => "Huyện Càng Long",
                "province_code" => "84",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "845",
                "name" => "Huyện Cầu Kè",
                "province_code" => "84",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "846",
                "name" => "Huyện Tiểu Cần",
                "province_code" => "84",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "847",
                "name" => "Huyện Châu Thành",
                "province_code" => "84",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "848",
                "name" => "Huyện Cầu Ngang",
                "province_code" => "84",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "849",
                "name" => "Huyện Trà Cú",
                "province_code" => "84",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "850",
                "name" => "Huyện Duyên Hải",
                "province_code" => "84",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "851",
                "name" => "Thị xã Duyên Hải",
                "province_code" => "84",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "855",
                "name" => "Thành phố Vĩnh Long",
                "province_code" => "86",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "857",
                "name" => "Huyện Long Hồ",
                "province_code" => "86",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "858",
                "name" => "Huyện Mang Thít",
                "province_code" => "86",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "859",
                "name" => "Huyện Vũng Liêm",
                "province_code" => "86",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "860",
                "name" => "Huyện Tam Bình",
                "province_code" => "86",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "861",
                "name" => "Thị xã Bình Minh",
                "province_code" => "86",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "862",
                "name" => "Huyện Trà Ôn",
                "province_code" => "86",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "863",
                "name" => "Huyện Bình Tân",
                "province_code" => "86",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "866",
                "name" => "Thành phố Cao Lãnh",
                "province_code" => "87",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "867",
                "name" => "Thành phố Sa Đéc",
                "province_code" => "87",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "868",
                "name" => "Thành phố Hồng Ngự",
                "province_code" => "87",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "869",
                "name" => "Huyện Tân Hồng",
                "province_code" => "87",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "870",
                "name" => "Huyện Hồng Ngự",
                "province_code" => "87",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "871",
                "name" => "Huyện Tam Nông",
                "province_code" => "87",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "872",
                "name" => "Huyện Tháp Mười",
                "province_code" => "87",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "873",
                "name" => "Huyện Cao Lãnh",
                "province_code" => "87",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "874",
                "name" => "Huyện Thanh Bình",
                "province_code" => "87",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "875",
                "name" => "Huyện Lấp Vò",
                "province_code" => "87",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "876",
                "name" => "Huyện Lai Vung",
                "province_code" => "87",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "877",
                "name" => "Huyện Châu Thành",
                "province_code" => "87",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "883",
                "name" => "Thành phố Long Xuyên",
                "province_code" => "89",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "884",
                "name" => "Thành phố Châu Đốc",
                "province_code" => "89",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "886",
                "name" => "Huyện An Phú",
                "province_code" => "89",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "887",
                "name" => "Thị xã Tân Châu",
                "province_code" => "89",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "888",
                "name" => "Huyện Phú Tân",
                "province_code" => "89",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "889",
                "name" => "Huyện Châu Phú",
                "province_code" => "89",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "890",
                "name" => "Thị xã Tịnh Biên",
                "province_code" => "89",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "891",
                "name" => "Huyện Tri Tôn",
                "province_code" => "89",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "892",
                "name" => "Huyện Châu Thành",
                "province_code" => "89",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "893",
                "name" => "Huyện Chợ Mới",
                "province_code" => "89",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "894",
                "name" => "Huyện Thoại Sơn",
                "province_code" => "89",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "899",
                "name" => "Thành phố Rạch Giá",
                "province_code" => "91",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "900",
                "name" => "Thành phố Hà Tiên",
                "province_code" => "91",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "902",
                "name" => "Huyện Kiên Lương",
                "province_code" => "91",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "903",
                "name" => "Huyện Hòn Đất",
                "province_code" => "91",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "904",
                "name" => "Huyện Tân Hiệp",
                "province_code" => "91",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "905",
                "name" => "Huyện Châu Thành",
                "province_code" => "91",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "906",
                "name" => "Huyện Giồng Riềng",
                "province_code" => "91",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "907",
                "name" => "Huyện Gò Quao",
                "province_code" => "91",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "908",
                "name" => "Huyện An Biên",
                "province_code" => "91",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "909",
                "name" => "Huyện An Minh",
                "province_code" => "91",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "910",
                "name" => "Huyện Vĩnh Thuận",
                "province_code" => "91",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "911",
                "name" => "Thành phố Phú Quốc",
                "province_code" => "91",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "912",
                "name" => "Huyện Kiên Hải",
                "province_code" => "91",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "913",
                "name" => "Huyện U Minh Thượng",
                "province_code" => "91",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "914",
                "name" => "Huyện Giang Thành",
                "province_code" => "91",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "916",
                "name" => "Quận Ninh Kiều",
                "province_code" => "92",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "917",
                "name" => "Quận Ô Môn",
                "province_code" => "92",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "918",
                "name" => "Quận Bình Thuỷ",
                "province_code" => "92",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "919",
                "name" => "Quận Cái Răng",
                "province_code" => "92",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "923",
                "name" => "Quận Thốt Nốt",
                "province_code" => "92",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "924",
                "name" => "Huyện Vĩnh Thạnh",
                "province_code" => "92",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "925",
                "name" => "Huyện Cờ Đỏ",
                "province_code" => "92",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "926",
                "name" => "Huyện Phong Điền",
                "province_code" => "92",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "927",
                "name" => "Huyện Thới Lai",
                "province_code" => "92",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "930",
                "name" => "Thành phố Vị Thanh",
                "province_code" => "93",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "931",
                "name" => "Thành phố Ngã Bảy",
                "province_code" => "93",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "932",
                "name" => "Huyện Châu Thành A",
                "province_code" => "93",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "933",
                "name" => "Huyện Châu Thành",
                "province_code" => "93",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "934",
                "name" => "Huyện Phụng Hiệp",
                "province_code" => "93",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "935",
                "name" => "Huyện Vị Thuỷ",
                "province_code" => "93",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "936",
                "name" => "Huyện Long Mỹ",
                "province_code" => "93",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "937",
                "name" => "Thị xã Long Mỹ",
                "province_code" => "93",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "941",
                "name" => "Thành phố Sóc Trăng",
                "province_code" => "94",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "942",
                "name" => "Huyện Châu Thành",
                "province_code" => "94",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "943",
                "name" => "Huyện Kế Sách",
                "province_code" => "94",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "944",
                "name" => "Huyện Mỹ Tú",
                "province_code" => "94",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "945",
                "name" => "Huyện Cù Lao Dung",
                "province_code" => "94",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "946",
                "name" => "Huyện Long Phú",
                "province_code" => "94",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "947",
                "name" => "Huyện Mỹ Xuyên",
                "province_code" => "94",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "948",
                "name" => "Thị xã Ngã Năm",
                "province_code" => "94",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "949",
                "name" => "Huyện Thạnh Trị",
                "province_code" => "94",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "950",
                "name" => "Thị xã Vĩnh Châu",
                "province_code" => "94",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "951",
                "name" => "Huyện Trần Đề",
                "province_code" => "94",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "954",
                "name" => "Thành phố Bạc Liêu",
                "province_code" => "95",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "956",
                "name" => "Huyện Hồng Dân",
                "province_code" => "95",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "957",
                "name" => "Huyện Phước Long",
                "province_code" => "95",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "958",
                "name" => "Huyện Vĩnh Lợi",
                "province_code" => "95",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "959",
                "name" => "Thị xã Giá Rai",
                "province_code" => "95",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "960",
                "name" => "Huyện Đông Hải",
                "province_code" => "95",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "961",
                "name" => "Huyện Hoà Bình",
                "province_code" => "95",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "964",
                "name" => "Thành phố Cà Mau",
                "province_code" => "96",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "966",
                "name" => "Huyện U Minh",
                "province_code" => "96",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "967",
                "name" => "Huyện Thới Bình",
                "province_code" => "96",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "968",
                "name" => "Huyện Trần Văn Thời",
                "province_code" => "96",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "969",
                "name" => "Huyện Cái Nước",
                "province_code" => "96",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "970",
                "name" => "Huyện Đầm Dơi",
                "province_code" => "96",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "971",
                "name" => "Huyện Năm Căn",
                "province_code" => "96",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "972",
                "name" => "Huyện Phú Tân",
                "province_code" => "96",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ],
            [
                "code" => "973",
                "name" => "Huyện Ngọc Hiển",
                "province_code" => "96",
                'created_at' => $currentTimestamp, 
                'updated_at' => $currentTimestamp
            ]
        ];
        
        District::insert($districts);
    }
}
