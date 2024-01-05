import 'package:expense_tracker/Models/expense_model.dart';
import 'package:expense_tracker/Widgets/Expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expensesList, required this.onDeleteExpense});
  final List<ExpenseModel> expensesList;
  final void Function(ExpenseModel expense) onDeleteExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
        ),
        key: ValueKey(expensesList[index].id),
        child: ExpenseItem(expensesList[index]),
        onDismissed: (direction) => onDeleteExpense(expensesList[index]),
      ),
      itemCount: expensesList.length,
    );
  }
}
