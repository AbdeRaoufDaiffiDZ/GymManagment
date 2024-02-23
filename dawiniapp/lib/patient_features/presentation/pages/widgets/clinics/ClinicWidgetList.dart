// ignore_for_file: file_names

import 'package:dawini_full/patient_features/domain/entities/clinic.dart';
import 'package:dawini_full/patient_features/presentation/pages/pages/clinicDetails/clinics_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClinicWidgetList extends StatefulWidget {
  final List<ClinicEntity> clinics;

  const ClinicWidgetList({super.key, required this.clinics});

  @override
  State<ClinicWidgetList> createState() => _ClinicWidgetListState();
}

class _ClinicWidgetListState extends State<ClinicWidgetList> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations text = AppLocalizations.of(context)!;

    List<ClinicEntity> data = widget.clinics;
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
              crossAxisSpacing: 1.w, // Spacing between columns
              mainAxisSpacing: 1.h, // Spacing between rows
              mainAxisExtent: 320),
          itemCount: data.length, // Number of items in the grid
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClinicsDetails(
                          uid: widget.clinics[index]
                              .uid)), ///////////////////////////////////////////
                );
              },
              child: Container(
                  margin: EdgeInsets.only(
                      left: 6.w, right: 6.w, top: 14.h, bottom: 14.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
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
                        color: Colors.grey.withOpacity(0.3),
                        height: 130.h,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Text(
                          data.isNotEmpty
                              ? "Clinic. ${data[index].ClinicName}"
                              : "",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w800),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Text(
                          data.isNotEmpty ? data[index].speciality : "",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 18.sp,
                              color: Colors.black45,
                            ),
                            SizedBox(width: 5.w),
                            SizedBox(
                              width: 120.w,
                              child: Text(
                                data.isNotEmpty
                                    ? "${data[index].city}, ${data[index].wilaya}"
                                    : "",
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.w),
                      Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Row(
                          children: [
                            Icon(Icons.circle,
                                size: 16.w,
                                color: data.isNotEmpty
                                    ? data[index].atSerivce
                                        ? Colors.teal
                                        : const Color.fromARGB(255, 150, 0, 0)
                                    : const Color.fromARGB(0, 150, 0, 0)),
                            SizedBox(width: 5.h),
                            Text(
                              data.isNotEmpty
                                  ? data[index].atSerivce
                                      ? text.at_service
                                      : text.not_at_service
                                  : "",
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w500),
                            ),
                          ],
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
