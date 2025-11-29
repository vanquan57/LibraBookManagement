import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/share/data/models/feedback/feedback.dart' as model;
import 'package:intl/intl.dart';

class FeedbackItem extends StatelessWidget {
  final model.Feedback feedback;

  const FeedbackItem({super.key, required this.feedback});

  /// Format date to Vietnamese locale
  ///
  /// @param {String} dateString
  ///
  /// @return {String}
  String _formatDate(String dateString) {
    try {
      final d = DateTime.parse(dateString).toLocal();
      final time = DateFormat('HH:mm').format(d);
      final day = d.day;
      final month = d.month;
      final year = d.year;

      return 'lúc $time ngày $day tháng $month, $year';
    } catch (_) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        border: Border.all(color: const Color(0xFFDDDDDD)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info
          Row(
            children: [
              // Avatar
              ClipRRect(
                borderRadius: BorderRadius.circular(25.r),
                child: Image.network(
                  feedback.user.avatar ??
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgsaRe2zqH_BBicvUorUseeTaE4kxPL2FmOQ&s',
                  width: 50.w,
                  height: 50.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        size: 30.sp,
                        color: Colors.grey[600],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 16.w),
              // User name
              Expanded(
                child: Text(
                  feedback.user.name,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF333333),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Rating stars
          Row(
            children: List.generate(5, (index) {
              return Icon(
                Icons.star,
                size: 20.sp,
                color: index < (feedback.pivot?.star ?? 0)
                    ? const Color(0xFFFFCC00)
                    : const Color(0x3E000000),
              );
            }),
          ),
          SizedBox(height: 16.h),

          // Feedback content
          Text(
            feedback.pivot?.content ?? '',
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF555555),
              height: 1.5,
            ),
          ),
          SizedBox(height: 8.h),

          // Date
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              _formatDate(feedback.pivot?.createdAt ?? ''),
              style: TextStyle(fontSize: 12.sp, color: const Color(0xFF888888)),
            ),
          ),
        ],
      ),
    );
  }
}
