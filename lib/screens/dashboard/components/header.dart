import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Header extends StatefulWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text("Gym’s dashbaord ! ",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 23,
                        color: Colors.black)),
              ),
              Spacer(),
             
            ],
          ),
        ),
      ),
    );
  }

  
}
