// ignore_for_file: file_names

import 'package:dawini_full/core/error/ErrorWidget.dart';
import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/usecases/doctor_usecase.dart';
import 'package:dawini_full/doctor_Features/presentation/bloc/doctor_bloc/doctor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecialityList extends StatefulWidget {
  const SpecialityList({super.key});

  @override
  State<SpecialityList> createState() => _SpecialityListState();
}

class _SpecialityListState extends State<SpecialityList> {
  final List<Map<String, String>> mylist = [
    {"text": "ALL", "icon": "assets/images/generalist.png"},
    {"text": "Generalist", "icon": "assets/images/generalist.png"},
    {"text": "Dentist", "icon": "assets/images/dentist.png"},
    {"text": "Opthalm", "icon": "assets/images/opthalm.png"},
    {"text": "Endocrino", "icon": "assets/images/endocrino.png"},
    {"text": "Cardiology", "icon": "assets/images/cardiology.png"},
  ];
  @override
  Widget build(BuildContext context) {
    final DoctorBloc dataBloc = BlocProvider.of<DoctorBloc>(context);
    final GetDoctorsInfoUseCase getDoctorsInfoUseCase = GetDoctorsInfoUseCase();

    return StreamBuilder<List<DoctorEntity>>(
        stream: getDoctorsInfoUseCase.streamDoctorInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          }
          if (snapshot.hasError) {
            return ErrorPage(
              error: snapshot.error,
            );
            // Text('Error: ${snapshot.error}');
          }
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
          return SizedBox(
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
