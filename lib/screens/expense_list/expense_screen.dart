import 'package:admin/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

class ExpenseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(0),
          child: Column(
            children: [
              Header(),
              SizedBox(height: defaultPadding),
              expense(),
            ],
          ),
        ),
      ),
    );
  }
}


class expense extends StatefulWidget {
  const expense({super.key});

  @override
  State<expense> createState() => _expenseState();
}

class _expenseState extends State<expense> {
  @override
  Widget build(BuildContext context) {
    
    return const Placeholder();
  }
}