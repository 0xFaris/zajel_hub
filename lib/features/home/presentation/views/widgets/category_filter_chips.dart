import 'package:flutter/material.dart';
import 'package:zajel_hub/core/utils/app_colors.dart';
import 'package:zajel_hub/core/utils/app_text_styles.dart';

class CategoryFilterChips extends StatelessWidget {
  const CategoryFilterChips({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final String? selectedCategory;
  final ValueChanged<String?> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'id': null, 'nameAr': 'الكل', 'icon': Icons.apps},
      {'id': 'food', 'nameAr': 'طعام', 'icon': Icons.restaurant},
      {'id': 'pharmacy', 'nameAr': 'صيدلية', 'icon': Icons.medical_services},
      {'id': 'grocery', 'nameAr': 'بقالة', 'icon': Icons.shopping_basket},
    ];

    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 2),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category['id'];
          final color = _getCategoryColor(category['id'] as String?);

          return GestureDetector(
            onTap: () => onCategorySelected(category['id'] as String?),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? color : Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: isSelected ? color : Colors.grey[300]!,
                  width: 2,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    category['icon'] as IconData,
                    size: 20,
                    color: isSelected ? Colors.white : color,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    category['nameAr'] as String,
                    style: TextStyles.semiBold13.copyWith(
                      color: isSelected ? Colors.white : color,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getCategoryColor(String? categoryId) {
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
