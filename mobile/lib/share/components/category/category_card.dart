import 'dart:math';

import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final int categoryId;
  final String name;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.categoryId,
    required this.name,
    this.onTap,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  late final String selectedImage;

  @override
  void initState() {
    super.initState();
    final List<String> listImagesCategory = [
      'assets/images/categoryCamera.png',
      'assets/images/categoryCellPhone.png',
      'assets/images/categoryComputer.png',
      'assets/images/categoryGamepad.png',
      'assets/images/categoryHeadphone.png',
      'assets/images/categorySmartWatch.png',
    ];
    
    selectedImage = listImagesCategory[Random().nextInt(listImagesCategory.length)];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              child: Image.asset(
                selectedImage,
                height: 64,
                width: 64,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 64,
                    width: 64,
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.photo_camera_outlined,
                      size: 48,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
