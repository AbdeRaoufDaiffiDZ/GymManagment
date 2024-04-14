// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:dawini_full/introduction_feature/domain/usecases/set_language_usecase.dart';
import 'package:dawini_full/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SetLanguageUseCase setLanguageUseCase = SetLanguageUseCase();
  Locale? newLocale;

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);

    final AppLocalizations text = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display current language
            // List of available languages with radio buttons for selection
            DropdownButton<Locale>(
              value: newLocale ?? currentLocale,
              items: const [
                DropdownMenuItem(
                  value: Locale('en'),
                  child: Text("englsih"),
                ),
                // ... other languages
                DropdownMenuItem(
                  value: Locale('fr'),
                  child: Text("Français"),
                ),
                DropdownMenuItem(
                  value: Locale('ar'),
                  child: Text("العربية"),
                ),
              ],
              onChanged: (locale) async {
                setState(() {
                  newLocale = locale;
                });
              },
            ),
            Center(
              child: Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
                  height: 50.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                      color: const Color(0xff00C8D5),
                      borderRadius: BorderRadius.circular(20.r)),
                  child: MaterialButton(
                      onPressed: () async {
                        if (newLocale == null ||
                            newLocale!.languageCode.isEmpty) {
                          final result = await setLanguageUseCase
                              .execute(currentLocale.languageCode);
                          if (result == "lanuage setting done") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyApp()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(text.try_again),
                                backgroundColor: Colors.red));
                          }
                        } else {
                          final result = await setLanguageUseCase
                              .execute(newLocale!.languageCode);
                          if (result == "lanuage setting done") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyApp()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(text.try_again),
                                backgroundColor: Colors.red));
                          }
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Text(
                          text.save,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontFamily: 'Nunito',
                              fontSize: 22.sp),
                        ),
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
