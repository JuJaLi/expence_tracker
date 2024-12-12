import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import '../models/category.dart';

class ExpenseViewModel extends ChangeNotifier {
  final List<Expense> _expenses = [];

  List<ExpenseCategory> get categories => ExpenseCategory.values;

  List<Expense> get expenses => [..._expenses];

  void addExpense(
      String title, double amount, DateTime date, ExpenseCategory category) {
    final newExpense = Expense(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
      category: category,
    );

    _expenses.add(newExpense);
    notifyListeners();
  }

  void removeExpense(String id) {
    _expenses.removeWhere((expense) => expense.id == id);
    notifyListeners();
  }

  Map<ExpenseCategory, double> getCategorySums() {
    final Map<ExpenseCategory, double> categorySums = {
      for (var category in ExpenseCategory.values) category: 0.0,
    };
    for (var expense in _expenses) {
      categorySums[expense.category] =
          categorySums[expense.category]! + expense.amount;
    }
    return categorySums;
  }

  void updateExpense(Expense updatedExpense) {
    final index =
        _expenses.indexWhere((expense) => expense.id == updatedExpense.id);
    if (index != -1) {
      _expenses[index] = updatedExpense;
      notifyListeners();
    }
  }
}
