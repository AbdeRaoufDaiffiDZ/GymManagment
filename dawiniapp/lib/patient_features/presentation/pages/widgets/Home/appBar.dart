// ignore_for_file: use_build_context_synchronously, camel_case_types

import 'package:dawini_full/auth/presentation/loginPage.dart';
import 'package:dawini_full/auth/presentation/welcomePage.dart';
import 'package:dawini_full/introduction_feature/domain/usecases/set_type_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class myAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? uid;
  final bool popOrNot;
  myAppbar({Key? key, this.uid, required this.popOrNot}) : super(key: key);
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
            IconButton(
              onPressed: () async {
                if (uid == null) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                } else {
                  await setTypeUseCase.execute("doctor");
                  if (popOrNot) {
                    Navigator.pop(context);
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const doctorsideHome(
                                  popOrNot: true,
                                )));
                  }
                }
              },
              icon: Icon(
                Icons.menu,
                size: 30.w,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.h);
}
