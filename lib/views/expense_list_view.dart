import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/view_models/expense_view_model.dart';
import 'package:expense_tracker/views/add_expense_page.dart';
import 'package:expense_tracker/views/expense_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseListView extends StatelessWidget {
  const ExpenseListView({super.key});

  Future<bool?> _showDeleteConfirmationDialog(BuildContext context,
      Expense expense, ExpenseViewModel expensesViewModel) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: Text('Are you sure you want to delete "${expense.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // Peruuta
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              expensesViewModel.removeExpense(expense.id); // Poista kulu
              Navigator.of(context).pop(true); // Sulje dialogi
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final expensesViewModel = Provider.of<ExpenseViewModel>(context);
    final expenses = expensesViewModel.expenses;

    return Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 7, right: 7, top: 5, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(5),
              itemCount: expenses.length,
              itemBuilder: (BuildContext context, int index) {
                final expense = expenses[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddExpensePage(
                              expense: expense,
                              onPageSelected: (selectedIndex) {
                                Navigator.of(context).pop();
                              },
                            )));
                  },
                  child: Dismissible(
                    key: ValueKey(expense.id),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) async {
                      return await _showDeleteConfirmationDialog(
                          context, expense, expensesViewModel);
                    },
                    background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.black,
                        )),
                    child: ExpenseContainer(expense: expense),
                  ),
                );
              },
            )));
  }
}
