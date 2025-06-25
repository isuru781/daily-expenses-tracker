import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/colors.dart';
import '../models/expense.dart';
import '../widgets/add_expense_dialog_lightweight.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  late List<Expense> expenses;
  
  // Cache for tab widgets to avoid recreating them
  final Map<int, Widget> _tabCache = {};

  @override
  void initState() {
    super.initState();
    // Initialize with minimal sample data
    expenses = [
      Expense(
        id: '1',
        title: 'Groceries',
        amount: 45.50,
        category: 'Food',
        date: DateTime.now().subtract(const Duration(days: 1)),
        description: 'Weekly grocery shopping',
      ),
    ];
  }

  void _onNavigationTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _addExpense(Expense expense) {
    setState(() {
      expenses.insert(0, expense);
      // Clear analytics and categories cache when expenses change
      _tabCache.remove(1);
      _tabCache.remove(2);
    });
  }

  void _deleteExpense(String id) {
    setState(() {
      expenses.removeWhere((expense) => expense.id == id);
      // Clear analytics and categories cache when expenses change
      _tabCache.remove(1);
      _tabCache.remove(2);
    });
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Logout',
            style: TextStyle(
              color: AppColors.charcoal,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(color: AppColors.softGray),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.softGray),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.go('/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.warmCoral,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  // Lazy load tabs to improve performance
  Widget _buildCurrentPage() {
    if (_tabCache.containsKey(_selectedIndex)) {
      return _tabCache[_selectedIndex]!;
    }

    Widget tab;
    switch (_selectedIndex) {
      case 0:
        tab = _ExpensesTab(
          expenses: expenses,
          onExpenseAdded: _addExpense,
          onExpenseDeleted: _deleteExpense,
        );
        break;
      case 1:
        tab = _AnalyticsTab(expenses: expenses);
        break;
      case 2:
        tab = _CategoriesTab(expenses: expenses);
        break;
      case 3:
        tab = _SettingsTab(onLogout: _logout);
        break;
      default:
        tab = _ExpensesTab(
          expenses: expenses,
          onExpenseAdded: _addExpense,
          onExpenseDeleted: _deleteExpense,
        );
    }

    // Cache non-expenses tabs
    if (_selectedIndex != 0) {
      _tabCache[_selectedIndex] = tab;
    }
    
    return tab;
  }

  String _getAppBarTitle() {
    switch (_selectedIndex) {
      case 0: return 'Daily Expenses';
      case 1: return 'Analytics';
      case 2: return 'Categories';
      case 3: return 'Settings';
      default: return 'Daily Expenses';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.sandBeige,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(
                Icons.account_balance_wallet,
                color: AppColors.mintGreen,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _getAppBarTitle(),
                style: const TextStyle(
                  color: AppColors.charcoal,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.sandBeige,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(
              Icons.logout,
              color: AppColors.warmCoral,
              size: 20,
            ),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: _buildCurrentPage(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onNavigationTapped,
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.mintGreen,
        unselectedItemColor: AppColors.lightGray,
        showUnselectedLabels: true,
        elevation: 4,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 20),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics, size: 20),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category, size: 20),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, size: 20),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 0 ? FloatingActionButton(
        onPressed: () async {
          await showDialog<Expense>(
            context: context,
            builder: (BuildContext context) {
              return AddExpenseDialog(onExpenseAdded: _addExpense);
            },
          );
        },
        backgroundColor: AppColors.warmCoral,
        mini: true,
        child: const Icon(Icons.add, color: AppColors.white, size: 20),
      ) : null,
    );
  }
}

// Lightweight Expenses Tab
class _ExpensesTab extends StatelessWidget {
  final List<Expense> expenses;
  final Function(Expense) onExpenseAdded;
  final Function(String) onExpenseDeleted;

  const _ExpensesTab({
    required this.expenses,
    required this.onExpenseAdded,
    required this.onExpenseDeleted,
  });

  @override
  Widget build(BuildContext context) {
    final totalExpenses = expenses.fold(0.0, (sum, expense) => sum + expense.amount);
    
    return Column(
      children: [
        // Summary Card - Simplified
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Expenses',
                style: TextStyle(
                  color: AppColors.softGray,
                  fontSize: 14,
                ),
              ),
              Text(
                '\$${totalExpenses.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: AppColors.charcoal,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        
        // Expenses List
        Expanded(
          child: expenses.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.receipt_long, size: 48, color: AppColors.lightGray),
                      SizedBox(height: 16),
                      Text(
                        'No expenses yet',
                        style: TextStyle(fontSize: 16, color: AppColors.softGray),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    final expense = expenses[index];
                    return _ExpenseCard(
                      expense: expense,
                      onDelete: () => onExpenseDeleted(expense.id),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

// Lightweight Expense Card
class _ExpenseCard extends StatelessWidget {
  final Expense expense;
  final VoidCallback onDelete;

  const _ExpenseCard({required this.expense, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.mintGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(Icons.receipt, color: AppColors.mintGreen, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.title,
                  style: const TextStyle(
                    color: AppColors.charcoal,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  expense.category,
                  style: const TextStyle(
                    color: AppColors.softGray,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${expense.amount.toStringAsFixed(2)}',
            style: const TextStyle(
              color: AppColors.charcoal,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onDelete,
            child: const Icon(Icons.delete_outline, color: AppColors.warmCoral, size: 18),
          ),
        ],
      ),
    );
  }
}

// Lightweight Analytics Tab
class _AnalyticsTab extends StatelessWidget {
  final List<Expense> expenses;

  const _AnalyticsTab({required this.expenses});

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bar_chart, size: 48, color: AppColors.lightGray),
            SizedBox(height: 16),
            Text('No data to analyze', style: TextStyle(fontSize: 16, color: AppColors.softGray)),
          ],
        ),
      );
    }

    final totalExpenses = expenses.fold(0.0, (sum, expense) => sum + expense.amount);
    final Map<String, double> categoryTotals = {};
    for (final expense in expenses) {
      categoryTotals[expense.category] = 
          (categoryTotals[expense.category] ?? 0) + expense.amount;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.mintGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Icon(Icons.analytics, size: 36, color: AppColors.mintGreen),
                const SizedBox(height: 8),
                Text(
                  '\$${totalExpenses.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.charcoal),
                ),
                const Text('Total Expenses', style: TextStyle(color: AppColors.softGray)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...categoryTotals.entries.map((entry) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text('\$${entry.value.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

// Lightweight Categories Tab
class _CategoriesTab extends StatelessWidget {
  final List<Expense> expenses;

  const _CategoriesTab({required this.expenses});

  @override
  Widget build(BuildContext context) {
    const categories = ['Food', 'Transportation', 'Entertainment', 'Shopping', 'Health', 'Utilities'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Categories', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final count = expenses.where((e) => e.category == category).length;
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(category, style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text('$count items', style: const TextStyle(color: AppColors.softGray, fontSize: 12)),
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

// Lightweight Settings Tab
class _SettingsTab extends StatelessWidget {
  final VoidCallback onLogout;

  const _SettingsTab({required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 16),
            child: ElevatedButton.icon(
              onPressed: onLogout,
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.warmCoral,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
