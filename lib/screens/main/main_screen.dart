import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/App%20stats/dashboard_screen.dart';
import 'package:admin/screens/dashboard/components/create%20profiles/dash3.dart';
import 'package:admin/screens/dashboard/components/manage%20profiles/dashboard2.dart';
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
                  DashboardScreen(), // Replace with your actual dashboard screens
                  DashboardScreen2(),
                  DashboardScreen3(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
