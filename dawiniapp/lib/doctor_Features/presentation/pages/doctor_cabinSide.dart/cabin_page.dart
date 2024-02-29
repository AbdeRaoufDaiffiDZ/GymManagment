// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'package:dawini_full/core/error/ErrorWidget.dart';
import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/usecases/doctor_usecase.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctor_cabinSide.dart/swlhdoctor.dart/doctorview.dart';
import 'package:dawini_full/doctor_Features/presentation/pages/doctors/Patient_Info.dart';
import 'package:dawini_full/introduction_feature/domain/usecases/set_type_usecase.dart';
import 'package:dawini_full/patient_features/presentation/pages/weather_pag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DoctorCabinInfo extends StatefulWidget {
  final String uid;
  final bool popOrNot;

  const DoctorCabinInfo({super.key, required this.uid, required this.popOrNot});

  @override
  State<DoctorCabinInfo> createState() => _DoctorCabinInfoState();
}

class _DoctorCabinInfoState extends State<DoctorCabinInfo>
    with TickerProviderStateMixin {
  String datetime = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
  final SetTypeUseCase setTypeUseCase = SetTypeUseCase();
  // Widget _entryField(String title, TextEditingController controller,
  //     {bool isPassword = false}) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(vertical: 10),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Text(
  //           title,
  //           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
  //         ),
  //         const SizedBox(
  //           height: 10,
  //         ),
  //         TextField(
  //             controller: controller,
  //             obscureText: isPassword,
  //             decoration: const InputDecoration(
  //                 border: InputBorder.none,
  //                 fillColor: Color(0xfff3f3f4),
  //                 filled: true))
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // final DoctorBloc doctorBloc = BlocProvider.of<DoctorBloc>(context);
    final GetDoctorsInfoUseCase getDoctorsInfoUseCase = GetDoctorsInfoUseCase();
    // TextEditingController data = TextEditingController();
    return Scaffold(
        body: SafeArea(
      child: StreamBuilder<List<DoctorEntity>>(
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
            if (snapshot.hasData) {
              DoctorEntity doctor = snapshot.requireData
                  .where((element) => element.uid == widget.uid)
                  .toList()
                  .first;

              return Center(
                child: SafeArea(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(doctor.uid.toString()),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(doctor.description.toString()),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(doctor.lastName.toString()),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(doctor.speciality.toString()),
                      // MaterialButton(
                      //     color: const Color.fromARGB(255, 109, 184, 245),
                      //     child: const Text("update turn +"),
                      //     onPressed: () {
                      //       doctorBloc.add(onTurnUpdate(
                      //           doctor: doctor, turn: doctor.turn + 1));
                      //     }),
                      // SizedBox(width: 200.w, child: _entryField("data", data)),
                      // MaterialButton(
                      //     color: const Color.fromARGB(255, 109, 184, 245),
                      //     child: const Text("update Info"),
                      //     onPressed: () {
                      //       if (data.text.isNotEmpty) {
                      //         doctorBloc.add(onDataUpdate(
                      //             data: data.text,
                      //             infoToUpdate: "description",
                      //             numberInList: doctor.numberInList));
                      //       }
                      //     }),
                      // MaterialButton(
                      //     color: const Color.fromARGB(255, 109, 184, 245),
                      //     child: const Text("update turn -"),
                      //     onPressed: () {
                      //       doctorBloc.add(onTurnUpdate(
                      //           doctor: doctor, turn: doctor.turn - 1));
                      //     }),
                      // MaterialButton(
                      //     color: doctor.atSerivce
                      //         ? const Color.fromARGB(255, 109, 184, 245)
                      //         : Colors.red,
                      //     child: const Text("stateUpdate"),
                      //     onPressed: () {
                      //       doctorBloc.add(onStateUpdate(
                      //           doctor: doctor, state: !doctor.atSerivce));
                      //     }),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     MaterialButton(
                      //         color: const Color.fromARGB(255, 109, 184, 245),
                      //         child: const Text("today"),
                      //         onPressed: () {
                      //           doctorBloc.add(onDataUpdate(
                      //               data: "today",
                      //               infoToUpdate: "date",
                      //               numberInList: doctor.numberInList));
                      //         }),
                      //     SizedBox(
                      //       width: 10.w,
                      //     ),
                      //     // MaterialButton(
                      //     //     color: const Color.fromARGB(255, 109, 184, 245),
                      //     //     child: const Text("all day"),
                      //     //     onPressed: () {
                      //     //       doctorBloc.add(onDataUpdate(
                      //     //           data: "all",
                      //     //           infoToUpdate: "date",
                      //     //           numberInList: doctor.numberInList));
                      //         }),
                      //     SizedBox(
                      //       width: 10.w,
                      //     ),
                      //     MaterialButton(
                      //         color: const Color.fromARGB(255, 109, 184, 245),
                      //         child: const Text("tomorrow"),
                      //         onPressed: () {
                      //           doctorBloc.add(onDataUpdate(
                      //               data: "tomorrow",
                      //               infoToUpdate: "date",
                      //               numberInList: doctor.numberInList));
                      //         }),
                      //   ],
                      // ),
                      MaterialButton(
                          color: const Color.fromARGB(255, 109, 184, 245),
                          child: const Text("SWLH tbib"),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      // testDoctorsCabinData(uid: widget.uid)
                                      doctorview(
                                    uid: widget.uid,
                                    popOrNot: widget
                                        .popOrNot, // TODO: do not forget to remove the comments
                                  ),
                                ));
                          }),
                      MaterialButton(
                        color: const Color.fromARGB(255, 109, 184, 245),
                        onPressed: () async {
                          await setTypeUseCase.execute("patient");
                          // final routeName = ModalRoute.of(context)!.settings.name;
                          // print("Current route name: $routeName");
                          if (widget.popOrNot) {
                            Navigator.pop(context);
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Weather(
                                    device: 'device',
                                    popOrNot: true,
                                  ),
                                ));
                          }
                        },
                        child: const Text("patients side"),
                      ),
                      MaterialButton(
                        color: const Color.fromARGB(255, 109, 184, 245),
                        onPressed: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Patient_info(
                                        doctorEntity: doctor,
                                        today: true,
                                        ifADoctor: true,
                                      )));
                        },
                        child: const Text("add patient"),
                      ),
                      // MaterialButton(
                      //     color: const Color.fromARGB(255, 109, 184, 245),
                      //     child: const Text("recommended"),
                      //     onPressed: () {
                      //       doctorBloc.add(onDataUpdate(
                      //           data: 1,
                      //           infoToUpdate: "recommendNumber",
                      //           numberInList: doctor.numberInList));
                      //     }),
                    ],
                  ),
                ),
              );
            }
            return const Loading();
          }),
    ));
  }
}
