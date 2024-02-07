import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class myappbar extends StatelessWidget implements PreferredSizeWidget {
  const myappbar({Key? key}) : super(key: key);

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
                "images/dawini.png",
                width: 110.w,
              ),
            ),
            IconButton(
              onPressed: () {},
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
