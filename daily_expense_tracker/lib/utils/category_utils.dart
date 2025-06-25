import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CategoryUtils {
  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return AppColors.warmCoral;
      case 'transportation':
        return AppColors.skyBlue;
      case 'entertainment':
        return AppColors.mintGreen;
      case 'shopping':
        return Colors.purple;
      case 'health':
        return Colors.green;
      case 'utilities':
        return Colors.orange;
      default:
        return AppColors.softGray;
    }
  }

  static IconData getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Icons.restaurant;
      case 'transportation':
        return Icons.directions_car;
      case 'entertainment':
        return Icons.movie;
      case 'shopping':
        return Icons.shopping_bag;
      case 'health':
        return Icons.local_hospital;
      case 'utilities':
        return Icons.bolt;
      default:
        return Icons.category;
    }
  }
}
