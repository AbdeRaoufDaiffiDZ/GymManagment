// ignore_for_file: camel_case_types

part of 'clinics_bloc.dart';

sealed class ClinicsEvent extends Equatable {
  const ClinicsEvent();

  @override
  List<Object> get props => [];
}

class onClinicChoose extends ClinicsEvent {
  final ClinicEntity clinics;

  const onClinicChoose({required this.clinics});

  @override
  List<Object> get props => [clinics];
}

class ClinicInfoUpdated extends ClinicsEvent {
  final List<ClinicEntity> clinics;

  const ClinicInfoUpdated({required this.clinics});

  @override
  List<Object> get props => [clinics];
}

class onClinicsearchByName extends ClinicsEvent {
  final String clinicName;

  const onClinicsearchByName({required this.clinicName});

  @override
  List<Object> get props => [clinicName];
}

final class onSeeAllClinics extends ClinicsEvent {}

class onClinicsearchByWilaya extends ClinicsEvent {
  final String wilaya;

  const onClinicsearchByWilaya({required this.wilaya});

  @override
  List<Object> get props => [wilaya];
}

class ClinicinitialEvent extends ClinicsEvent {}
