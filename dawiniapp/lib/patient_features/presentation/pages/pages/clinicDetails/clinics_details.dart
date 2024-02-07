import 'package:dawini_full/patient_features/domain/entities/clinic.dart';
import 'package:dawini_full/patient_features/domain/usecases/clinic_usecase.dart';
import 'package:flutter/material.dart';

class ClinicsDetails extends StatefulWidget {
  final String uid;
  const ClinicsDetails({super.key, required this.uid});

  @override
  State<ClinicsDetails> createState() => _ClinicsDetailsState();
}

class _ClinicsDetailsState extends State<ClinicsDetails> {
  @override
  Widget build(BuildContext context) {
    final uid = widget.uid;

    return StreamBuilder<List<ClinicEntity>>(
        stream: GetClinicsStreamInfoUseCase.excute(),
        builder: (context, snapshot) {
          late final List<ClinicEntity> data;
          if (snapshot.data == null) {
            data = [];
          } else {
            if (snapshot.data!.isEmpty) {
              data = [];
            } else {
              data = snapshot.data!;
            }
          }
          List<ClinicEntity> clinic =
              data.where((element) => element.uid == uid).toList();
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Column(
                  children: [
                    Text(clinic.isNotEmpty ? clinic.first.ClinicName : ""),
                    Text(clinic.isNotEmpty ? clinic.first.wilaya : ""),
                    Text(clinic.isNotEmpty
                        ? clinic.first.atSerivce.toString()
                        : ""),
                    Text(clinic.isNotEmpty ? clinic.first.speciality : ""),
                    Text(clinic.isNotEmpty ? clinic.first.phoneNumber : ""),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
