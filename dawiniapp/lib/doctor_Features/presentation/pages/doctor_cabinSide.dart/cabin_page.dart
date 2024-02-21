// ignore_for_file: camel_case_types

import 'package:dawini_full/core/loading/loading.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/usecases/doctor_usecase.dart';
import 'package:dawini_full/doctor_Features/presentation/bloc/doctor_bloc/doctor_bloc.dart';
import 'package:dawini_full/introduction_feature/domain/usecases/set_type_usecase.dart';
import 'package:dawini_full/patient_features/presentation/pages/weather_pag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  Widget _entryField(String title, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DoctorBloc doctorBloc = BlocProvider.of<DoctorBloc>(context);
    TextEditingController data = TextEditingController();
    return Scaffold(
        body: SafeArea(
      child: StreamBuilder<List<DoctorEntity>>(
          stream: GetDoctorsStreamInfoUseCase.excute(),
          builder: (context, snapshot) {
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
                      MaterialButton(
                          color: const Color.fromARGB(255, 109, 184, 245),
                          child: Text("update turn +"),
                          onPressed: () {
                            doctorBloc.add(onTurnUpdate(
                                doctor: doctor, turn: doctor.turn + 1));
                          }),
                      SizedBox(width: 200.w, child: _entryField("data", data)),
                      MaterialButton(
                          color: const Color.fromARGB(255, 109, 184, 245),
                          child: Text("update Info"),
                          onPressed: () {
                            if (data.text.isNotEmpty) {
                              doctorBloc.add(onDataUpdate(
                                  data: data.text,
                                  infoToUpdate: "description",
                                  numberInList: doctor.numberInList));
                            }
                          }),
                      MaterialButton(
                          color: const Color.fromARGB(255, 109, 184, 245),
                          child: Text("update turn -"),
                          onPressed: () {
                            doctorBloc.add(onTurnUpdate(
                                doctor: doctor, turn: doctor.turn - 1));
                          }),
                      MaterialButton(
                          color: !doctor.atSerivce
                              ? Color.fromARGB(255, 109, 184, 245)
                              : Colors.red,
                          child: Text("stateUpdate"),
                          onPressed: () {
                            doctorBloc.add(onStateUpdate(
                                doctor: doctor, state: !doctor.atSerivce));
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
                                  builder: (BuildContext context) => Weather(
                                    device: 'device',
                                    uid: widget.uid,
                                    popOrNot: true,
                                  ),
                                ));
                          }
                        },
                        child: Text("patients side"),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Loading();
          }),
    ));
  }
}
