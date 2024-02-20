import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/usecases/doctor_usecase.dart';
import 'package:dawini_full/doctor_Features/presentation/bloc/doctor_bloc/Condtions/doctor_state_conditions.dart';
import 'package:dawini_full/doctor_Features/presentation/bloc/doctor_bloc/doctor_bloc.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctors/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorsList extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final device;
  const DoctorsList({super.key, this.device});

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DoctorEntity>>(
        stream: GetDoctorsStreamInfoUseCase.excute(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Loading();
          }
          {
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
            return BlocBuilder<DoctorBloc, DoctorState>(
                builder: (context, state) {
              return DoctorStateConditions(state, data, device: widget.device);
            });
          }
        });
  }
}

class Doctors extends StatefulWidget {
  final device;
  final List<DoctorEntity> doctors;

  const Doctors({super.key, required this.doctors, this.device});

  @override
  State<Doctors> createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations text = AppLocalizations.of(context)!;

    List<DoctorEntity> data = widget.doctors;
    if (data.isEmpty) {
      return Container();
    } else {
      return GestureDetector(
        onTap: () {},
        child: Container(
          margin:
              const EdgeInsets.only(top: 1), // Adjust the top margin as needed
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 2.w, // Spacing between columns
                mainAxisExtent: 220.h),
            itemCount: data.length, // Number of items in the grid
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => doctorDetails(
                            uid: widget.doctors[index].uid,
                            device: widget.device)),
                  );
                },
                child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 7.h, horizontal: 7.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey, // Set the border color
                        width: 1.w, // Set the border width
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8),
                          color: const Color.fromARGB(31, 204, 204, 204)
                              .withOpacity(0.3),
                          height: 100.h,
                          width: double.infinity,
                          child: Image.asset(
                            "assets/images/maleDoctor.png",
                            fit: BoxFit.scaleDown,
                            scale: 1.5.w,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 4.w),
                          width: double.infinity,
                          height: 20.h,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.topLeft,
                            child: Text("Dr.${data[index].lastName}",
                                style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0XFF202020))),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 4.w),
                          width: double.infinity,
                          height: 20.h,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.topLeft,
                            child: Text(data[index].speciality,
                                style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0XFF000000))),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 2.w),
                          width: double.infinity,
                          height: 20.h,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16.sp,
                                  color: Colors.black45,
                                ),
                                Text(
                                    "${data[index].city},${data[index].wilaya}",
                                    style: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0XFF202020)
                                            .withOpacity(0.75))),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 3.w),
                          width: double.infinity,
                          height: 20.h,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              children: [
                                Icon(Icons.circle,
                                    size: 12.sp,
                                    color: data[index].atSerivce
                                        ? Colors.teal
                                        : Colors.red),
                                SizedBox(width: 4.w),
                                Text(
                                    data[index].atSerivce
                                        ? text.at_service
                                        : text.not_at_service,
                                    style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0XFF202020))),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              );
            },
          ),
        ),
      );
    }
  }
}
