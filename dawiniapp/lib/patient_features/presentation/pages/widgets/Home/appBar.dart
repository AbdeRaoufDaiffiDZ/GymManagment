// ignore_for_file: use_build_context_synchronously

import 'package:dawini_full/auth/presentation/loginPage.dart';
import 'package:dawini_full/auth/presentation/welcomePage.dart';
import 'package:dawini_full/introduction_feature/domain/usecases/set_type_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class myAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? uid;
  myAppbar({Key? key, this.uid}) : super(key: key);
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
                // final routeName = ModalRoute.of(context)!.settings.name;
                // print("Current route name: $routeName");
                if (await Navigator.maybePop(context, const doctorsideHome())) {
                  print("yes");
                  // Navigator.popUntil(context, ModalRoute.withName("TargetPage"));
                } else {
                  // Handle the case where popping to the target page is not possible
                }
                if (uid == null) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                } else {
                  await setTypeUseCase.execute("doctor");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const doctorsideHome()));
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
