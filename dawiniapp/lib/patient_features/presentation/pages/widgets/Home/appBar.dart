import 'package:dawini_full/auth/presentation/loginPage.dart';
import 'package:dawini_full/auth/presentation/welcomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class myAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? uid;
  const myAppbar({Key? key, this.uid}) : super(key: key);

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
              onPressed: () {
                if (uid == null) {
                  print("null uid");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                } else {
                  print("null uid");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => doctorsideHome()));
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
