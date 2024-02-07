import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class localisation extends StatefulWidget {
  const localisation({Key? key}) : super(key: key);

  @override
  State<localisation> createState() => _LocalisationState();
}

class _LocalisationState extends State<localisation> {
  String selectedLanguage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              child: Image.asset("images/cc.png"),
            ),
            languageContainer("English"),
            languageContainer("French"),
            languageContainer("Arabic"),
            InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 13.w, vertical: 16.h),
                height: 60.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF2CDBC6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    "Next",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30.sp,
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
    );
  }

  Widget languageContainer(String language) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedLanguage = language;
        });
        print(language);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        width: 250.w,
        height: 60.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedLanguage == language
                ? const Color(0xFF2CDBC6)
                : Colors.grey.shade300,
            width: 2.w,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            language,
            style: TextStyle(
              fontSize: 28.sp,
              fontFamily: 'Nunito',
            ),
          ),
        ),
      ),
    );
  }
}
