import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

enum Category { food, travel, leisure, work }

final formatter = DateFormat.yMd();
const categoryIcons = {
  Category.work: Icons.work,
  Category.food: Icons.dining,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
};

class Expense {
  Expense(
      {required this.data,
      required this.amount,
      required this.title,
      required this.category})
      : id = uuid.v4();
  final String id;
  final String title;
  final DateTime data;
  final double amount;
  final Category category;

  String get formattedDate {
    return formatter.format(this.data);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  final Category category;
  final List<Expense> expenses;

  ExpenseBucket.forCategory(List<Expense> allExpense, this.category)
      : expenses = allExpense
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
