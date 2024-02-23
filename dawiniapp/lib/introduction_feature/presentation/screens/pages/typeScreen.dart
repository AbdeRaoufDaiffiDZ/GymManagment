// ignore_for_file: file_names, non_constant_identifier_names

import 'package:dawini_full/introduction_feature/presentation/bloc/bloc/introduction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TypeScreen extends StatefulWidget {
  final String type;

  const TypeScreen({super.key, required this.type});

  @override
  State<TypeScreen> createState() => _TypeScreenState();
}

class _TypeScreenState extends State<TypeScreen> {
  @override
  Widget build(BuildContext context) {
    final IntroductionBloc bloc = BlocProvider.of<IntroductionBloc>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Who are you!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 0.2),
            MaterialButton(
              color: "patient" == widget.type ? Colors.green : Colors.grey,
              onPressed: () {
                // Add the action you want to perform when the button is pressed
                // For example, you can show a dialog or navigate to another screen.
                bloc.add(const onTypeChoose(type: "patient"));
              },
              child: const Text('Looking for a Doctor'),
            ), // Add spacing between text and button

            const SizedBox(height: 20.0),
            MaterialButton(
              color: "doctor" == widget.type ? Colors.green : Colors.grey,
              onPressed: () {
                // Add the action you want to perform when the button is pressed
                // For example, you can show a dialog or navigate to another screen.
                bloc.add(const onTypeChoose(type: "doctor"));
              },
              child: const Text("I'm a Doctor"),
            ), // Add spacing between text and button
            const SizedBox(height: 20.0),
            SizedBox(
              width: 0.5,
              child: ElevatedButton(
                onPressed: () {
                  // Add the action you want to perform when the button is pressed
                  // For example, you can show a dialog or navigate to another screen.
                  bloc.add(const NextPage(id: 3));
                },
                child: const Text('next'),
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     // Add the action you want to perform when the button is pressed
            //     // For example, you can show a dialog or navigate to another screen.
            //     bloc.add(NextPage(id: 3));
            //   },
            //   child: Text('Looking for a Doctor'),
            // ),
            // SizedBox(height: 20.0), // Add spacing between text and button
            // ElevatedButton(
            //   onPressed: () {
            //     // Add the action you want to perform when the button is pressed
            //     // For example, you can show a dialog or navigate to another screen.
            //     bloc.add(NextPage(id: 3));
            //   },
            //   child: Text("I'm a Doctor"),
            // )
          ],
        ),
      ),
    );
  }
}

class UserTypeSelector extends StatefulWidget {
  final String type;

  const UserTypeSelector({Key? key, required this.type}) : super(key: key);

  @override
  State<UserTypeSelector> createState() => _UserTypeSelectorState();
}

class _UserTypeSelectorState extends State<UserTypeSelector> {
  String MyTypeIs = "";
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    final IntroductionBloc bloc = BlocProvider.of<IntroductionBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: 250.w,
                margin: const EdgeInsets.all(8),
                child: Image.asset("assets/images/pp.png"),
              ),
              SizedBox(
                height: 20.h,
              ),
              Image.asset(
                "assets/images/dawini.png",
                width: 140.w,
                height: 36.h,
              ),
              Text(
                "For effortless Appointment Booking",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 17.sp,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600),
              ),
              Text("Bridging Doctors and Patients",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600,
                      color: Colors.black45)),
              SizedBox(height: 20.h),
              usertypeContainer("Looking for a doctor", bloc),
              usertypeContainer("Im doctor", bloc),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                onTap: () {
                  if (isSelected) {
                    bloc.add(const NextPage(id: 3));
                  }
                },
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 50.w, vertical: 16.h),
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF2CDBC6)
                        : const Color.fromARGB(108, 44, 219, 199),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.sp,
                        color: Colors.white,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget usertypeContainer(String MyType, IntroductionBloc bloc) {
    return InkWell(
      onTap: () {
        if (MyType == "Looking for a doctor") {
          bloc.add(const onTypeChoose(type: "patient"));
        } else if (MyType == "Im doctor") {
          bloc.add(const onTypeChoose(type: "doctor"));
        }
        isSelected = true;
        setState(() {
          MyTypeIs = MyType;
        });
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        width: 150.w,
        height: 40.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: MyTypeIs == MyType
                ? const Color(0xFF2CDBC6)
                : Colors.grey.shade300,
            width: 2.w,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            MyType,
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'Nunito',
            ),
          ),
        ),
      ),
    );
  }
}
