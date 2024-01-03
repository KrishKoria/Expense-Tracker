import 'package:expense_tracker/Models/expense_model.dart';
import 'package:flutter/widgets.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expensesList});
  final List<ExpenseModel> expensesList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) => Text(expensesList[index].title),
      itemCount: expensesList.length,
    );
  }
}
