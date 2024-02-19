import 'package:auto_size_text/auto_size_text.dart';
import 'package:dawini_full/patient_features/presentation/bloc/clinics_bloc/bloc/clinics_bloc.dart';
import 'package:dawini_full/doctor_Features/presentation/bloc/doctor_bloc/doctor_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchMenu extends StatefulWidget {
  const SearchMenu({
    super.key,
  });
  @override
  State<SearchMenu> createState() => _SearchMenuState();
}

class _SearchMenuState extends State<SearchMenu> {
  String? selectedValue;
  double _calculateFontSize(int textLength) {
    return 17.0 - (textLength * 0.8);
  }

  final items = [
    "Province",
    "Alger",
    "Boumerdes",
    "Oran",
    "chlef",
    "Bejaia",
    "Annaba",
    "Bouira"
  ];
  @override
  Widget build(BuildContext context) {
    final TextEditingController _textController = TextEditingController();
    final DoctorBloc dataBloc = BlocProvider.of<DoctorBloc>(context);
    // final ClinicsBloc clinicBloc = BlocProvider.of<ClinicsBloc>(context);

    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 12.w, left: 10.h),
              child: Container(
                height: 45.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0XFFECF2F2),
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 4.w),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        size: 24.w,
                        color: const Color(0xFF2CDBC6),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: TextField(
                            controller: _textController,
                            onChanged: (text) {
                              dataBloc
                                  .add(onDoctorsearchByName(doctorName: text));
                              // clinicBloc.add(onClinicsearchByName(clinicName: text));

                              ///
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search for a doctor',
                              hintStyle: TextStyle(
                                fontSize: _calculateFontSize(
                                    _textController.text.length),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 80.w,
                        height: 20.h,
                        child: Center(
                          child: AutoSizeText("Province",
                              style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
                items: items
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Container(
                            width: 90.w,
                            height: 20.h,
                            child: Center(
                              child: AutoSizeText(item,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white)),
                            ),
                          ),
                        ))
                    .toList(),
                value: selectedValue,
                onChanged: (wilaya) {
                  setState(() {
                    selectedValue = wilaya;
                  });
                  dataBloc.add(onDoctorsearchByWilaya(
                      wilaya: wilaya.toString().toLowerCase()));
                },
                buttonStyleData: ButtonStyleData(
                  height: 45.h,
                  width: 120.w,
                  padding: EdgeInsets.only(left: 14.w, right: 14.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF2CDBC6),
                    ),
                    color: const Color(0xFF2CDBC6),
                  ),
                  elevation: 1,
                ),
                iconStyleData: IconStyleData(
                  icon: const Icon(
                    Icons.arrow_downward_outlined,
                  ),
                  iconSize: 14.w,
                  iconEnabledColor: Colors.white,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.teal.shade100,
                  ),
                  offset: Offset(-10.w, 0.h),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(20),
                    thickness: MaterialStateProperty.all(8),
                    thumbVisibility: MaterialStateProperty.all(true),
                    interactive: true,
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                  padding: EdgeInsets.only(left: 12, right: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String dropdownValueClinics = "all";

class SearchMenuClinics extends StatefulWidget {
  const SearchMenuClinics({
    super.key,
  });
  @override
  State<SearchMenuClinics> createState() => _SearchMenuClinicsState();
}

class _SearchMenuClinicsState extends State<SearchMenuClinics> {
  String? selectedValue;

  final items = [
    "Province",
    "Alger",
    "Boumerdes",
    "Oran",
    "chlef",
    "Bejaia",
    "Annaba",
    "Bouira"
  ];
  @override
  Widget build(BuildContext context) {
    final TextEditingController _textController = TextEditingController();
    final ClinicsBloc ClinicsdataBloc = BlocProvider.of<ClinicsBloc>(context);
    // final ClinicsBloc clinicBloc = BlocProvider.of<ClinicsBloc>(context);

    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 15.w, left: 10.h),
              child: Container(
                height: 45.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade300,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        size: 26.w,
                        color: const Color(0xFF2CDBC6),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          onChanged: (text) {
                            ClinicsdataBloc.add(
                                onClinicsearchByName(clinicName: text));
                            // clinicBloc.add(onClinicsearchByName(clinicName: text));

                            ///
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search for a clinic',
                            hintStyle: TextStyle(fontSize: 13.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Province',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                items: items
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                value: selectedValue,
                onChanged: (wilaya) {
                  setState(() {
                    selectedValue = wilaya;
                  });
                  ClinicsdataBloc.add(onClinicsearchByWilaya(
                      wilaya: wilaya.toString().toLowerCase()));
                },
                buttonStyleData: ButtonStyleData(
                  height: 45.h,
                  width: 120.w,
                  padding: EdgeInsets.only(left: 14.w, right: 14.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF2CDBC6),
                    ),
                    color: const Color(0xFF2CDBC6),
                  ),
                  elevation: 1,
                ),
                iconStyleData: IconStyleData(
                  icon: const Icon(
                    Icons.arrow_downward_outlined,
                  ),
                  iconSize: 14.w,
                  iconEnabledColor: Colors.white,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.teal.shade100,
                  ),
                  offset: Offset(-10.w, 0.h),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: const Radius.circular(20),
                    thickness: MaterialStateProperty.all(8),
                    thumbVisibility: MaterialStateProperty.all(true),
                    interactive: true,
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                  padding: EdgeInsets.only(left: 12, right: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
