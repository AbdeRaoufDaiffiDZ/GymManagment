import 'package:dawini_full/introduction_feature/data/lanugage_constant.dart';
import 'package:dawini_full/introduction_feature/presentation/bloc/bloc/introduction_bloc.dart';
import 'package:dawini_full/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    // final AppLocalizations text = AppLocalizations.of(context)!;
    final String languageCode = Localizations.localeOf(context).languageCode;
     double screenHeight = MediaQuery.of(context).size.height;
     double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffEDF5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color(0xffEDF5F5),
              height: 0.5*screenHeight,
              width: double.maxFinite,
              child: Image.asset(
                "assets/images/ss.png",
                fit: BoxFit.scaleDown,
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 0.5*screenHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0XFF000000).withOpacity(0.1),
                    blurRadius: 2,
                    offset: const Offset(0, 0),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: (0.5*screenHeight) * 0.1),
                child: Column(
                  children: [
                    languageContainer("English", "en", bloc, languageCode, screenHeight),
                    languageContainer("Français", "fr", bloc, languageCode, screenHeight),
                    languageContainer("العربية", "ar", bloc, languageCode, screenHeight),
                    Padding(
                      padding: EdgeInsets.all((0.5*screenHeight) * 0.01),
                      child: Container(
                        width: (0.5*screenHeight) * 0.13,
                        height: (0.5*screenHeight) * 0.13,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffECF2F2),
                        ),
                        child: IconButton(
                          onPressed: () {
                            bloc.add(const NextPage(id: 2));
                          },
                          icon: Center(
                            child: Icon(
                              Icons.arrow_forward,
                              size: ((0.5*screenHeight) * 0.13)* 0.6,
                              color: const Color(0xff0AA9A9),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget languageContainer(String language, String languageCode,
      IntroductionBloc bloc, String languageSys, double screenHeight) {
    return Container(
      margin: EdgeInsets.all((0.5*screenHeight) * 0.02),
      width: 260.w,
      height: (0.5*screenHeight) * 0.15,
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
        onTap: () async {
         
                      Locale locale = await setLocale(languageCode);
                      MyApp.setLocale(context, locale);
                    
          // bloc.add(onLanguageChoose(language: languageCode));

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => const MyApp(
          //               pageNumber: null,
          //             )));
        },
        child: Center(
          child: Text(
            language,
            style: TextStyle(
              fontSize: 20.sp,
              fontFamily: 'Nunito',
            ),
          ),
        ),
      ),
    );
  }
}
