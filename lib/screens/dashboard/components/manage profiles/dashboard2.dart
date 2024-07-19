import 'package:admin/constants.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/dashboard/components/manage%20profiles/Most_visited.dart';
import 'package:admin/screens/dashboard/components/manage%20profiles/desactivatedprofiles.dart';
import 'package:admin/screens/dashboard/components/manage%20profiles/recomProfiles.dart';
import 'package:flutter/material.dart';

class DashboardScreen2 extends StatelessWidget {
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
            MostVisited(),
            RecomDoctors(),
            DesactivatedProfiles(),
          ]),
        ),
      ),
    );
  }
}
