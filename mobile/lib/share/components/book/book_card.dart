import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/router/app_router.dart';

class BookCard extends StatelessWidget {
  final int bookId;
  final String image;
  final String name;
  final String authorName;
  final int averageStar;
  final int feedbacksCount;
  final bool isWishlist;
  final bool isInWishlist;
  final bool isWishlistMode;
  final String baseImageUrl;
  final VoidCallback? onQuickView;
  final VoidCallback? onAddToCart;
  final VoidCallback? onAddToWishlist;
  final VoidCallback? onRemoveFromWishlist;
  final VoidCallback? onDelete;

  const BookCard({
    super.key,
    required this.bookId,
    required this.image,
    required this.name,
    required this.authorName,
    required this.averageStar,
    required this.feedbacksCount,
    required this.baseImageUrl,
    this.isWishlist = false,
    this.isInWishlist = false,
    this.isWishlistMode = false,
    this.onQuickView,
    this.onAddToCart,
    this.onAddToWishlist,
    this.onRemoveFromWishlist,
    this.onDelete,
  });

  String _getImageUrl() {
    return baseImageUrl + image;
  }

  void _handleToggleWishlist() {
    if (isInWishlist) {
      onRemoveFromWishlist?.call();
    } else {
      onAddToWishlist?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
              Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    context.push('${AppRouter.bookDetails}/$bookId');
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.network(
                      _getImageUrl(),
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.book,
                            size: 64,
                            color: Colors.grey,
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[200],
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                if (isWishlistMode)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: _ActionButton(
                      icon: Icons.delete_outline,
                      iconColor: Colors.red,
                      onPressed: onDelete,
                    ),
                  )
                else
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Column(
                      children: [
                        _ActionButton(
                          icon: isInWishlist
                              ? Icons.favorite
                              : Icons.favorite_border,
                          iconColor: isInWishlist ? Colors.red : Colors.black87,
                          onPressed: _handleToggleWishlist,
                        ),
                        const SizedBox(height: 8),
                        _ActionButton(
                          icon: Icons.remove_red_eye_outlined,
                          iconColor: Colors.black87,
                          onPressed: onQuickView,
                        ),
                      ],
                    ),
                  ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: InkWell(
                    onTap: onAddToCart,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF7043),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          const Flexible(
                            child: Text(
                              'Thêm vào giỏ mượn',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    authorName,
                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        return Icon(
                          index < averageStar.floor()
                              ? Icons.star
                              : Icons.star_border,
                          color: index < averageStar.floor()
                              ? const Color(0xFFFFA726)
                              : Colors.grey[400],
                          size: 16,
                        );
                      }),
                      const SizedBox(width: 6),
                      Text(
                        '($feedbacksCount)',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper widget for action buttons
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onPressed;

  const _ActionButton({
    required this.icon,
    required this.iconColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: iconColor),
        onPressed: onPressed,
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(),
        iconSize: 20,
      ),
    );
  }
}
