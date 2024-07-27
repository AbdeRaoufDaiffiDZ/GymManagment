import 'package:admin/const/loading.dart';
import 'package:admin/unlimited_plan_bloc/bloc/unlimited_plan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class users extends StatelessWidget {
  const users({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Unlimited_PlanBloc _unlimited_bloc =
        BlocProvider.of<Unlimited_PlanBloc>(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            BlocBuilder<Unlimited_PlanBloc, Unlimited_PlanState>(
                builder: (context, state) {
              if (state is SuccessState) {
                int registred = state.users.length;
                int expired = state.users
                    .where((user) =>
                        user.endDate.difference(user.startingDate).inDays <= 0)
                    .length;
                int nearToexpired = state.users
                    .where((user) =>
                        user.endDate.difference(user.startingDate).inDays > 0 && user.endDate.difference(user.startingDate).inDays < 5  )
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
                      ],
                    ),
                    SizedBox(height: 50),
                    userss(
                      pngg: "assets/images/aa.png",
                      text1: nearToexpired.toString(),
                      text2: "Near to Expired",
                      clr: Color(0xff10BD9E),
                    ),
                  ],
                );
              } else if (state is IinitialState) {
                _unlimited_bloc.add(GetUsersEvent());
                return Loading();
              } else if (state is ErrorState) {
                return Loading();
              } else {
                return Loading();
              }
            })
          ],
        ),
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
      width: 500,
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
