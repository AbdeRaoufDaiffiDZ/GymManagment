import 'dart:async';

import 'package:admin/data/mongo_db.dart';
import 'package:admin/entities/user_data_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'rfid_plan_event.dart';
part 'rfid_plan_state.dart';

final MongoDatabase dataSource = MongoDatabase();
final collectionName = "Expense";

class Rfid_PlanBloc extends Bloc<Rfid_PlanEvent, Rfid_PlanState> {
  Rfid_PlanBloc() : super(IinitialState()) {
    on<Rfid_PlanEvent>((event, emit) async {
      if (event is UpdateUserEvent) {
        emit(LoadingState());
        final result = await dataSource.UpdateUserUsingRFID(id: event.id);
        if (result.isRight) {
          if (result.right[0] == 'try again') {
            emit(ErrorState(error: result.right[0]));
          } else {
            _showDialog(event.context, result.right[1]);
            emit(SuccessState(done: result.right[0], user: result.right[1]));
          }
        } else if (result.isLeft) {
          emit(ErrorState(error: result.left.message));
        }
      }
    });
  }
  Widget _tableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style:
            TextStyle(fontSize: 19, color: Color(0xff202020).withOpacity(0.8)),
      ),
    );
  }

  Widget _tableHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 17,
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, User_Data user) {
    bool isUnlimited = user.plan == 'unlimited';
    // Show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Return the Dialog widget here
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Table(
            columnWidths: {
              0: FixedColumnWidth(200),
              1: FixedColumnWidth(200),
              2: FixedColumnWidth(200),
              3: FixedColumnWidth(100),
              4: FixedColumnWidth(100),
              5: FixedColumnWidth(100),
              6: FixedColumnWidth(200),
              if (!isUnlimited) 7: FixedColumnWidth(200),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 243, 200, 169).withOpacity(0.4),
                ),
                children: [
                  _tableHeaderCell("Full Name"),
                  _tableHeaderCell("Phone Number"),
                  _tableHeaderCell('Plan'),
                  _tableHeaderCell('Tapis'),
                  _tableHeaderCell('Credit'),
                  _tableHeaderCell('Days Left'),
                  _tableHeaderCell('Strating Date'),
                  if (!isUnlimited) _tableHeaderCell("Sessions Left"),
                ],
              ),
              TableRow(
                decoration: BoxDecoration(
                  color: !isUnlimited
                      ? (user.sessionLeft <= 0 ||
                              user.endDate.difference(DateTime.now()).inDays <=
                                  0)
                          ? Colors.red.withOpacity(0.3)
                          : Color(0xffFAFAFA)
                      : user.daysLeft <= 3
                          ? Colors.red.withOpacity(0.3)
                          : Color(0xffFAFAFA),
                ),
                children: [

                  _tableCell(user.fullName),
                  _tableCell(user.phoneNumber),
                  _tableCell(user.plan),
                  _tableCell(user.tapis.toString()),

                  _tableCell(user.credit),

                  _tableCell(user.daysLeft.toString()),
                  _tableCell(user.startingDate.toString()),
                  if (!isUnlimited) _tableCell(user.sessionLeft.toString()),

                  // _tableCellActions(user),
                ],
              ),
            ],
          ),
        );
      },
    );

    // Automatically dismiss after 5 seconds
    Future.delayed(Duration(seconds: 5), () {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Future<void> close() async {
    await super.close();
  }
}
