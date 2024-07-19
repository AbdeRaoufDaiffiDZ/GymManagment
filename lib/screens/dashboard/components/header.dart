import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Color(0xffFAFAFA),
        border: Border(
          bottom: BorderSide(
            color: Color(0xffE6E6E6), // Color of the border
            width: 2.5, // Width of the border
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            if (!Responsive.isDesktop(context))
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: context.read<MenuAppController>().controlMenu,
              ),
            if (!Responsive.isMobile(context))
              Text(
                "Dawina’s dashbaord ! ",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 23),
              ),
          ],
        ),
      ),
    );
  }
}
