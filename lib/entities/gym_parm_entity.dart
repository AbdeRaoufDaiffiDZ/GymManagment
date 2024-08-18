// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class GymParam extends Equatable {
  final String plan;
  int totalCredit;
  List<Expense> expenses;
  List<PeopleIncome> peopleIncome;

  GymParam({
    required this.plan,
    required this.totalCredit,
    List<PeopleIncome>? peopleIncome,
    List<Expense>? expenses,
  })  : peopleIncome = peopleIncome ?? [],
        expenses = expenses ?? [];

  @override
  List<Object?> get props => [plan, totalCredit, peopleIncome, expenses];

  factory GymParam.fromMap(Map<String, dynamic> map) {
    List peopleIncomesMap = [];
    List expensesMap = [];
    if (map['peopleIncome'] != null) {
      peopleIncomesMap = map['peopleIncome'];
    }
    if (map['expenses'] != null) {
      expensesMap = map['expenses'];
    }
    return GymParam(
      totalCredit: map['totalCredit'] ?? 0,
      plan: map['plan'] ?? '',
      expenses: expensesMap.map((e) => Expense.fromMap(e)).toList(),
      peopleIncome:
          peopleIncomesMap.map((e) => PeopleIncome.fromMap(e)).toList(),
    );
  }
  Map<String, dynamic> toMap() {
    List income = [];
    List expens = [];
    expenses.forEach((element) {
      expens.add(element.toMap());
    });
    peopleIncome.forEach((element) {
      income.add(element.toMap());
    });
    return {
      'plann': plan,
      'totalCredit': totalCredit,
      'peopleIncome': income,
      'expenses': expens,
    };
  }
}

class PeopleIncome extends Equatable {
  int dayIncome;
  DateTime dateTime;

  PeopleIncome({
    required this.dayIncome,
    required this.dateTime,
  });
  Map<String, dynamic> toMap() {
    return {
      'dayIncome': dayIncome,
      'dateTime': dateTime,
    };
  }

  factory PeopleIncome.fromMap(Map<String, dynamic> map) {
    return PeopleIncome(
      dayIncome: map['dayIncome'] ?? 0,
      dateTime: map['dateTime'] ?? DateTime.now(),
    );
  }
  @override
  List<Object?> get props => [dayIncome, dateTime];
}

class Expense extends Equatable {
  String expenseName;
  DateTime dateTime;
  int expensePrice;

  Expense({
    required this.expensePrice,
    required this.dateTime,
    required this.expenseName,
  });
  Map<String, dynamic> toMap() {
    return {
      'expenseName': expenseName,
      'expensePrice': expensePrice,
      'dateTime': dateTime,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      expenseName: map['expenseName'] ?? '',
      expensePrice: map['expensePrice'] ?? 0,
      dateTime: map['dateTime'] ?? DateTime.now(),
    );
  }
  @override
  List<Object?> get props => [expensePrice, expenseName, dateTime];
}
