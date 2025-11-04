import 'package:flutter/material.dart';

// App Colors
class AppColors {
  static const primary = Color(0xFF3B82F6);
  static const accent = Color(0xFF6366F1);
  static const background = Color(0xFFF8FAFC);
  static const cardBackground = Colors.white;
  static const textPrimary = Color(0xFF1E293B);
  static const textSecondary = Color(0xFF64748B);
  static const error = Color(0xFFEF4444);
  static const success = Color(0xFF10B981);
}

// Post Categories
class PostCategory {
  static const notes = 'Notes';
  static const jobs = 'Jobs';
  static const events = 'Events';
  static const lostFound = 'Lost & Found';
  static const announcements = 'Announcements';

  static const List<String> all = [
    notes,
    jobs,
    events,
    lostFound,
    announcements,
  ];

  static IconData getIcon(String category) {
    switch (category) {
      case notes:
        return Icons.book;
      case jobs:
        return Icons.work;
      case events:
        return Icons.event;
      case lostFound:
        return Icons.search;
      case announcements:
        return Icons.campaign;
      default:
        return Icons.article;
    }
  }

  static Color getColor(String category) {
    switch (category) {
      case notes:
        return const Color(0xFF3B82F6);
      case jobs:
        return const Color(0xFF10B981);
      case events:
        return const Color(0xFFF59E0B);
      case lostFound:
        return const Color(0xFFEF4444);
      case announcements:
        return const Color(0xFF6366F1);
      default:
        return AppColors.primary;
    }
  }
}

// Text Styles
class AppTextStyles {
  static const heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const heading2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const heading3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const body1 = TextStyle(fontSize: 16, color: AppColors.textPrimary);

  static const body2 = TextStyle(fontSize: 14, color: AppColors.textSecondary);

  static const caption = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );
}

// Spacing
class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
}
