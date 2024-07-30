
part of 'unlimited_plan_bloc.dart';
@immutable
sealed class Unlimited_PlanEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class AddUserEvent extends Unlimited_PlanEvent {
  final User_Data user;

  AddUserEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

class GetUsersEvent extends Unlimited_PlanEvent {
  @override
  List<Object?> get props => [];
}
class DeleteUserEvent extends Unlimited_PlanEvent {
   final User_Data user;

  DeleteUserEvent({required this.user});

  @override
  List<Object?> get props => [user];
}

class UpdateUserEvent extends Unlimited_PlanEvent {
   final User_Data user;
    
  UpdateUserEvent({required this.user, });

  @override
  List<Object?> get props => [user,];
}