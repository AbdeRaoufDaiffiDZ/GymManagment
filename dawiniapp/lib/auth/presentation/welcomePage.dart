// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, library_private_types_in_public_api, use_build_context_synchronously, file_names

import 'package:dawini_full/auth/data/FirebaseAuth/authentification.dart';
import 'package:dawini_full/auth/presentation/loginPage.dart';
import 'package:dawini_full/auth/presentation/signup.dart';
import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctor_cabinSide.dart/cabin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class doctorsideHome extends StatefulWidget {
  final bool popOrNot;

  const doctorsideHome({super.key, required this.popOrNot});

  @override
  State<doctorsideHome> createState() => _doctorsideHomeState();
}

class _doctorsideHomeState extends State<doctorsideHome> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuthMethods auth = FirebaseAuthMethods();

    return StreamBuilder<User?>(
        stream: auth.authState,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          final user = snapshot.data;
          return user != null
              ? DoctorCabinInfo(
                  uid: snapshot.data!.uid,
                  popOrNot: widget.popOrNot,
                )
              : LoginPage(
                  popOrNot: widget.popOrNot,
                );
//           if (snapshot.data == null) {
//             return LoginPage();
//           } else {
//             final user = snapshot.data;
// if(user != null){}
//             return DoctorCabinInfo(
//               uid: snapshot.data!.uid,
//               popOrNot: widget.popOrNot,
//             );
//             //   SafeArea(
//             //     child: Column(
//             //       children: [
//             //         MaterialButton(
//             //           color: Colors.white,
//             //           onPressed: () {
//             //             auth.signOut();
//             //           },
//             //           child: Text("clickTo Disconnect"),
//             //         ),
//             //         SizedBox(
//             //           height: 20.h,
//             //         ),

//             //     ],
//             //   ),
//             // );
//           }
        });
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key, this.title, required this.popOrNot})
      : super(key: key);
  final bool popOrNot;

  final String? title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Widget _submitButton(popOrNot) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginPage(
                      popOrNot: popOrNot,
                    )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xffdf8e33).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.white),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Color(0xfff7892b)),
        ),
      ),
    );
  }

  Widget _signUpButton(popOrNot) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SignUpPage(popOrNot: popOrNot)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Text(
          'Register now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _label() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            Text(
              'Quick login with Touch ID',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            SizedBox(
              height: 20,
            ),
            Icon(Icons.fingerprint, size: 90, color: Colors.white),
            SizedBox(
              height: 20,
            ),
            Text(
              'Touch ID',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ));
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'd',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: 'ev',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'rnz',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xfffbb448), Color(0xffe46b10)])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _title(),
              SizedBox(
                height: 80,
              ),
              _submitButton(widget.popOrNot),
              SizedBox(
                height: 20,
              ),
              _signUpButton(widget.popOrNot),
              SizedBox(
                height: 20,
              ),
              _label()
            ],
          ),
        ),
      ),
    );
  }
}
