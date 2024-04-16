import 'package:dawini_full/introduction_feature/presentation/bloc/bloc/introduction_bloc.dart';
import 'package:dawini_full/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Localisation extends StatefulWidget {
  final String languageSys;

  const Localisation({super.key, required this.languageSys});

  @override
  State<Localisation> createState() => _LocalisationState();
}

class _LocalisationState extends State<Localisation> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    final IntroductionBloc bloc = BlocProvider.of<IntroductionBloc>(context);
    final AppLocalizations text = AppLocalizations.of(context)!;
    final String languageCode = Localizations.localeOf(context).languageCode;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Container(
            //   margin: EdgeInsets.all(8.h),
            //   child: Image.asset("assets/images/cc.png"),
            // ),
            languageContainer("English", "en",bloc, languageCode),
            languageContainer("Français","fr", bloc, languageCode),
            languageContainer("العربية", "ar",bloc, languageCode),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50.w, vertical: 16.h),
              height: 50.h,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF2CDBC6)
                    : const Color.fromARGB(108, 44, 219, 199),
                borderRadius: BorderRadius.circular(16.h),
              ),
              child: InkWell(
                onTap: () {
                  if (isSelected) {
                    bloc.add(const NextPage(id: 2));
                  }
                   Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  const MyApp(pageNumber: 2,)
                ));
                },
                child: Center(
                  child: Text(
                    text.next,
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
    );
  }

  Widget languageContainer(
      String language, String languageCode, IntroductionBloc bloc, String languageSys) {
    return Container(
      margin: EdgeInsets.all(8.h),
      width: 150.w,
      height: 40.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: languageSys == languageCode
              ? const Color(0xFF2CDBC6)
              : Colors.grey.shade300,
          width: 2.w,
        ),
        borderRadius: BorderRadius.circular(16.h),
      ),
      child: InkWell(
        onTap: () {
          bloc.add(onLanguageChoose(language: languageCode));
          setState(() {
            isSelected = true;
          });
        },
        child: Center(
          child: Text(
            language,
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: 'Nunito',
            ),
          ),
        ),
      ),
    );
  }
}
