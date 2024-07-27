import 'package:admin/8session/8session.dart';
import 'package:admin/constants.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';

class DashboardScreen5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(0),
          child: Column(children: [
            Header(),
            SizedBox(height: defaultPadding),
             eightSession()
          ]),
        ),
      ),
    );
  }
}
