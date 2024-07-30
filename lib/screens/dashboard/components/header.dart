import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xffFFA05C).withOpacity(0.3), // Color of the border
            width: 2.5, // Width of the border
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text("Gym’s dashbaord ! ",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 25,
                  color: Colors.black)),
        ),
      ),
    );
  }
}
