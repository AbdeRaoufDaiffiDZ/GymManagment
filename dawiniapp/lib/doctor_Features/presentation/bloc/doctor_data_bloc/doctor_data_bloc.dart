import 'package:bloc/bloc.dart';
import 'package:dawini_full/doctor_Features/data/data_source/doctor_cabin_data_source.dart';
import 'package:dawini_full/doctor_Features/domain/entities/doctor.dart';
import 'package:dawini_full/doctor_Features/domain/usecases/doctor_usecase.dart';
import 'package:equatable/equatable.dart';
part 'doctor_data_event.dart';
part 'doctor_data_state.dart';

class DoctorPatientsBloc
    extends Bloc<DoctorPatientsEvent, DoctorPatientsState> {
  final DoctorCabinDataSource doctorCabinDataSource =
      DoctorCabinDataSourceImp();
  final UpdateDoctorCabinData updateDoctorCabinData;

  DoctorPatientsBloc(
      this.updateDoctorCabinData, DoctorPatientsState initialState)
      : super(initialState) {
    on<DoctorPatientsEvent>((event, emit) async {
      if (event is LoadedDataDoctorPatinetsEvent) {
        try {
          final data = await doctorCabinDataSource.getDoctorsInfo();

          emit(doctorInfoLoaded(data));
        } catch (e) {
          emit(doctorInfoLoadingError(e.toString()));
        }
      } else if (event is onStateUpdate) {
        try {
          updateDoctorCabinData.updateState(
              event.doctor.numberInList, event.state);
          final data = await doctorCabinDataSource.getDoctorsInfo();

          emit(doctorInfoLoaded(data)); //         });
        } catch (e) {
          emit(doctorInfoLoadingError(e.toString()));
        }
      }
      // Stream<List<PatientModel>> doctorStream =
      //     doctorCabinDataSource.patinetsInfotest(uid);
    });
  }
}
// else if (event is onStateUpdate) {
//         final result = await updateDoctorCabinData.updateState(
//             event.doctor.numberInList, event.state);

//         result.fold((l) {
//           emit(DoctorLoadingFailure(message: l.message));
//         }, (r) async {
//           emit(DoctorLoaded());
//         });
//       } else if (event is onTurnUpdate) {
//         final result = await updateDoctorCabinData.updateTurn(
//             event.doctor.numberInList, event.turn);
//         result.fold((l) {
//           emit(DoctorLoadingFailure(message: l.message));
//         }, (r) async {
//           emit(DoctorLoaded());
//         });
//       } else if (event is onDataUpdate) {
//         final result = await updateDoctorCabinData.updatedoctorData(
//             event.numberInList, event.data, event.infoToUpdate);
//         result.fold((l) {
//           emit(DoctorLoadingFailure(message: l.message));
//         }, (r) async {
//           emit(DoctorLoaded());
//         });
//       }
