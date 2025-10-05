import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zajel_hub/core/entities/product_entity.dart';
import 'package:zajel_hub/core/utils/app_colors.dart';
import 'package:zajel_hub/core/utils/app_text_styles.dart';
import 'package:zajel_hub/core/widgets/custom_network_image.dart';
import 'package:zajel_hub/features/home/presentation/cubits/cart_cubit/cart_cubit.dart';

class FruitItem extends StatelessWidget {
  const FruitItem({super.key, required this.productEntity});

  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          'product_details',
          arguments: productEntity,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Section
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  // Product Image
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: productEntity.imageUrl != null
                          ? ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: CustomNetworkImage(
                                imageUrl: productEntity.imageUrl!,
                              ),
                            )
                          : Icon(
                              Icons.shopping_bag_outlined,
                              size: 60,
                              color: Colors.grey[300],
                            ),
                    ),
                  ),
                  // Category Badge
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(productEntity.categoryId),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: _getCategoryColor(productEntity.categoryId)
                                .withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        _getCategoryName(productEntity.categoryId),
                        style: TextStyles.semiBold11.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // Favorite Button
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.favorite_border, size: 20),
                        color: Colors.grey[700],
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 36,
                          minHeight: 36,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content Section
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Product Name
                    Text(
                      productEntity.name,
                      style: TextStyles.semiBold13,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Rating and Reviews
                    if (productEntity.reviews.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '(${productEntity.reviews.length})',
                            style: TextStyles.regular11.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: 4),
                          ...List.generate(
                            5,
                            (index) => Icon(
                              index < productEntity.avgRating
                                  ? Icons.star
                                  : Icons.star_border,
                              size: 12,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 4),
                    // Price and Add Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Add Button
                        GestureDetector(
                          onTap: () {
                            context.read<CartCubit>().addProduct(productEntity);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'تمت الإضافة إلى السلة',
                                  textAlign: TextAlign.right,
                                ),
                                duration: const Duration(milliseconds: 800),
                                backgroundColor: AppColors.primaryColor,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryColor.withOpacity(0.3),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.add_shopping_cart,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        // Price
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${productEntity.price} جنيه',
                              style: TextStyles.bold13.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                            Text(
                              'للكيلو',
                              style: TextStyles.regular11.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCategoryName(String categoryId) {
    switch (categoryId) {
      case 'food':
        return 'طعام';
      case 'pharmacy':
        return 'صيدلية';
      case 'grocery':
        return 'بقالة';
      default:
        return 'طعام';
    }
  }

  Color _getCategoryColor(String categoryId) {
    switch (categoryId) {
      case 'food':
        return const Color(0xFF4CAF50);
      case 'pharmacy':
        return const Color(0xFF2196F3);
      case 'grocery':
        return const Color(0xFFFF9800);
      default:
        return AppColors.primaryColor;
    }
  }
}
