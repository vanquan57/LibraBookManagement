import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Pagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  const Pagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (totalPages <= 1) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Previous button
          _buildNavigationButton(
            icon: Icons.chevron_left,
            onPressed: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
          ),
          SizedBox(width: 8.w),

          // Page numbers
          ..._buildPageNumbers(),

          SizedBox(width: 8.w),
          
          // Next button
          _buildNavigationButton(
            icon: Icons.chevron_right,
            onPressed: currentPage < totalPages ? () => onPageChanged(currentPage + 1) : null,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: onPressed != null ? const Color(0xFFFF6E38) : Colors.grey[300],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          icon,
          color: onPressed != null ? Colors.white : Colors.grey[500],
          size: 20.sp,
        ),
      ),
    );
  }

  List<Widget> _buildPageNumbers() {
    List<Widget> pages = [];
    
    // Calculate range of pages to show
    int start = (currentPage - 2).clamp(1, totalPages);
    int end = (currentPage + 2).clamp(1, totalPages);
    
    // Adjust range if near boundaries
    if (currentPage <= 3) {
      end = 5.clamp(1, totalPages);
    }
    if (currentPage >= totalPages - 2) {
      start = (totalPages - 4).clamp(1, totalPages);
    }

    // Show first page if not in range
    if (start > 1) {
      pages.add(_buildPageButton(1));
      if (start > 2) {
        pages.add(_buildEllipsis());
      }
    }

    // Show page numbers in range
    for (int i = start; i <= end; i++) {
      pages.add(_buildPageButton(i));
    }

    // Show last page if not in range
    if (end < totalPages) {
      if (end < totalPages - 1) {
        pages.add(_buildEllipsis());
      }
      pages.add(_buildPageButton(totalPages));
    }

    // Add spacing between buttons
    return pages
        .expand((widget) => [widget, SizedBox(width: 8.w)])
        .toList()
      ..removeLast();
  }

  Widget _buildPageButton(int page) {
    final isActive = page == currentPage;
    
    return InkWell(
      onTap: () => onPageChanged(page),
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFFF6E38) : Colors.white,
          border: Border.all(
            color: isActive ? const Color(0xFFFF6E38) : Colors.grey[300]!,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          '$page',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildEllipsis() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Text(
        '...',
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}

