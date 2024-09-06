import 'package:admin/main.dart';
import 'package:admin/screens/dashboard/components/App%20stats/dashboard_screen.dart';
import 'package:admin/screens/dashboard/components/rfid_bloc/rfid_plan_bloc.dart';
import 'package:admin/screens/expense_list/expense_plan_bloc/bloc/expense_plan_bloc.dart';
import 'package:admin/screens/plans/12sess/12session_bloc/bloc/12session_bloc.dart';
import 'package:admin/screens/plans/16session/16session_bloc/bloc/16session_bloc.dart';
import 'package:admin/screens/plans/8session/8session_bloc/bloc/8session_bloc.dart';
import 'package:admin/screens/plans/unlimited/unlimited_plan_bloc/bloc/unlimited_plan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:admin/screens/plans/8session/8session_bloc/bloc/session_8_event.dart'
    as Event8;
import 'package:admin/screens/plans/16session/16session_bloc/bloc/session_16_event.dart'
    as Event16;
import 'package:admin/screens/expense_list/expense_plan_bloc/bloc/expense_plan_bloc.dart'
    as Expense;
import 'package:admin/screens/plans/12sess/12session_bloc/bloc/session_12_event.dart'
    as Event12;
import 'package:admin/screens/dashboard/components/rfid_bloc/rfid_plan_bloc.dart' as RFID;

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 0;

  final List<Widget> _pages = [
    DashboardScreen(), // Your actual screens
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

class SideMenu extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

   SideMenu({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final TextEditingController _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Unlimited_PlanBloc _unlimited_bloc =
        BlocProvider.of<Unlimited_PlanBloc>(context);
    final Session_8_PlanBloc session_8_planBloc =
        BlocProvider.of<Session_8_PlanBloc>(context);
    final Session_16_PlanBloc session_16_planBloc =
        BlocProvider.of<Session_16_PlanBloc>(context);
    final Session_12_PlanBloc session_12_planBloc =
        BlocProvider.of<Session_12_PlanBloc>(context);
    final Expense_PlanBloc expense_planBloc =
        BlocProvider.of<Expense_PlanBloc>(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(
            color: Color(0xffFFA05C).withOpacity(0.3), // Color of the border
            width: 2.5, // Width of the border
          ),
        ),
      ),
      child: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(0)),
        ),
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            Container(
              height: 150,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GenderSelectionPage()
                  ),
                );
                  },
                  child: Image.asset(
                    "assets/images/gymer.png",
                  ),
                ),
              ),
            ),
            DrawerListTile(
              title: "Gym stats",
              svgSrc: "assets/icons/stats.svg",
              press: () {
                widget.onItemSelected(0);
              },
              isSelected: widget.selectedIndex == 0,
            ),
            DrawerListTile(
              title: "Unlimited Plan",
              svgSrc: "assets/icons/create.svg",
              press: () {
                widget.onItemSelected(1);
                _unlimited_bloc.add(GetUsersEvent(context: context));
              },
              isSelected: widget.selectedIndex == 1,
            ),
            DrawerListTile(
              title: "8 session Plan",
              svgSrc: "assets/icons/create.svg",
              press: () {
                widget.onItemSelected(2);
                session_8_planBloc.add(Event8.GetUsersEvent(context: context));
              },
              isSelected: widget.selectedIndex == 2,
            ),
            DrawerListTile(
              title: "12 session Plan",
              svgSrc: "assets/icons/create.svg",
              press: () {
                widget.onItemSelected(3);
                session_12_planBloc
                    .add(Event12.GetUsersEvent(context: context));
              },
              isSelected: widget.selectedIndex == 3,
            ),
            DrawerListTile(
              title: "16 session Plan",
              svgSrc: "assets/icons/create.svg",
              press: () {
                widget.onItemSelected(4);
                session_16_planBloc
                    .add(Event16.GetUsersEvent(context: context));
              },
              isSelected: widget.selectedIndex == 4,
            ),
            DrawerListTile(
              title: "Product",
              svgSrc: "assets/icons/k.svg",
              press: () {
                widget.onItemSelected(5);
                expense_planBloc
                    .add(Expense.GetExpensesEvent(context: context));
              },
              isSelected: widget.selectedIndex == 5,
            ),
            DrawerListTile(
              title: "Expense",
              svgSrc: "assets/icons/d.svg",
              press: () {
                widget.onItemSelected(6);
              },
              isSelected: widget.selectedIndex == 6,
            ),
         Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0)
                                    .withOpacity(0.3), // Color of the border
                                width: 2.5, // Width of the border
                              ),
                            ),
                          ),
                          child: _inputField(_idController, 'User id', true),
                          width: 250,
                        ),
                      ),
                      BlocBuilder<Rfid_PlanBloc, Rfid_PlanState>(
                        builder: (context, state) {
                          if (state is RFID.SuccessState) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top:
                                      4.0), // Add some spacing between the input and the text
                              child: Text(
                                state.done.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 0, 153, 0),
                                ),
                              ),
                            );
                          } else if (state is RFID.ErrorState) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top:
                                      4.0), // Add some spacing between the input and the text
                              child: Text(
                                state.error.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 153, 0, 0),
                                ),
                              ),
                            );
                          } else if (state is RFID.LoadingState) {
                            return Container();
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
         
          ],
        ),
      ),
    );
  }


Widget _inputField(
      TextEditingController controller, String hint, bool numberOrNot) {
    final Rfid_PlanBloc rfid_planBloc = BlocProvider.of<Rfid_PlanBloc>(context);

    return TextFormField(
      controller: controller,
      keyboardType: numberOrNot ? TextInputType.number : null,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: 16,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
      onEditingComplete: () {
        _rfidCardUserCheck(rfid_planBloc, context);
          },
      // onChanged: (value) {
      //   // Call _addProfile() when Enter is pressed.
      //   if (value.length > 4) {
      //     _idController.text = value;

      //     // _unlimited_bloc.add(GetUsersEvent());
      //     // session_8_planBloc.add(Event8.GetUsersEvent());
      //     // session_12_planBloc.add(Event12.GetUsersEvent());
      //     // session_16_planBloc.add(Event16.GetUsersEvent());
      //     // expense_planBloc.add(Expense.GetExpensesEvent());
      //   }
      // },
    );
  }

  void _rfidCardUserCheck(Rfid_PlanBloc rfid_planBloc, BuildContext context) {
    if (_idController.text.isNotEmpty) {
      rfid_planBloc
          .add(RFID.UpdateUserEvent(id: _idController.text, context: context));
      _idController.clear();
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
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
      tileColor: isSelected ? Color(0xffFFA05D) : Colors.white,
      onTap: press,
      horizontalTitleGap: 6.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(
            isSelected ? Color(0xffFFA05D) : Color(0xff202020).withOpacity(0.5),
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
