import 'package:expense_tracker/Models/expense_model.dart';
import 'package:expense_tracker/Widgets/Expenses_list/expense_item.dart';
import 'package:flutter/widgets.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expensesList, required this.onDeleteExpense});
  final List<ExpenseModel> expensesList;
  final void Function(ExpenseModel expense) onDeleteExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expensesList[index].id),
        child: ExpenseItem(expensesList[index]),
        onDismissed: (direction) => onDeleteExpense(expensesList[index]),
      ),
      itemCount: expensesList.length,
    );
  }
}
