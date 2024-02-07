import 'package:bloc/bloc.dart';
import 'package:dawini_full/patient_features/domain/usecases/doctor_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'doctor_auth_event.dart';
part 'doctor_auth_state.dart';

class DoctorAuthBloc extends Bloc<DoctorAuthEvent, DoctorAuthState> {
  final DoctorAuthStateUseCase doctorAuthStateUseCase;
  DoctorAuthBloc(this.doctorAuthStateUseCase) : super(DoctorAuthInitial()) {
    on<DoctorAuthEvent>((event, emit) async {
      if (event is onSignIn) {
        emit(DoctorAuthLoading());
        final response =
            await doctorAuthStateUseCase.execute(event.email, event.password);
        response.fold((l) {
          emit(DoctorAuthFailed(error: l.message));

          emit(DoctorAuthInitial());
        }, (r) => emit(DoctorAuthSuccessful(doctorAuth: r)));
      }
    });
  }
}
