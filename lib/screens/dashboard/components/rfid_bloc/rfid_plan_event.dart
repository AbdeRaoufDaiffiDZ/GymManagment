part of 'rfid_plan_bloc.dart';

@immutable
sealed class Rfid_PlanEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateUserEvent extends Rfid_PlanEvent {
  final String id;
  final BuildContext context;
  UpdateUserEvent({required this.id, required this.context});

  @override
  List<Object?> get props => [id, context];
}

class InitialUserEvent extends Rfid_PlanEvent {}
