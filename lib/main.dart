import 'package:expense_tracker/views/add_expense_page.dart';
import 'package:expense_tracker/view_models/expense_view_model.dart';
import 'package:expense_tracker/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ExpenseViewModel()),
    ],
    child: const ExpenseTracker(),
  ));
}

class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({super.key});

  @override
  State<ExpenseTracker> createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final expensesViewModel = Provider.of<ExpenseViewModel>(context);
    const String appTitle = 'Expense Tracker';
    const Color seedColor = Color.fromARGB(255, 77, 205, 255);
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomePage(
          appTitle: appTitle,
          expensesViewModel: expensesViewModel,
          onPageSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        );
        break;
      case 1:
        page = AddExpensePage(
          onPageSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        );
        break;
      default:
        throw UnimplementedError('No Widget for $selectedIndex');
    }
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: seedColor,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: ColorScheme.fromSeed(seedColor: seedColor).primary,
            iconTheme: IconThemeData(
              color: ColorScheme.fromSeed(seedColor: seedColor).onPrimary,
            ),
            titleTextStyle: TextStyle(
                color: ColorScheme.fromSeed(seedColor: seedColor).onPrimary,
                fontSize: 24),
          ),
          scaffoldBackgroundColor:
              ColorScheme.fromSeed(seedColor: seedColor).primaryContainer),
      title: appTitle,
      home: page,
    );
  }
}
