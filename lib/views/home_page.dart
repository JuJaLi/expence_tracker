import 'package:expense_tracker/view_models/expense_view_model.dart';
import 'package:expense_tracker/views/expense_list_view.dart';
import 'package:expense_tracker/views/progress_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.appTitle,
    required this.expensesViewModel,
    required this.onPageSelected,
  });

  final String appTitle;
  final ExpenseViewModel expensesViewModel;
  final ValueChanged<int> onPageSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => onPageSelected(1),
            )
          ],
        ),
        body: const Column(
          children: [
            ProgressCard(),
            ExpenseListView(),
          ],
        ));
  }
}
