import 'package:admin/screens/dashboard/components/App%20stats/users.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../header.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(0),
          child: Column(
            children: [
              Header(),
              SizedBox(height: defaultPadding),
              users(),
            ],
          ),
        ),
      ),
    );
  }
}
