// ignore_for_file: use_build_context_synchronously, camel_case_types, file_names

import 'package:dawini_full/auth/presentation/welcomePage.dart';
import 'package:dawini_full/introduction_feature/domain/usecases/set_type_usecase.dart';
import 'package:dawini_full/patient_features/presentation/pages/weather_pag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class myAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? uid;
  final bool fromWhere;
  myAppbar({Key? key, this.uid, required this.fromWhere}) : super(key: key);
  final SetTypeUseCase setTypeUseCase = SetTypeUseCase();

  @override
  Widget build(BuildContext context) {
    final bool isArabic = Localizations.localeOf(context).languageCode == "ar";

    return SafeArea(
      child: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: isArabic
                  ? EdgeInsets.only(right: 11.w)
                  : EdgeInsets.only(left: 11.w),
              child: Image.asset(
                "assets/images/dawina.png",
                width: 90.w,
              ),
            ),
            IconButton(
              onPressed: () async {
                if (fromWhere) {
                  await setTypeUseCase.execute("patient");

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Weather()));
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
                size: 30.sp,
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
