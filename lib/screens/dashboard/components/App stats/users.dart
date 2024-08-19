import 'package:admin/screens/expense_list/expense_plan_bloc/bloc/expense_plan_bloc.dart';
import 'package:admin/screens/expense_list/expense_plan_bloc/bloc/expense_plan_bloc.dart'
    as Expense;
import 'package:admin/screens/plans/12sess/12session_bloc/bloc/12session_bloc.dart'
    as Session12;
import 'package:admin/screens/plans/12sess/12session_bloc/bloc/12session_bloc.dart';
import 'package:admin/screens/plans/12sess/12session_bloc/bloc/session_12_event.dart'
    as Event12;
import 'package:admin/screens/plans/16session/16session_bloc/bloc/16session_bloc.dart'
    as Session16;
import 'package:admin/screens/plans/16session/16session_bloc/bloc/16session_bloc.dart';
import 'package:admin/screens/plans/8session/8session_bloc/bloc/8session_bloc.dart'
    as Session8;
import 'package:admin/screens/plans/8session/8session_bloc/bloc/8session_bloc.dart';
import 'package:admin/screens/plans/8session/8session_bloc/bloc/session_8_event.dart'
    as Event8;
import 'package:admin/const/loading.dart';
import 'package:admin/screens/plans/unlimited/unlimited_plan_bloc/bloc/unlimited_plan_bloc.dart'
    as Unlimited;
import 'package:admin/screens/plans/unlimited/unlimited_plan_bloc/bloc/unlimited_plan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../plans/16session/16session_bloc/bloc/session_16_event.dart'
    as Event16;

List<int> totalCreadit = [];

class users extends StatelessWidget {
  const users({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Unlimited_PlanBloc _unlimited_bloc =
        BlocProvider.of<Unlimited_PlanBloc>(context);
    final Session_8_PlanBloc session_8_planBloc =
        BlocProvider.of<Session_8_PlanBloc>(context);
    final Session_16_PlanBloc session_16_planBloc =
        BlocProvider.of<Session_16_PlanBloc>(context);
    final Session_12_PlanBloc session_12_planBloc =
        BlocProvider.of<Session_12_PlanBloc>(context);
    final Expense_PlanBloc expense_planBloc =
        BlocProvider.of<Expense_PlanBloc>(context);
    int credit = 0;
    if (totalCreadit.isNotEmpty) {
      totalCreadit.forEach((element) {
        credit = credit + element;
      });
    }
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 50),
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0),
                child: Text(
                  "Memberships statistics :",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(0xff202020),
                      fontSize: 20),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.green,
                ),
                onPressed: () {
                  _unlimited_bloc.add(GetUsersEvent());
                  session_8_planBloc.add(Event8.GetUsersEvent());
                  session_12_planBloc.add(Event12.GetUsersEvent());
                  session_16_planBloc.add(Event16.GetUsersEvent());
                  expense_planBloc.add(Expense.GetExpensesEvent());
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0),
            child: Text(
              "Money Statistics :",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xff202020),
                  fontSize: 14),
            ),
          ),
          BlocBuilder<Expense_PlanBloc, Expense_PlanState>(
              builder: (context, state) {
            if (state is Expense.SuccessState) {
              int dayIncome = 0;
              final data = state.gymParam!.peopleIncome.where((element) =>
                  DateFormat('yyyy-MM-dd').format(element.dateTime) ==
                  DateFormat('yyyy-MM-dd').format(DateTime.now()));
              if (data.isNotEmpty) {
                dayIncome = data.first.dayIncome;
              } else {
                dayIncome = 0;
              }
              int expenses = 0;
              state.gymParam!.expenses
                  .where((element) =>
                      DateFormat('yyyy-MM-dd').format(element.dateTime) ==
                      DateFormat('yyyy-MM-dd').format(DateTime.now()))
                  .forEach((element) {
                expenses = element.expensePrice + expenses;
              });
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      userss(
                        pngg: "assets/images/qs.png",
                        text1: dayIncome.toString(),
                        text2: "Day Income",
                        clr: Color(0xffE544FF),
                      ),
                      userss(
                        pngg: "assets/images/expired.png",
                        text1: state.gymParam!.totalCredit.toString(),
                        text2: "Total Creadit",
                        clr: Color(0xffFF007A),
                      ),
                      userss(
                        pngg: "assets/images/aa.png",
                        text1: expenses.toString(),
                        text2: "total expenses",
                        clr: Color(0xff10BD9E),
                      ),
                    ],
                  ),
                  // SizedBox(height: 50),
                  // userss(
                  //   pngg: "assets/images/aa.png",
                  //   text1: nearToexpired.toString(),
                  //   text2: "Near to Expired",
                  //   clr: Color(0xff10BD9E),
                  // ),
                ],
              );
            } else if (state is Unlimited.IinitialState) {
              _unlimited_bloc.add(GetUsersEvent());
              return Loading();
            } else if (state is Unlimited.ErrorState) {
              return Loading();
            } else {
              return Loading();
            }
          }),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0),
            child: Text(
              "Unlimited Plan :",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xff202020),
                  fontSize: 14),
            ),
          ),
          ///////////////////////////////////////////////////////////////////////////
          BlocBuilder<Unlimited_PlanBloc, Unlimited_PlanState>(
              builder: (context, state) {
            if (state is Unlimited.SuccessState) {
              int planCredit = 0;
              int registred = state.users.length;
              state.users.forEach((element) {
                planCredit = planCredit + int.parse(element.credit);
              });
              if (!totalCreadit.contains(planCredit)) {
                totalCreadit.add(planCredit);
              }

              int expired = state.users
                  .where((user) =>
                      user.endDate.difference(user.startingDate).inDays <= 0)
                  .length;
              int nearToexpired = state.users
                  .where((user) =>
                      user.endDate.difference(user.startingDate).inDays > 0 &&
                      user.endDate.difference(user.startingDate).inDays < 5)
                  .length;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      userss(
                        pngg: "assets/images/qs.png",
                        text1: registred.toString(),
                        text2: "Registred",
                        clr: Color(0xffE544FF),
                      ),
                      userss(
                        pngg: "assets/images/expired.png",
                        text1: expired.toString(),
                        text2: "Expired",
                        clr: Color(0xffFF007A),
                      ),
                      userss(
                        pngg: "assets/images/aa.png",
                        text1: nearToexpired.toString(),
                        text2: "Near to Expired",
                        clr: Color(0xff10BD9E),
                      ),
                      userss(
                        pngg: "assets/images/aa.png",
                        text1: planCredit.toString(),
                        text2: "plan Credit",
                        clr: Color(0xff10BD9E),
                      ),
                    ],
                  ),
                  // SizedBox(height: 50),
                  // userss(
                  //   pngg: "assets/images/aa.png",
                  //   text1: nearToexpired.toString(),
                  //   text2: "Near to Expired",
                  //   clr: Color(0xff10BD9E),
                  // ),
                ],
              );
            } else if (state is Unlimited.IinitialState) {
              _unlimited_bloc.add(GetUsersEvent());
              return Loading();
            } else if (state is Unlimited.ErrorState) {
              return Loading();
            } else {
              return Loading();
            }
          }),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0),
            child: Text(
              "8 Sessions Plan :",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xff202020),
                  fontSize: 14),
            ),
          ),
          BlocBuilder<Session_8_PlanBloc, session_8_PlanState>(
              builder: (context, state) {
            if (state is Session8.SuccessState) {
              int registred = state.users.length;
              int planCredit = 0;
              state.users.forEach((element) {
                planCredit = planCredit + int.parse(element.credit);
              });
              if (!totalCreadit.contains(planCredit)) {
                totalCreadit.add(planCredit);
              }
              int expired = state.users
                      .where((user) =>
                          user.endDate.difference(user.startingDate).inDays <=
                          0)
                      .length +
                  state.users.where((user) => user.sessionLeft <= 0).length;
              int nearToexpired = state.users
                      .where((user) =>
                          user.endDate.difference(user.startingDate).inDays >
                              0 &&
                          user.endDate.difference(user.startingDate).inDays < 5)
                      .length +
                  state.users
                      .where((user) =>
                          user.sessionLeft > 0 && user.sessionLeft < 4)
                      .length;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      userss(
                        pngg: "assets/images/qs.png",
                        text1: registred.toString(),
                        text2: "Registred",
                        clr: Color(0xffE544FF),
                      ),
                      userss(
                        pngg: "assets/images/expired.png",
                        text1: expired.toString(),
                        text2: "Expired",
                        clr: Color(0xffFF007A),
                      ),
                      userss(
                        pngg: "assets/images/aa.png",
                        text1: nearToexpired.toString(),
                        text2: "Near to Expired",
                        clr: Color(0xff10BD9E),
                      ),
                      userss(
                        pngg: "assets/images/aa.png",
                        text1: planCredit.toString(),
                        text2: "plan Credit",
                        clr: Color(0xff10BD9E),
                      ),
                    ],
                  ),
                  // SizedBox(height: 50),
                  // userss(
                  //   pngg: "assets/images/aa.png",
                  //   text1: nearToexpired.toString(),
                  //   text2: "Near to Expired",
                  //   clr: Color(0xff10BD9E),
                  // ),
                ],
              );
            } else if (state is Session8.IinitialState) {
              _unlimited_bloc.add(GetUsersEvent());
              return Loading();
            } else if (state is Session8.ErrorState) {
              return Loading();
            } else {
              return Loading();
            }
          }),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0),
            child: Text(
              "12 Sessions Plan :",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xff202020),
                  fontSize: 14),
            ),
          ),
          BlocBuilder<Session_12_PlanBloc, session_12_PlanState>(
              builder: (context, state) {
            if (state is Session12.SuccessState) {
              int registred = state.users.length;
              int planCredit = 0;
              state.users.forEach((element) {
                planCredit = planCredit + int.parse(element.credit);
              });
              if (!totalCreadit.contains(planCredit)) {
                totalCreadit.add(planCredit);
              }
              int expired = state.users
                      .where((user) =>
                          user.endDate.difference(user.startingDate).inDays <=
                          0)
                      .length +
                  state.users.where((user) => user.sessionLeft <= 0).length;
              int nearToexpired = state.users
                      .where((user) =>
                          user.endDate.difference(user.startingDate).inDays >
                              0 &&
                          user.endDate.difference(user.startingDate).inDays < 5)
                      .length +
                  state.users
                      .where((user) =>
                          user.sessionLeft > 0 && user.sessionLeft < 4)
                      .length;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      userss(
                        pngg: "assets/images/qs.png",
                        text1: registred.toString(),
                        text2: "Registred",
                        clr: Color(0xffE544FF),
                      ),
                      userss(
                        pngg: "assets/images/expired.png",
                        text1: expired.toString(),
                        text2: "Expired",
                        clr: Color(0xffFF007A),
                      ),
                      userss(
                        pngg: "assets/images/aa.png",
                        text1: nearToexpired.toString(),
                        text2: "Near to Expired",
                        clr: Color(0xff10BD9E),
                      ),
                      userss(
                        pngg: "assets/images/aa.png",
                        text1: planCredit.toString(),
                        text2: "plan Credit",
                        clr: Color(0xff10BD9E),
                      ),
                    ],
                  ),
                  // SizedBox(height: 50),
                  // userss(
                  //   pngg: "assets/images/aa.png",
                  //   text1: nearToexpired.toString(),
                  //   text2: "Near to Expired",
                  //   clr: Color(0xff10BD9E),
                  // ),
                ],
              );
            } else if (state is Session12.IinitialState) {
              _unlimited_bloc.add(GetUsersEvent());
              return Loading();
            } else if (state is Session12.ErrorState) {
              return Loading();
            } else {
              return Loading();
            }
          }),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0),
            child: Text(
              "16 Sessions Plan :",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xff202020),
                  fontSize: 14),
            ),
          ),
          BlocBuilder<Session_16_PlanBloc, session_16_PlanState>(
              builder: (context, state) {
            if (state is Session16.SuccessState) {
              int registred = state.users.length;
              int planCredit = 0;
              state.users.forEach((element) {
                planCredit = planCredit + int.parse(element.credit);
              });
              if (!totalCreadit.contains(planCredit)) {
                totalCreadit.add(planCredit);
              }
              int expired = state.users
                      .where((user) =>
                          user.endDate.difference(user.startingDate).inDays <=
                          0)
                      .length +
                  state.users.where((user) => user.sessionLeft <= 0).length;
              int nearToexpired = state.users
                      .where((user) =>
                          user.endDate.difference(user.startingDate).inDays >
                              0 &&
                          user.endDate.difference(user.startingDate).inDays < 5)
                      .length +
                  state.users
                      .where((user) =>
                          user.sessionLeft > 0 && user.sessionLeft < 4)
                      .length;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      userss(
                        pngg: "assets/images/qs.png",
                        text1: registred.toString(),
                        text2: "Registred",
                        clr: Color(0xffE544FF),
                      ),
                      userss(
                        pngg: "assets/images/expired.png",
                        text1: expired.toString(),
                        text2: "Expired",
                        clr: Color(0xffFF007A),
                      ),
                      userss(
                        pngg: "assets/images/aa.png",
                        text1: nearToexpired.toString(),
                        text2: "Near to Expired",
                        clr: Color(0xff10BD9E),
                      ),
                      userss(
                        pngg: "assets/images/aa.png",
                        text1: planCredit.toString(),
                        text2: "plan Credit",
                        clr: Color(0xff10BD9E),
                      ),
                    ],
                  ),
                  // SizedBox(height: 50),
                  // userss(
                  //   pngg: "assets/images/aa.png",
                  //   text1: nearToexpired.toString(),
                  //   text2: "Near to Expired",
                  //   clr: Color(0xff10BD9E),
                  // ),
                ],
              );
            } else if (state is Session16.IinitialState) {
              _unlimited_bloc.add(GetUsersEvent());
              return Loading();
            } else if (state is Session16.ErrorState) {
              return Loading();
            } else {
              return Loading();
            }
          }),
        ]),
      ),
    );
  }
}

class userss extends StatelessWidget {
  final String pngg;
  final String text1;
  final String text2;
  final Color clr;
  const userss(
      {Key? key,
      required this.pngg,
      required this.text1,
      required this.text2,
      required this.clr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 250,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Color(0xffE6E6E6), spreadRadius: 1.5, blurRadius: 0.5)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text1,
            style: TextStyle(
              color: clr,
              fontSize: 28,
            ),
          ),
          Container(
            height: 57,
            width: 57,
            child: Image.asset(
              pngg,
              //height: 27,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 1),
          Text(
            text2,
            style: TextStyle(
                color: Color(0XFF202020),
                fontSize: 15,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
