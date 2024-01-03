import "package:expense_tracker/Models/expense_model.dart";
import 'package:expense_tracker/Widgets/Expenses_list/expenses_list.dart';
import "package:flutter/material.dart";

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<ExpenseModel> _dummyExpenses = [
    ExpenseModel(
      title: "New Shoes",
      amount: 69.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    ExpenseModel(
      title: "Weekly Groceries",
      amount: 16.53,
      date: DateTime.now(),
      category: Category.food,
    ),
    ExpenseModel(
      title: "Flutter Course",
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    ExpenseModel(
      title: "Taxi Fare",
      amount: 15,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text("CHART!"),
          Expanded(
            child: ExpensesList(expensesList: _dummyExpenses),
          )
        ],
      ),
    );
  }
}
