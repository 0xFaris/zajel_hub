import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zajel_hub/core/entities/product_entity.dart';
import 'package:zajel_hub/core/utils/app_colors.dart';
import 'package:zajel_hub/core/utils/app_text_styles.dart';
import 'package:zajel_hub/core/widgets/custom_network_image.dart';
import 'package:zajel_hub/features/home/presentation/cubits/cart_cubit/cart_cubit.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.product});

  static const routeName = 'product_details';
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 350,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_forward, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.favorite_border, color: Colors.black),
                  onPressed: () {},
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: const Color(0xFFF8F9FA),
                child: product.imageUrl != null
                    ? CustomNetworkImage(imageUrl: product.imageUrl!)
                    : Center(
                        child: Icon(
                          Icons.shopping_bag_outlined,
                          size: 120,
                          color: Colors.grey[300],
                        ),
                      ),
              ),
            ),
          ),
          // Content
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Badge and Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        // Rating
                        if (product.reviews.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  product.avgRating.toStringAsFixed(1),
                                  style: TextStyles.bold13.copyWith(
                                    color: Colors.amber[800],
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        // Category
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(product.categoryId),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _getCategoryName(product.categoryId),
                            style: TextStyles.semiBold13.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Product Name
                    Text(
                      product.name,
                      style: TextStyles.bold19.copyWith(fontSize: 24),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 8),
                    // Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'للكيلو',
                          style: TextStyles.regular13.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${product.price} جنيه',
                          style: TextStyles.bold19.copyWith(
                            fontSize: 28,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 24),
                    // Description
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'الوصف',
                        style: TextStyles.bold16.copyWith(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      product.description,
                      style: TextStyles.regular13.copyWith(
                        color: Colors.grey[700],
                        height: 1.8,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 32),
                    // Info Cards
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Expanded(
                          child: _buildInfoCard(
                            Icons.local_fire_department,
                            '${product.numberOfCalories}',
                            'سعرة',
                            Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildInfoCard(
                            Icons.scale,
                            '${product.unitAmount}',
                            'كجم',
                            Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Expanded(
                          child: _buildInfoCard(
                            Icons.calendar_today,
                            '${product.expirationsMonths}',
                            'شهر',
                            Colors.purple,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildInfoCard(
                            product.isOrganic ? Icons.eco : Icons.science,
                            product.isOrganic ? 'عضوي' : 'عادي',
                            '',
                            Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Reviews
                    if (product.reviews.isNotEmpty) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'عرض الكل',
                              style: TextStyles.semiBold13.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          Text(
                            'التقييمات (${product.reviews.length})',
                            style: TextStyles.bold16.copyWith(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ...product.reviews
                          .take(3)
                          .map(
                            (review) => Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F9FA),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        review.date,
                                        style: TextStyles.regular11.copyWith(
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            review.name,
                                            style: TextStyles.bold13,
                                          ),
                                          const SizedBox(width: 8),
                                          Row(
                                            children: List.generate(
                                              5,
                                              (index) => Icon(
                                                index < review.ratting
                                                    ? Icons.star
                                                    : Icons.star_border,
                                                size: 16,
                                                color: Colors.amber,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    review.reviewDescription,
                                    textAlign: TextAlign.right,
                                    style: TextStyles.regular13.copyWith(
                                      color: Colors.grey[700],
                                      height: 1.6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      const SizedBox(height: 100),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -10),
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: () {
              context.read<CartCubit>().addProduct(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'تمت إضافة ${product.name} إلى السلة',
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                  duration: const Duration(seconds: 2),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'أضف إلى السلة',
                  style: TextStyles.bold16.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.shopping_cart_outlined, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(value, style: TextStyles.bold16.copyWith(color: color)),
          if (label.isNotEmpty)
            Text(label, style: TextStyles.regular11.copyWith(color: color)),
        ],
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
