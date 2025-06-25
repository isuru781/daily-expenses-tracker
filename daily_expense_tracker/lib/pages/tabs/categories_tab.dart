import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../models/expense.dart';
import '../../utils/category_utils.dart';

class CategoriesTab extends StatelessWidget {
  final List<Expense> expenses;

  const CategoriesTab({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Food', 'Transportation', 'Entertainment', 
      'Shopping', 'Health', 'Utilities', 'Other'
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Expense Categories',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.charcoal,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Manage and view your expense categories',
            style: TextStyle(
              color: AppColors.softGray,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 24),
          
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final categoryExpenses = expenses.where((e) => e.category == category).length;
              final categoryTotal = expenses
                  .where((e) => e.category == category)
                  .fold(0.0, (sum, e) => sum + e.amount);
              
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [                    BoxShadow(
                      color: AppColors.charcoal.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: CategoryUtils.getCategoryColor(category).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Icon(
                        CategoryUtils.getCategoryIcon(category),
                        color: CategoryUtils.getCategoryColor(category),
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Flexible(
                      child: Text(
                        category,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.charcoal,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$categoryExpenses items',
                      style: const TextStyle(
                        color: AppColors.softGray,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '\$${categoryTotal.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: AppColors.charcoal,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
