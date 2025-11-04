import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/constants.dart';
import '../providers/post_provider.dart';

class CategoryChip extends ConsumerWidget {
  final String category;

  const CategoryChip({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final isSelected = selectedCategory == category;

    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              PostCategory.getIcon(category),
              size: 16,
              color: isSelected
                  ? Colors.white
                  : PostCategory.getColor(category),
            ),
            const SizedBox(width: 4),
            Flexible(child: Text(category, overflow: TextOverflow.ellipsis)),
          ],
        ),
        selected: isSelected,
        onSelected: (selected) {
          ref.read(selectedCategoryProvider.notifier).state = selected
              ? category
              : null;
        },
        selectedColor: PostCategory.getColor(category),
        backgroundColor: PostCategory.getColor(category).withOpacity(0.1),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : PostCategory.getColor(category),
          fontWeight: FontWeight.w600,
        ),
        showCheckmark: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide.none,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
