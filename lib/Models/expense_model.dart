import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:uuid/uuid.dart";

const uuid = Uuid();

enum Category {
  food,
  travel,
  leisure,
  work,
}

final formatter = DateFormat.yMMMd();

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class ExpenseModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  ExpenseModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  final Category category;
  final List<ExpenseModel> expenses;

  ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<ExpenseModel> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpenseAmount {
    return expenses.fold(0.0, (sum, expense) => sum + expense.amount);
  }
}
