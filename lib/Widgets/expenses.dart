import "package:expense_tracker/Models/expense_model.dart";
import 'package:expense_tracker/Widgets/Expenses_list/expenses_list.dart';
import "package:expense_tracker/Widgets/Form_Elements/new_expense.dart";
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
  void _addExpense(ExpenseModel expense) {
    setState(() {
      _dummyExpenses.add(expense);
    });
  }

  void _deleteExpense(ExpenseModel expense) {
    final index = _dummyExpenses.indexOf(expense);

    setState(() {
      _dummyExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x19000000),
                  spreadRadius: 2.0,
                  blurRadius: 8.0,
                  offset: Offset(2, 4),
                )
              ],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                const Icon(Icons.delete, color: Colors.black),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('${expense.title} deleted',
                      style: const TextStyle(color: Colors.black)),
                ),
                const Spacer(),
                TextButton(
                    onPressed: () {
                      setState(
                        () {
                          _dummyExpenses.insert(index, expense);
                        },
                      );
                    },
                    child: const Text("Undo"))
              ],
            )),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewExpense(_addExpense);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker",
            style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text("CHART!"),
          Expanded(
            child: _dummyExpenses.isNotEmpty
                ? ExpensesList(
                    expensesList: _dummyExpenses,
                    onDeleteExpense: _deleteExpense)
                : const Center(
                    child: Text("No expenses added yet!, maybe Add some"),
                  ),
          )
        ],
      ),
    );
  }
}
