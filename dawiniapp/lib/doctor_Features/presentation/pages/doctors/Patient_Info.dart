// ignore_for_file: file_names, camel_case_types, use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/domain/entities/patient.dart';
import 'package:dawini_full/patient_features/presentation/bloc/patient_bloc/patients/patients_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Patient_info extends StatefulWidget {
  final DoctorEntity doctorEntity;
  final bool today;
  final bool ifADoctor;
  const Patient_info({
    Key? key,
    required this.doctorEntity,
    required this.today,
    this.ifADoctor = false,
  }) : super(key: key);

  @override
  State<Patient_info> createState() => _Patient_infoState();
}

class _Patient_infoState extends State<Patient_info> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String datetimeToday = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String datetimeTomrrow = DateFormat("yyyy-MM-dd")
      .format(DateTime.now().add(const Duration(days: 1)));
  DateTime? lastPressedTime;

  Widget buildInputField(List<TextInputFormatter>? textInputFormatter,
      {required TextEditingController controller,
      required String hintText,
      required TextInputType textInputType}) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        onEditingComplete: () {
          // Move focus to the next field when "Next" is pressed
          FocusScope.of(context).nextFocus();
        },
        inputFormatters: textInputFormatter,
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
    _genderController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadLastPressedTime(widget.doctorEntity.uid);
  }

  void loadLastPressedTime(uid) async {
    // Load from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lastPressedTime = prefs.getString("$uid/lastPressedTime") != null
        ? DateTime.parse(prefs.getString("$uid/lastPressedTime")!)
        : null;
  }

  void saveLastPressedTime(uid) async {
    // Save to shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("$uid/lastPressedTime", DateTime.now().toString());
  }

  bool canPressButton() {
    if (lastPressedTime == null) {
      return true;
    } else {
      final difference = DateTime.now().difference(lastPressedTime!);

      return widget.ifADoctor
          ? difference.inSeconds >= 5
          : difference.inSeconds >= 5; // Change 1 to your desired limit
    }
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
                      buildInputField(null,
                          controller: _firstNameController,
                          hintText: 'Your first name ',
                          textInputType: TextInputType.name),
                      buildInputField(null,
                          controller: _lastNameController,
                          hintText: 'Your family name ',
                          textInputType: TextInputType.name),
                      buildInputField(null,
                          controller: _ageController,
                          hintText: 'Your age',
                          textInputType: TextInputType.number),
                      buildInputField(null,
                          controller: _phoneNumberController,
                          hintText: 'Phone number ',
                          textInputType: TextInputType.number),
                      buildInputField(null,
                          controller: _addressController,
                          hintText: 'Home address',
                          textInputType: TextInputType.streetAddress),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    {
                      setState(() {
                        lastPressedTime = DateTime.now();
                      });
                      saveLastPressedTime(widget.doctorEntity.uid);
                      // Your button action here
                      String missing = "Please Write your";
                      if (_firstNameController.text.isEmpty) {
                        missing = "$missing First Name,";
                      }
                      if (_lastNameController.text.isEmpty) {
                        missing = "$missing Last Name,";
                      }
                      if (_ageController.text.isEmpty ||
                          int.parse(_ageController.text) > 130) {
                        missing = "$missing age,";
                      }
                      if (_phoneNumberController.text.isEmpty ||
                          _phoneNumberController.text.length < 10) {
                        missing = "$missing Phone Number,";
                      }
                      if (_addressController.text.isEmpty) {
                        missing = "$missing Home address,";
                      }
                      if (_firstNameController.text.isEmpty ||
                          _lastNameController.text.isEmpty ||
                          _phoneNumberController.text.length < 10 ||
                          int.parse(_ageController.text) > 130 ||
                          _ageController.text.isEmpty ||
                          _phoneNumberController.text.isEmpty ||
                          _addressController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(missing),
                          backgroundColor: Colors.red,
                        ));
                      } else {
                        final token = await _fcm.getToken();
                        PatientEntity patient = PatientEntity(
                            token: token.toString(),
                            gender: "_genderController.text",
                            AppointmentDate: widget.today
                                ? datetimeToday
                                : datetimeTomrrow, //////////////////////////////////
                            turn: 0,
                            age: _ageController.text,
                            address: _addressController.text,
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            phoneNumber: _phoneNumberController.text,
                            today: true,
                            DoctorName: widget.doctorEntity.lastName,
                            uid: widget.doctorEntity.uid);
                        dataBloc.add(onPatientsSetAppointments(
                            context, widget.ifADoctor,
                            patients: patient));
                      }
                    }

// Disable button if can't press
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
