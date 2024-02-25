// ignore_for_file: use_build_context_synchronously, camel_case_types, file_names

import 'package:dawini_full/auth/presentation/loginPage.dart';
import 'package:dawini_full/auth/presentation/welcomePage.dart';
import 'package:dawini_full/core/error/ErrorWidget.dart';
import 'package:dawini_full/introduction_feature/domain/usecases/set_type_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class myAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool popOrNot;
  myAppbar({Key? key, required this.popOrNot}) : super(key: key);
  final SetTypeUseCase setTypeUseCase = SetTypeUseCase();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 11.w),
              child: Image.asset(
                "assets/images/dawini.png",
                width: 110.w,
              ),
            ),
            StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return ErrorPage(
                      error: snapshot.error,
                    );
                    // Text('Error: ${snapshot.error}');
                  }
                  final user = snapshot.data;

                  return IconButton(
                    onPressed:
                        snapshot.connectionState == ConnectionState.active
                            ? () async {
                                if (user == null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage(
                                                popOrNot: popOrNot,
                                              )));
                                } else {
                                  await setTypeUseCase.execute("doctor");
                                  if (popOrNot) {
                                    Navigator.pop(context);
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const doctorsideHome(
                                                  popOrNot: true,
                                                )));
                                  }
                                }
                              }
                            : () {},
                    icon: Icon(
                      Icons.menu,
                      size: 30.w,
                      color: Colors.black,
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.h);
}
