// ignore_for_file: sort_child_properties_last

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/patient_features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/domain/usecases/doctor_usecase.dart';
import 'package:dawini_full/patient_features/presentation/bloc/patient_bloc/patients/patients_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentsWidget extends StatefulWidget {
  const AppointmentsWidget({super.key});

  @override
  State<AppointmentsWidget> createState() => _AppointmentsWidgetState();
}

class _AppointmentsWidgetState extends State<AppointmentsWidget> {
  @override
  Widget build(BuildContext context) {
    final PatientsBloc patientsBloc = BlocProvider.of<PatientsBloc>(context);

    return BlocBuilder<PatientsBloc, PatientsState>(builder: (context, state) {
      if (state is PatientsLoading) {
        return Loading();
      } else if (state is PatientsLoaded) {
        return ListView.builder(
          itemCount: state.patients.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(
                  left: 6.w, right: 6.w, top: 14.h, bottom: 14.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(
                  color: Color.fromARGB(
                      255, 212, 212, 212), // Set the border color
                  width: 2.w, // Set the border width
                ),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Text(
                          "Dr. " + state.patients[index].DoctorName,
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w800),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Text(
                          state.patients[index].firstName +
                              " " +
                              state.patients[index].lastName,
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w800),
                        ),
                      ),
                      Container(
                        height: 40.h,
                        width: 200.w,
                        margin: EdgeInsets.only(
                            left: 6.w, right: 6.w, top: 15.h, bottom: 14.h),
                        child: MaterialButton(
                          elevation: 0,
                          onLongPress: () {
                            patientsBloc.add(onPatientsAppointmentDelete(
                                context,
                                patients: state.patients[index]));
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Color.fromARGB(54, 177, 177, 177),
                          onPressed: () {},
                          child: Center(
                            child: Text(
                              state.patients[index].today
                                  ? "cancel appointment "
                                  : "Delete",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 50.w,
                  ),
                  state.patients[index].today
                      ? turnSHower(state, index)
                      : Container()
                ],
              ),
            );
          },
        );
      } else if (state is PatientsLoadingError) {
        return Loading();
      } else {
        return Loading();
      }
    });
  }

  NotificationShower(String patientName, int index, String doctorName, body) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: index,
            channelKey: 'basic_channel',
            title: "your turn ${body}",
            body: "${patientName} turn at ${doctorName} ${body}"));
  }

  notificationConditions(state, index, doctors) {
    if (state.patients[index].turn - 2 == (doctors.first.turn)) {
      NotificationShower(
          state.patients[index].firstName +
              " " +
              state.patients[index].lastName,
          index,
          "Dr. " + doctors.first.lastName,
          "is near");
    } else if (state.patients[index].turn - 1 == (doctors.first.turn)) {
      NotificationShower(
          state.patients[index].firstName +
              " " +
              state.patients[index].lastName,
          index,
          "Dr. " + doctors.first.lastName,
          "is after one Patient");
    } else if (state.patients[index].turn == (doctors.first.turn)) {
      NotificationShower(
          state.patients[index].firstName +
              " " +
              state.patients[index].lastName,
          index,
          "Dr. " + doctors.first.lastName,
          "is NOW");
    }
  }

  Widget turnSHower(state, index) {
    return Column(
      children: [
        Container(
          child: StreamBuilder<List<DoctorEntity>>(
              stream: GetDoctorsStreamInfoUseCase.excute(),
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
                List<DoctorEntity> doctors = data
                    .where(
                        (element) => element.uid == state.patients[index].uid)
                    .toList();
                if (!doctors.isEmpty) {
                  if (state.patients[index].today) {
                    notificationConditions(state, index, doctors);
                  }
                }
                return Center(
                    child: Text(
                  !doctors.isEmpty ? doctors.first.turn.toString() : "",
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ));
              }),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color.fromARGB(38, 158, 158, 158),
            border: Border.all(
              color: Color.fromARGB(0, 158, 158, 158), // Set the border color
              width: 3.w, // Set the border width
            ),
          ),
          width: 70.w,
          height: 60.h,
        ),
        Text("your turn\n is at: ${state.patients[index].turn} ")
      ],
    );
  }
}
