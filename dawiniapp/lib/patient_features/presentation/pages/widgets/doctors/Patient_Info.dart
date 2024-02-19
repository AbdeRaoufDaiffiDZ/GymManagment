// ignore_for_file: prefer_final_fields, camel_case_types

import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/domain/entities/patient.dart';
import 'package:dawini_full/patient_features/presentation/bloc/patient_bloc/patients/patients_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class Patient_info extends StatefulWidget {
  final DoctorEntity doctorEntity;
  final bool today;
  const Patient_info({
    Key? key,
    required this.doctorEntity,
    required this.today,
  }) : super(key: key);

  @override
  State<Patient_info> createState() => _Patient_infoState();
}

class _Patient_infoState extends State<Patient_info> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String datetimeToday = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String datetimeTomrrow =
      DateFormat("yyyy-MM-dd").format(DateTime.now().add(Duration(days: 1)));

  Widget buildInputField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0XFFECF2F2),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16.r),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: const Color(0XFF202020).withOpacity(0.7),
            fontFamily: "Nunito",
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final PatientsBloc dataBloc = BlocProvider.of<PatientsBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.04, top: screenHeight * 0.03),
                  child: Container(
                    height: screenWidth * 0.11,
                    width: screenWidth * 0.11,
                    decoration: BoxDecoration(
                      color: const Color(0XFFECF2F2),
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    child: Center(
                      child: IconButton(
                        iconSize: screenWidth * 0.06,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color(0XFF0AA9A9),
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.015),
                  width: double.infinity,
                  height: screenHeight * 0.035,
                  child: Center(
                    child: AutoSizeText(
                      "Please enter the following information :",
                      style: TextStyle(
                        fontSize: screenHeight * 0.045,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF202020),
                      ),
                    ),
                  ),
                ),
                Container(
                  key: _formKey,
                  height: screenHeight * 0.55,
                  margin: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.025), // Adjust margin
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // Use spaceBetween
                    children: [
                      buildInputField(
                        controller: _firstNameController,
                        hintText: 'Your first name ',
                      ),
                      buildInputField(
                        controller: _firstNameController,
                        hintText: 'Your family name ',
                      ),
                      buildInputField(
                        controller: _firstNameController,
                        hintText: 'Your age',
                      ),
                      buildInputField(
                        controller: _firstNameController,
                        hintText: 'Phone number ',
                      ),
                      buildInputField(
                        controller: _firstNameController,
                        hintText: 'Home address',
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    String missing = "Please Write your";
                    _lastNameController = _ageController =
                        _phoneNumberController =
                            _addressController = _firstNameController;
                    if (_firstNameController.text.isEmpty) {
                      missing = missing + " First Name,";
                    }
                    if (_lastNameController.text.isEmpty) {
                      missing = missing + " Last Name,";
                    }
                    if (_ageController.text.isEmpty) {
                      missing = missing + " age,";
                    }
                    if (_phoneNumberController.text.isEmpty) {
                      missing = missing + " Phone Number,";
                    }
                    if (_addressController.text.isEmpty) {
                      missing = missing + " Home address,";
                    }
                    if (_firstNameController.text.isEmpty ||
                        _lastNameController.text.isEmpty ||
                        _ageController.text.isEmpty ||
                        _phoneNumberController.text.isEmpty ||
                        _addressController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(missing),
                        backgroundColor: Colors.red,
                      ));
                    } else {
                      PatientEntity patient = PatientEntity(
                          AppointmentDate: widget.today
                              ? datetimeToday
                              : datetimeTomrrow, //////////////////////////////////
                          turn: 0,
                          doctorRemark: "doctorRemark",
                          address: "address",
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          phoneNumber: _phoneNumberController.text,
                          today: true,
                          DoctorName: 'dr.' +
                              widget.doctorEntity.lastName +
                              widget.doctorEntity.firstName,
                          uid: widget.doctorEntity.uid);
                      dataBloc.add(onPatientsSetAppointments(context,
                          patients: patient));
                      showlDialog(context);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.04,
                        horizontal: screenWidth * 0.08),
                    child: Container(
                      height: screenHeight * 0.07,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0XFF04CBCB),
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      ),
                      child: const Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Confirm appointment",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<Object?> showlDialog(context) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Container();
    },
    transitionBuilder: (context, a1, a2, widget) {
      double screenWidth = MediaQuery.of(context).size.width;
      double screenHeight = MediaQuery.of(context).size.height;

      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: ScaleTransition(
          scale: Tween(begin: 0.5, end: 1.0).animate(a1),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.4, end: 1).animate(a1),
            child: AlertDialog(
              title: Container(
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Your appointment has been booked",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w800,
                        fontSize: screenWidth * 0.05, // Responsive font size
                        color: const Color.fromRGBO(32, 32, 32, 0.8),
                      ),
                      children: [
                        TextSpan(
                          text: " successfully",
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w900,
                            fontSize:
                                screenWidth * 0.05, // Responsive font size
                            color: const Color(0XFF0AA9A9),
                          ),
                        ),
                        TextSpan(
                          text:
                              " , you can follow your turn at my appointment section ",
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w800,
                            fontSize:
                                screenWidth * 0.05, // Responsive font size
                            color: const Color.fromRGBO(32, 32, 32, 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              content: Container(
                height: screenHeight * 0.08,
                child: GestureDetector(
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    height: screenHeight * 0.045,
                    decoration: BoxDecoration(
                      color: const Color(0XFF04CBCB),
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                    ),
                    child: Center(
                      child: Text(
                        "My appointment",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Nunito",
                          fontSize: screenWidth * 0.05, // Responsive font size
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.025),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      );
    },
  );
}
