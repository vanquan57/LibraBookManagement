import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            _buildBreadcrumb(context),
            _buildOurStorySection(context),
            _buildGeneralSection(context),
            _buildServiceSection(context),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  /// Build the breadcrumb
  ///
  /// @param context - The build context
  ///
  /// @return The breadcrumb widget
  Widget _buildBreadcrumb(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Trang chủ',
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text('/', style: TextStyle(color: Colors.black54)),
          ),
          const Text(
            'Về chúng tôi',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  /// Build the our story section
  ///
  /// @param context - The build context
  ///
  /// @return The our story section widget
  Widget _buildOurStorySection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          _buildOurStoryText(context),
          SizedBox(height: 20.h),
          _buildOurStoryImage(),
        ],
      ),
    );
  }

  /// Build the our story text content
  ///
  /// @param context - The build context
  ///
  /// @return The our story text widget
  Widget _buildOurStoryText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Câu chuyện của chúng tôi',
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20.h),
        Text(
          'Với phương châm lấy người học làm trung tâm, VKU theo đuổi triết lý giáo dục "Nhân bản - Phụng sự - Khai phóng" nhằm đào tạo và phát triển người học trở thành những con người toàn diện, thiện lương, đạo đức với tư duy năng động, đổi mới, sáng tạo cùng tinh thần luôn sẵn sàng phụng sự, dấn thân vì hạnh phúc và sự phát triển của đất nước, nhân loại dựa trên hệ thống giá trị cốt lõi: Đức - Trí - Thể - Mỹ; Uy tín - Chất lượng - Chuyên nghiệp; Kế thừa - Đổi mới - Sáng tạo.',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.black87,
            height: 1.6,
          ),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 20.h),
        Text(
          'VKU đã đạt được những thành tựu nghiên cứu ấn tượng, tạo môi trường nghiên cứu tốt và thu hút giảng viên, sinh viên tài năng. Những công trình nghiên cứu của trường có tầm ảnh hưởng rộng lớn trong cộng đồng khoa học, mang lại niềm vui, động lực cho các nhà nghiên cứu và đóng góp quan trọng vào sự phát triển của ngành khoa học.',
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.black87,
            height: 1.6,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  /// Build the our story image
  ///
  /// @return The our story image widget
  Widget _buildOurStoryImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        'assets/images/sideImageAbout.png',
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  /// Build the general statistics section
  ///
  /// @param context - The build context
  ///
  /// @return The general section widget
  Widget _buildGeneralSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      margin: EdgeInsets.only(top: 40.h, bottom: 30.h),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 30.h,
        crossAxisSpacing: 30.w,
        childAspectRatio: 0.9,
        children: [
          _buildStatCard(
            icon: Icons.account_circle_outlined,
            value: '12.5k',
            content: 'Số lượng người dùng\nđăng ký',
          ),
          _buildStatCard(
            icon: Icons.attach_money_outlined,
            value: '13.5k',
            content: 'Số lượng đơn hàng\nđược đặt',
          ),
          _buildStatCard(
            icon: Icons.store_outlined,
            value: '14.5k',
            content: 'Số lượng sách trong\nthư viện',
          ),
          _buildStatCard(
            icon: Icons.shopping_bag_outlined,
            value: '15.5k',
            content: 'Số lượng sách yêu\nthích',
          ),
        ],
      ),
    );
  }

  /// Build individual stat card
  ///
  /// @param icon - The icon to display
  /// @param value - The stat value
  /// @param content - The stat description
  ///
  /// @return The stat card widget
  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String content,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: EdgeInsets.all(12.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade300,
              ),
              child: Container(
                margin: EdgeInsets.all(6.w),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFDB4444),
                ),
                child: Icon(icon, color: Colors.white, size: 24.sp),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6.h),
          Flexible(
            child: Text(
              content,
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  /// Build the service section
  ///
  /// @param context - The build context
  ///
  /// @return The service section widget
  Widget _buildServiceSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      margin: EdgeInsets.only(bottom: 20.h, top: 20.h),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildServiceItem(
                  icon: Icons.menu_book_outlined,
                  title: 'SÁCH',
                  subtitle: 'Số lượng sách có sẵn',
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: _buildServiceItem(
                  icon: Icons.access_time_outlined,
                  title: 'THỜI GIAN',
                  subtitle: 'Thứ 2 - Thứ 7, 9 AM - 6 PM',
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: _buildServiceItem(
                icon: Icons.verified_outlined,
                title: 'SÁCH MỚI',
                subtitle: 'Sách mới cập nhật',
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build individual service item
  ///
  /// @param icon - The icon to display
  /// @param title - The title of the service
  /// @param subtitle - The subtitle of the service
  ///
  /// @return The service item widget
  Widget _buildServiceItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade300,
            ),
            child: Container(
              margin: EdgeInsets.all(6.w),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFDB4444),
              ),
              child: Icon(icon, color: Colors.white, size: 28.sp),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 6.h),
        Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              subtitle,
              style: TextStyle(fontSize: 11.sp, color: Colors.black87),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
