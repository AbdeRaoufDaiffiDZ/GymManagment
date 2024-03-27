// ignore_for_file: file_names, sized_box_for_whitespace

import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/usecases/doctor_usecase.dart';
import 'package:dawini_full/patient_features/presentation/bloc/doctor_bloc/doctor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SpecialityList extends StatefulWidget {
  const SpecialityList({super.key});

  @override
  State<SpecialityList> createState() => _SpecialityListState();
}

class _SpecialityListState extends State<SpecialityList> {
  @override
  Widget build(BuildContext context) {
    final DoctorBloc dataBloc = BlocProvider.of<DoctorBloc>(context);
    final GetDoctorsInfoUseCase getDoctorsInfoUseCase = GetDoctorsInfoUseCase();
    final AppLocalizations text = AppLocalizations.of(context)!;

    final List<Map<String, String>> mylist = [
      {"text": text.all, "icon": "assets/images/generalist.png"},
      {"text": text.generalist, "icon": "assets/images/generalist.png"},
      {"text": text.dentist, "icon": "assets/images/dentist.png"},
      {"text": text.opthalm, "icon": "assets/images/opthalm.png"},
      {"text": text.endocrino, "icon": "assets/images/endocrino.png"},
      {"text": text.cardiology, "icon": "assets/images/cardiology.png"},
    ];
    return StreamBuilder<List<DoctorEntity>>(
        stream: getDoctorsInfoUseCase.streamDoctorInfo(),
        builder: (context, snapshot) {
          late final List<DoctorEntity> data;
          if (snapshot.data == null) {
            data = [];
          } else {
            if (snapshot.data!.isEmpty) {
              data = [];
            } else {
              data = snapshot.data!;
            }
          }
          return Container(
            height: 100.h,
            child: ListView.builder(
              itemCount: mylist.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
                  child: Column(
                    children: [
                      Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                        ),
                        child: GestureDetector(
                          child: Image.asset(mylist[index]["icon"] as String),
                          onTap: () {
                            dataBloc.add(onDoctorsearchByspeciality(
                                doctors: data,
                                speciality: (mylist[index]["text"] as String)
                                    .toLowerCase()));
                          },
                        ),
                      ),
                      Text(
                        mylist[index]["text"] as String,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
            ),
          );
        });
  }
}
