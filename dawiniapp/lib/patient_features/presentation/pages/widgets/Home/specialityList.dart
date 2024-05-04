// ignore_for_file: file_names, sized_box_for_whitespace
import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/doctor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecialityList extends StatefulWidget {
  final int fontSize;

  const SpecialityList({super.key, required this.fontSize});

  @override
  State<SpecialityList> createState() => _SpecialityListState();
}

class _SpecialityListState extends State<SpecialityList> {
      String speciality = "";

  @override
  Widget build(BuildContext context) {
    final DoctorBloc dataBloc = BlocProvider.of<DoctorBloc>(context);
    final AppLocalizations text = AppLocalizations.of(context)!;
    final List<Map<String, String>> mylist = [
      {"text": text.all, "icon": "assets/images/xxxx.png"},
      {"text": text.generalist, "icon": "assets/images/xxxx.png"},
      {"text": text.dentist, "icon": "assets/images/Cardioo.png"},
      {"text": text.opthalm, "icon": "assets/images/dentiste.png"},
      {"text": text.endocrino, "icon": "assets/images/eyee.png"},
      {"text": text.cardiology, "icon": "assets/images/Group.png"},
    ];
    return Container(
      height: 85.h,
      child: ListView.builder(
        itemCount: mylist.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
            child: Column(
              children: [
                Container(
                  height: 45.h,
                  width: 45.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: mylist[index]["text"] as String == speciality
                          ? Color.fromARGB(0, 0, 242, 250).withOpacity(0.7)
                          : Color(0xffE6F5F3).withOpacity(0.7)),
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r)),
                    child: Image.asset(
                      mylist[index]["icon"] as String,
                      scale: 1.2,
                    ),
                    onTap: () {
                      setState(() {
                        speciality = mylist[index]["text"] as String;
                      });
                      dataBloc.add(onDoctorsearchByspeciality(
                          speciality:
                              (mylist[index]["text"] as String).toLowerCase()));
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    mylist[index]["text"] as String,
                    style: TextStyle(
                        color: Color(0xff202020).withOpacity(0.7),
                        fontWeight: FontWeight.w600,
                        fontSize: 14 - widget.fontSize.sp),
                  ),
                ),
              ],
            ),
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}