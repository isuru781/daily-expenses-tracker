import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../models/expense.dart';
import '../../widgets/expense_card.dart';

class ExpensesTab extends StatelessWidget {
  final List<Expense> expenses;
  final Function(Expense) onExpenseAdded;
  final Function(String) onExpenseDeleted;

  const ExpensesTab({
    super.key,
    required this.expenses,
    required this.onExpenseAdded,
    required this.onExpenseDeleted,
  });

  double get totalExpenses {
    return expenses.fold(0.0, (sum, expense) => sum + expense.amount);
  }

  double get todayExpenses {
    final today = DateTime.now();
    return expenses
        .where((expense) =>
            expense.date.year == today.year &&
            expense.date.month == today.month &&
            expense.date.day == today.day)
        .fold(0.0, (sum, expense) => sum + expense.amount);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Summary Cards
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    'Today',
                    '\$${todayExpenses.toStringAsFixed(2)}',
                    AppColors.skyBlue,
                    Icons.today,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSummaryCard(
                    'Total',
                    '\$${totalExpenses.toStringAsFixed(2)}',
                    AppColors.mintGreen,
                    Icons.account_balance_wallet,
                  ),
                ),
              ],
            ),
          ),
          
          // Expenses List Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Expenses',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.charcoal,
                  ),
                ),
                Text(
                  '${expenses.length} items',
                  style: const TextStyle(
                    color: AppColors.softGray,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Expenses List
          expenses.isEmpty
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long,
                          size: 64,
                          color: AppColors.lightGray,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No expenses yet',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.softGray,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Tap the + button to add your first expense',
                          style: TextStyle(
                            color: AppColors.lightGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    final expense = expenses[index];
                    return ExpenseCard(
                      expense: expense,
                      onDelete: () => onExpenseDeleted(expense.id),
                    );
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String amount, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.charcoal.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.softGray,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              amount,
              style: const TextStyle(
                color: AppColors.charcoal,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
