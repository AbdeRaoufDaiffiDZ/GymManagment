
part of 'unlimited_plan_bloc.dart';
@immutable
sealed class Unlimited_PlanEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class AddUserEvent extends Unlimited_PlanEvent {
  final User_Data user;
  final BuildContext context;
  AddUserEvent({required this.context,required this.user});

  @override
  List<Object?> get props => [user, context];
}

class GetUsersEvent extends Unlimited_PlanEvent {
  final BuildContext context;
  GetUsersEvent({required this.context});
  @override
  List<Object?> get props => [context];
}
class DeleteUserEvent extends Unlimited_PlanEvent {
   final User_Data user;
final BuildContext context;
  DeleteUserEvent({required this.context,required this.user});

  @override
  List<Object?> get props => [user, context];
}

class UpdateUserEvent extends Unlimited_PlanEvent {
   final User_Data user;
   final BuildContext context;
  UpdateUserEvent({required this.context, required this.user, });

  @override
  List<Object?> get props => [user,];
}