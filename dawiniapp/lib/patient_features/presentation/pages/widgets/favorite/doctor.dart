import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/usecases/doctor_usecase.dart';
import 'package:dawini_full/patient_features/domain/usecases/patients_usecase.dart';
import 'package:dawini_full/patient_features/presentation/pages/widgets/doctors/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class myfavdoctors extends StatefulWidget {
  myfavdoctors({
    Key? key,
  }) : super(key: key);

  @override
  State<myfavdoctors> createState() => _favoriteState();
}

class _favoriteState extends State<myfavdoctors> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // final PatientsBloc patientsBloc = BlocProvider.of<PatientsBloc>(context);
    AppLocalizations text = AppLocalizations.of(context)!;

    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
            child: FutureBuilder(
                future: GetFavoriteDoctorsUseCase.excute(),
                builder: (context, uids) {
                  return StreamBuilder<List<DoctorEntity>>(
                      stream: GetDoctorsStreamInfoUseCase.excute(),
                      builder: (context, snapshot) {
                        // final uids =
                        List<DoctorEntity> doctor = [];
                        if (snapshot.data == null) {
                          doctor = [];
                          return const Loading();
                        } else {
                          if (snapshot.data!.isEmpty) {
                            doctor = [];
                            return const Loading();
                          } else {
                            for (var uid in uids.data!) {
                              snapshot.data!.forEach((element) {
                                if (element.uid == uid) {
                                  doctor.add(element);
                                }
                              });
                            }

                            if (doctor.isEmpty) {
                              doctor = [];
                              return Container();
                            } else {
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 8
                                          .h), // Adjust the top margin as needed
                                  child: ListView(
                                    children: [
                                      GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount:
                                                    2, // Number of columns in the grid
                                                crossAxisSpacing: 2
                                                    .w, // Spacing between columns
                                                mainAxisExtent: 220.h),
                                        itemCount: doctor
                                            .length, // Number of items in the grid
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        doctorDetails(
                                                            uid: doctor[index]
                                                                .uid)),
                                              );
                                            },
                                            child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 7.h,
                                                    horizontal: 7.w),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  border: Border.all(
                                                    color: Colors
                                                        .grey, // Set the border color
                                                    width: 1
                                                        .w, // Set the border width
                                                  ),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              8),
                                                      color:
                                                          const Color.fromARGB(
                                                                  31,
                                                                  204,
                                                                  204,
                                                                  204)
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
                                                      margin: EdgeInsets.only(
                                                          left: 4.w),
                                                      width: double.infinity,
                                                      height: 20.h,
                                                      child: FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                            "Dr.${doctor[index].lastName}",
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'Nunito',
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0XFF202020))),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 4.w),
                                                      width: double.infinity,
                                                      height: 20.h,
                                                      child: FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                            doctor[index]
                                                                .speciality,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'Nunito',
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0XFF000000))),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 2.w),
                                                      width: double.infinity,
                                                      height: 20.h,
                                                      child: FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.location_on,
                                                              size: 16.sp,
                                                              color: Colors
                                                                  .black45,
                                                            ),
                                                            Text(
                                                                "${doctor[index].city},${doctor[index].wilaya}",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: const Color(
                                                                            0XFF202020)
                                                                        .withOpacity(
                                                                            0.75))),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 3.w),
                                                      width: double.infinity,
                                                      height: 20.h,
                                                      child: FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        alignment: Alignment
                                                            .bottomLeft,
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.circle,
                                                                size: 12.sp,
                                                                color: doctor[
                                                                            index]
                                                                        .atSerivce
                                                                    ? Colors
                                                                        .teal
                                                                    : Colors
                                                                        .red),
                                                            SizedBox(
                                                                width: 4.w),
                                                            Text(
                                                                doctor[index]
                                                                        .atSerivce
                                                                    ? text
                                                                        .at_service
                                                                    : text
                                                                        .not_at_service,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color(
                                                                        0XFF202020))),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          }
                        }
                      });
                })));
  }
}
