import 'package:admin/screens/dashboard/components/App%20stats/dashboard_screen.dart';
import 'package:admin/screens/dashboard/components/manage%20profiles/dashboard2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 0;

  final List<Widget> _pages = [
    DashboardScreen(), // Your actual screens
    DashboardScreen2(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideMenu(
            selectedIndex: selectedIndex,
            onItemSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }
}

class SideMenu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const SideMenu({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffFAFAFA),
        border: Border(
          right: BorderSide(
            color: Color(0xffE6E6E6), // Color of the border
            width: 2.5, // Width of the border
          ),
        ),
      ),
      child: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(0)),
        ),
        backgroundColor: Color(0xffFAFAFA),
        child: ListView(
          children: [
            Container(
              height: 150,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: Color(0xffFAFAFA),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Image.asset(
                  "assets/images/gymer.png",
                ),
              ),
            ),
            DrawerListTile(
              title: "App stats",
              svgSrc: "assets/icons/stats.svg",
              press: () {
                onItemSelected(0);
              },
              isSelected: selectedIndex == 0,
            ),
            DrawerListTile(
              title: "Manage profiles",
              svgSrc: "assets/icons/manage.svg",
              press: () {
                onItemSelected(1);
              },
              isSelected: selectedIndex == 1,
            ),
            DrawerListTile(
              title: "Unlimited Plan",
              svgSrc: "assets/icons/create.svg",
              press: () {
                onItemSelected(2);
              },
              isSelected: selectedIndex == 2,
            ),
            DrawerListTile(
              title: "8 session Plan",
              svgSrc: "assets/icons/create.svg",
              press: () {
                onItemSelected(3);
              },
              isSelected: selectedIndex == 3,
            ),
            DrawerListTile(
              title: "12 session Plan",
              svgSrc: "assets/icons/create.svg",
              press: () {
                onItemSelected(4);
              },
              isSelected: selectedIndex == 4,
            ),
            DrawerListTile(
              title: "16 session Plan",
              svgSrc: "assets/icons/create.svg",
              press: () {
                onItemSelected(5);
              },
              isSelected: selectedIndex == 5,
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
    required this.isSelected,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: isSelected,
      selectedTileColor: Color(0xffFFA05D).withOpacity(0.2),
      tileColor: isSelected ? Color(0xffFFA05D) : Color(0xffFAFAFA),
      onTap: press,
      horizontalTitleGap: 6.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(
            isSelected ? Color(0xffFFA05D) : Color(0xff202020).withOpacity(0.7),
            BlendMode.srcIn),
        height: 20,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected
              ? Color(0xffFFA05D)
              : Color(0xff202020).withOpacity(0.7),
        ),
      ),
    );
  }
}
