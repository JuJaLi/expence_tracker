import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/view_models/expense_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final expensesViewModel = Provider.of<ExpenseViewModel>(context);
    const double progressBarWidth = 0.7;
    return Card(
        margin: const EdgeInsets.only(left: 7, right: 7, top: 5),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: expensesViewModel.getCategorySums().entries.map((entry) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 25, child: FaIcon(entry.key.icon)),
                  SizedBox(
                      width:
                          MediaQuery.sizeOf(context).width * progressBarWidth,
                      child:
                          LinearProgressIndicator(value: (entry.value / 100))),
                  SizedBox(
                      width: 45,
                      child: Text('${entry.value.toStringAsFixed(1)}€'))
                ],
              );
            }).toList(),
          ),
        ));
  }
}
