import 'package:admin/12sess/12sess.dart';
import 'package:admin/16session/dash4.dart';
import 'package:admin/8session/dash5.dart';
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/product/dash.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/App%20stats/dashboard_screen.dart';
import 'package:admin/unlimited/dash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  void onItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(
        selectedIndex: selectedIndex,
        onItemSelected: onItemSelected,
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(
                  selectedIndex: selectedIndex,
                  onItemSelected: onItemSelected,
                ),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: IndexedStack(
                index: selectedIndex,
                children: [
                  DashboardScreen(),
                  DashboardScreen7(),
                  DashboardScreen5(),
                  DashboardScreen6(),
                  DashboardScreen4(),
                  Productdash()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
