import 'package:dawini_full/introduction_feature/presentation/bloc/bloc/introduction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    final AppLocalizations text = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xffEDF5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color(0xffEDF5F5),
              height: 350.h,
              width: double.maxFinite,
              child: Image.asset(
                "assets/images/ss.png",
                fit: BoxFit.scaleDown,
              ),
            ),
            Container(
              width: double.maxFinite,
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
                padding: EdgeInsets.only(top: 10.h),
                child: Column(
                  children: [
                    languageContainer(
                      "Anglais",
                      bloc,
                      widget.languageSys,
                    ),
                    languageContainer(
                      "Français",
                      bloc,
                      widget.languageSys,
                    ),
                    languageContainer(
                      "العربية",
                      bloc,
                      widget.languageSys,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        width: 50.w,
                        height: 50.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffECF2F2),
                        ),
                        child: IconButton(
                          onPressed: () {
                            if (isSelected) {
                              bloc.add(const NextPage(id: 2));
                            }
                          },
                          icon: Icon(
                            Icons.arrow_forward,
                            size: 31.w,
                            color: const Color(0xff0AA9A9),
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

  Widget languageContainer(
      String language, IntroductionBloc bloc, String languageSys) {
    return Container(
      margin: EdgeInsets.all(8.h),
      width: 260.w,
      height: 50.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: languageSys == language
              ? const Color(0xFF2CDBC6)
              : Colors.grey.shade300,
          width: 2.w,
        ),
        borderRadius: BorderRadius.circular(16.h),
      ),
      child: InkWell(
        onTap: () {
          bloc.add(onLanguageChoose(language: language));
          setState(() {
            isSelected = true;
          });
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
