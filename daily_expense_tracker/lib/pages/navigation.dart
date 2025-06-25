import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/colors.dart';
import '../models/expense.dart';
import '../widgets/add_expense_dialog.dart';
import 'tabs/expenses_tab.dart';
import 'tabs/analytics_tab.dart';
import 'tabs/categories_tab.dart';
import 'tabs/settings_tab.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  late List<Expense> expenses;

  @override
  void initState() {
    super.initState();
    // Initialize with sample data
    expenses = [
      Expense(
        id: '1',
        title: 'Groceries',
        amount: 45.50,
        category: 'Food',
        date: DateTime.now().subtract(const Duration(days: 1)),
        description: 'Weekly grocery shopping',
      ),
      Expense(
        id: '2',
        title: 'Gas',
        amount: 60.00,
        category: 'Transportation',
        date: DateTime.now().subtract(const Duration(days: 2)),
        description: 'Car fuel',
      ),
    ];
  }

  void _onNavigationTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addExpense(Expense expense) {
    setState(() {
      expenses.insert(0, expense);
    });
  }

  void _deleteExpense(String id) {
    setState(() {
      expenses.removeWhere((expense) => expense.id == id);
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
                // Navigate back to login screen using go_router
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

  Widget _buildCurrentPage() {
    switch (_selectedIndex) {
      case 0:
        return ExpensesTab(
          expenses: expenses,
          onExpenseAdded: _addExpense,
          onExpenseDeleted: _deleteExpense,
        );
      case 1:
        return AnalyticsTab(expenses: expenses);
      case 2:
        return CategoriesTab(expenses: expenses);
      case 3:
        return SettingsTab(onLogout: _logout);
      default:
        return ExpensesTab(
          expenses: expenses,
          onExpenseAdded: _addExpense,
          onExpenseDeleted: _deleteExpense,
        );
    }
  }

  String _getAppBarTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Daily Expenses';
      case 1:
        return 'Analytics';
      case 2:
        return 'Categories';
      case 3:
        return 'Settings';
      default:
        return 'Daily Expenses';
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
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.charcoal.withValues(alpha: 0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/logo.png',
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _getAppBarTitle(),
                style: const TextStyle(
                  color: AppColors.charcoal,
                  fontSize: 20,
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
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.warmCoral.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.logout,
                color: AppColors.warmCoral,
                size: 20,
              ),
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
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 0 ? FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddExpenseDialog(
                onExpenseAdded: _addExpense,
              );
            },
          );
        },
        backgroundColor: AppColors.warmCoral,
        child: const Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ) : null,
    );
  }
}
