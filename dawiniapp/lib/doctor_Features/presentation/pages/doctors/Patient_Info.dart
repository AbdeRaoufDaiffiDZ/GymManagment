// ignore_for_file: camel_case_types, file_names

import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/patient_features/domain/entities/patient.dart';
import 'package:dawini_full/patient_features/presentation/bloc/patient_bloc/patients/patients_bloc.dart';
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
                  onTap: canPressButton()
                      ? () {
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
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
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
                                  DoctorName: widget.doctorEntity.lastName,
                                  uid: widget.doctorEntity.uid);
                              dataBloc.add(onPatientsSetAppointments(
                                  context, widget.ifADoctor,
                                  patients: patient));
                              showlDialog(context, true, widget.ifADoctor);
                            }
                          }

// Disable button if can't press
                        }
                      : () {
                          showlDialog(context, false, widget.ifADoctor);
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

  Future<Object?> showlDialog(context, bool text, bool ifADoctor) {
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
                title: Center(
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      text: text
                          ? "Your appointment has been booked"
                          : "Your appointment has not been booked",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w800,
                        fontSize: screenWidth * 0.05, // Responsive font size
                        color: const Color.fromRGBO(32, 32, 32, 0.8),
                      ),
                      children: [
                        TextSpan(
                          text: text
                              ? " successfully !"
                              : ", you already booked an appointment",
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w900,
                            fontSize:
                                screenWidth * 0.05, // Responsive font size
                            color: text ? const Color(0XFF0AA9A9) : Colors.red,
                          ),
                        ),
                        TextSpan(
                          text: text
                              ? " with the turn "
                              : ifADoctor
                                  ? ", try again after 5 sec "
                                  : ", try again after 10 minutes ",
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
                content: SizedBox(
                  height: screenHeight * 0.08,
                  child: GestureDetector(
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                        // TODO: afer booking appointmetn must navigate to my appointments page
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
                            fontSize:
                                screenWidth * 0.05, // Responsive font size
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
}
