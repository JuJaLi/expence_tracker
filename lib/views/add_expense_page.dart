import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/view_models/expense_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key, required this.onPageSelected, this.expense});
  final Expense? expense;
  final ValueChanged<int> onPageSelected;
  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  initState() {
    super.initState();
    if (widget.expense != null) {
      _title = widget.expense!.title;
      _amount = widget.expense!.amount;
      _selectedDate = widget.expense!.date;
      _selectedCategory = widget.expense!.category;
    }
  }

  String? _title;
  double? _amount;
  DateTime? _selectedDate;
  ExpenseCategory? _selectedCategory;

  Future<void> _pickDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void handleReturnToHomePage() {
    widget.onPageSelected(0);
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      _formKey.currentState!.save();

      if (widget.expense == null) {
        Provider.of<ExpenseViewModel>(context, listen: false).addExpense(
          _title!,
          _amount!,
          _selectedDate!,
          _selectedCategory!,
        );
      } else {
        Provider.of<ExpenseViewModel>(context, listen: false)
            .updateExpense(Expense(
          id: widget.expense!.id,
          title: _title!,
          amount: _amount!,
          date: _selectedDate!,
          category: _selectedCategory!,
        ));
      }

      widget.onPageSelected(0);
    } else if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please pick a date')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<ExpenseViewModel>(context).categories;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add New Expense'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              handleReturnToHomePage();
            },
          ),
        ),
        body: Form(
            key: _formKey,
            child: Column(
              children: [
                //
                // Title Text
                //
                TextFormField(
                    initialValue: _title,
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _title = value;
                    }),
                //
                // Price and date row
                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        initialValue: _amount != null ? _amount.toString() : '',
                        decoration: const InputDecoration(labelText: 'Amount'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the amount';
                          }
                          final numValue = double.tryParse(value);
                          if (numValue == null || numValue <= 0) {
                            return 'Please enter a valid amount';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _amount = double.parse(value!);
                        },
                      ),
                    ),
                    Text(
                      _selectedDate == null
                          ? 'Select date'
                          : DateFormat('dd/MM/yyyy').format(_selectedDate!),
                    ),
                    ElevatedButton(
                        child: const Icon(Icons.calendar_month),
                        onPressed: () => _pickDate(context)),
                  ],
                ),
                //
                //Dropdown and buttons row
                //
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<ExpenseCategory>(
                        decoration:
                            const InputDecoration(labelText: 'Category'),
                        value: _selectedCategory,
                        items: categories
                            .map((category) => DropdownMenuItem(
                                value: category,
                                child: Row(
                                  children: [
                                    Icon(
                                      category.icon,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(category.name)
                                  ],
                                )))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a category';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey),
                      child: const Text('Cancel'),
                      onPressed: () {
                        handleReturnToHomePage();
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Submit'),
                      onPressed: () {
                        _submitForm(context);
                      },
                    ),
                  ],
                )
              ],
            )));
  }
}
