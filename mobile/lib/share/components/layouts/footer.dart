import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container( 
        width: double.infinity,
        color: const Color(0xFFFF7655),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 40,
          vertical: 40,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            if (isMobile)
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'VKU - Libra',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Đăng Ký Nhận Thông Tin',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Nhận ngay giảm giá 10% cho đơn hàng đầu tiên',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.white, width: 1.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: const [
                            Expanded(
                              child: TextField(
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Nhập email của bạn',
                                  hintStyle: TextStyle(color: Colors.white70),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 12),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 15),
                              child: Icon(Icons.send,
                                  color: Colors.white, size: 22),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                    const SizedBox(height: 30),
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        'Hỗ Trợ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '470 Trần Đại Nghĩa, Q. Ngũ Hành Sơn, Tp. Đà Nẵng',
                        style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'info@vku.udn.vn',
                        style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      Text(
                        '0236.3.667.117',
                        style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                    const SizedBox(height: 30),
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        'Tài Khoản',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('Tài Khoản Của Tôi',
                          style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5)),
                      SizedBox(height: 12),
                      Text('Đăng Nhập / Đăng Ký',
                          style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5)),
                      SizedBox(height: 12),
                      Text('Giỏ Hàng',
                          style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5)),
                      SizedBox(height: 12),
                      Text('Danh Sách Yêu Thích',
                          style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5)),
                      SizedBox(height: 12),
                      Text('Cửa Hàng',
                          style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5)),
                    ],
                  ),
                ],
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'VKU - Libra',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Đăng Ký Nhận Thông Tin',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Nhận ngay giảm giá 10% cho đơn hàng đầu tiên',
                          style:
                              TextStyle(color: Colors.white, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.white, width: 1.5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: const [
                              Expanded(
                                child: TextField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: 'Nhập email của bạn',
                                    hintStyle:
                                        TextStyle(color: Colors.white70),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 12),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Icon(Icons.send,
                                    color: Colors.white, size: 22),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Hỗ Trợ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          '470 Trần Đại Nghĩa, Q. Ngũ Hành Sơn, Tp. Đà Nẵng',
                          style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'info@vku.udn.vn',
                          style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12),
                        Text(
                          '0236.3.667.117',
                          style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Tài Khoản',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text('Tài Khoản Của Tôi',
                            style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5)),
                        SizedBox(height: 12),
                        Text('Đăng Nhập / Đăng Ký',
                            style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5)),
                        SizedBox(height: 12),
                        Text('Giỏ Hàng',
                            style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5)),
                        SizedBox(height: 12),
                        Text('Danh Sách Yêu Thích',
                            style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5)),
                        SizedBox(height: 12),
                        Text('Cửa Hàng',
                            style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            Column(
              children: [
                const Text(
                  'Tải Ứng Dụng',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Tiết kiệm 3 USD dành riêng cho người dùng mới tải ứng dụng',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        'assets/images/qrCode.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/appStore.png',
                          width: 135,
                          height: 40,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 10),
                        Image.asset(
                          'assets/images/googlePlay.png',
                          width: 135,
                          height: 40,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
              const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _circleIcon(Icons.facebook),
                const SizedBox(width: 20),
                _circleIcon(Icons.message),
                const SizedBox(width: 20),
                _circleIcon(Icons.camera_alt),
                const SizedBox(width: 20),
                _circleIcon(Icons.business_center),
              ],
            ),
              const SizedBox(height: 30),
            Column(
              children: [
                Container(
                  height: 1,
                  color: Colors.white.withOpacity(0.3),
                  margin: const EdgeInsets.only(bottom: 20),
                ),
                const Text(
                  '© BẢN QUYỀN © 2025 VKU CO., LTD. MỌI QUYỀN ĐƯỢC BẢO LƯU',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        ),
    );
  }

  Widget _circleIcon(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: Center(
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
