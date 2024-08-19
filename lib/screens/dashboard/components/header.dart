import 'package:admin/const/loading.dart';
import 'package:admin/screens/dashboard/components/rfid_bloc/rfid_plan_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Header extends StatefulWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final TextEditingController _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xffFFA05C).withOpacity(0.3), // Color of the border
            width: 2.5, // Width of the border
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Gym’s dashbaord ! ",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 23,
                      color: Colors.black)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.3), // Color of the border
                          width: 2.5, // Width of the border
                        ),
                      ),
                    ),
                    child: _inputField(_idController, 'user id', true),
                    width: 200,
                  ),
                  BlocBuilder<Rfid_PlanBloc, Rfid_PlanState>(
                      builder: (context, state) {
                    if (state is SuccessState) {
                      return Column(
                        children: [
                          Text(state.done.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 0, 153, 0))),
                        ],
                      );
                    } else if (state is ErrorState) {
                      return Text(state.error.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: Color.fromARGB(255, 153, 0, 0)));
                    } else if (state is LoadingState) {
                      return Loading();
                    } else {
                      return Text("watting for Card",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: Color.fromARGB(255, 0, 0, 0)));
                    }
                  })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(
      TextEditingController controller, String hint, bool numberOrNot) {
    final Rfid_PlanBloc rfid_planBloc = BlocProvider.of<Rfid_PlanBloc>(context);

    return TextFormField(
      controller: controller,
      keyboardType: numberOrNot ? TextInputType.number : null,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: 16,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
      onEditingComplete: () {
        _rfidCardUserCheck(rfid_planBloc, context);
        print(controller.text); //////////////////////////////////////////////////////////////////////
      },
      // onChanged: (value) {
      //   // Call _addProfile() when Enter is pressed.
      //   if (value.length > 4) {
      //     _idController.text = value;

      //     // _unlimited_bloc.add(GetUsersEvent());
      //     // session_8_planBloc.add(Event8.GetUsersEvent());
      //     // session_12_planBloc.add(Event12.GetUsersEvent());
      //     // session_16_planBloc.add(Event16.GetUsersEvent());
      //     // expense_planBloc.add(Expense.GetExpensesEvent());
      //   }
      // },
    );
  }

  void _rfidCardUserCheck(Rfid_PlanBloc rfid_planBloc, BuildContext context) {
    if (_idController.text.isNotEmpty) {
      rfid_planBloc
          .add(UpdateUserEvent(id: _idController.text, context: context));
      _idController.clear();
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }
}
