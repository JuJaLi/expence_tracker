import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseContainer extends StatelessWidget {
  const ExpenseContainer({
    super.key,
    required this.expense,
  });

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 2),
        height: 60,
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(expense.category.name),
                  Text('€ ${expense.amount.toStringAsFixed(2)}'),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(expense.category.icon, size: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Text(DateFormat('dd/MM/yyyy').format(expense.date)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
