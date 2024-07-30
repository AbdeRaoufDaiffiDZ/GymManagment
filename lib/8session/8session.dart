// ignore_for_file: deprecated_member_use

import 'package:admin/8session/8session_bloc/bloc/8session_bloc.dart';
import 'package:admin/8session/8session_bloc/bloc/session_8_event.dart';
import 'package:admin/const/loading.dart';
import 'package:admin/data/mongo_db.dart';
import 'package:admin/entities/user_data_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

int count = 0;
bool edit = false;
bool checkDate = false;
late User_Data userr;

class eightSession extends StatefulWidget {
  const eightSession({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<eightSession> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _creditController = TextEditingController();
  final MongoDatabase monog = MongoDatabase();
  final String plan = "8 session";
  final startingDate = DateTime.now();

  List<User_Data> _allItems = [];
  List<User_Data> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _allItems;
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = _allItems.where((item) {
        return item.fullName.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _addProfile(User_Data? user) {
    if (_nameController.text.isNotEmpty && _creditController.text.isNotEmpty) {
      final Session_8_PlanBloc _unlimited_bloc =
          BlocProvider.of<Session_8_PlanBloc>(context);

      if (edit) {
        late User_Data userNew;
        if (checkDate) {
          userNew = User_Data(
              id: user!.id,
              fullName: user.fullName,
              plan: user.plan,
              startingDate: user.startingDate,
              endDate: user.endDate,
              credit: user.credit,
              sessionLeft: user.sessionLeft,
              lastCheckDate: user.lastCheckDate);
        } else {
          userNew = User_Data(
              id: userr.id,
              fullName: _nameController.text,
              plan: userr.plan,
              startingDate: userr.startingDate,
              endDate: userr.endDate,
              credit: _creditController.text,
              sessionLeft: userr.sessionLeft,
              lastCheckDate: userr.lastCheckDate);
        }

        final Session_8_PlanBloc _unlimited_bloc =
            BlocProvider.of<Session_8_PlanBloc>(context);
        _unlimited_bloc.add(UpdateUserEvent(user: userNew));
        setState(() {
          _filteredItems = _allItems;
          count = 0;
        });
        edit = false;
        checkDate = false;
      } else {
        setState(() {
          _filteredItems = _allItems;
          count = 0;
        });
        User_Data newUser = User_Data(
            fullName: _nameController.text,
            plan: plan,
            startingDate: DateTime.now(),
            endDate: DateTime.now().add(const Duration(days: 30)),
            credit: _creditController.text,
            id: mongo.ObjectId().toHexString(),
            sessionLeft: 8,
            lastCheckDate: DateFormat('yyyy-MM-dd').format(DateTime.now()));
        _unlimited_bloc.add(AddUserEvent(user: newUser));
      }
    }
  }

  void _editProfile(User_Data user) {
    setState(() {
      _nameController.text = user.fullName;
      _creditController.text = user.credit;
      edit = true;
    });
    userr = user;
  }

  void _deleteProfile(User_Data user) {
    final Session_8_PlanBloc _unlimited_bloc =
        BlocProvider.of<Session_8_PlanBloc>(context);
    _unlimited_bloc.add(DeleteUserEvent(user: user));
  }

  /*void _renewProfile(User_Data user) {
    final Unlimited_PlanBloc _unlimited_bloc =
        BlocProvider.of<Unlimited_PlanBloc>(context);
    user.endDate = DateTime.now().add(const Duration(days: 30));
    _unlimited_bloc.add(UpdateUserEvent(user: user));
  }
*/
  void _toggleSessionMark(User_Data user, bool value) {
    setState(() {
      user.isSessionMarked = value;
      count = 0;
    });
    User_Data user_data = User_Data(
        isSessionMarked: user.isSessionMarked,
        sessionLeft: user.sessionLeft,
        id: user.id,
        fullName: user.fullName,
        plan: user.plan,
        startingDate: user.startingDate,
        endDate: user.endDate,
        credit: user.credit,
        lastCheckDate: user.lastCheckDate);
    if (value) {
      // Implement the checkbox functionality if needed
      user_data.isSessionMarked = true;
      user_data.sessionLeft = user_data.sessionLeft - 1;
      user_data.lastCheckDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    } else {
      user_data.isSessionMarked = false;
      user_data.sessionLeft = user_data.sessionLeft + 1;
      user_data.lastCheckDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    }
    final Session_8_PlanBloc session_8_planBloc =
        BlocProvider.of<Session_8_PlanBloc>(context);
    session_8_planBloc.add(UpdateUserEvent(user: user_data));
  }

  void _renewProfile(User_Data user) {
    setState(() {
      count = 0;
    });
    final Session_8_PlanBloc _unlimited_bloc =
        BlocProvider.of<Session_8_PlanBloc>(context);
    final renewUser = User_Data(
        id: user.id,
        fullName: user.fullName,
        plan: user.plan,
        startingDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 30)),
        credit: user.credit,
        sessionLeft: 8,
        lastCheckDate: DateFormat('yyyy-MM-dd').format(DateTime.now()));
    _unlimited_bloc.add(UpdateUserEvent(user: renewUser));
  }

  @override
  void dispose() {
    _searchController.dispose();
    _nameController.dispose();
    _creditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Session_8_PlanBloc _unlimited_bloc =
        BlocProvider.of<Session_8_PlanBloc>(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 22),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xffFFA05D).withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type a name...',
                  hintStyle: TextStyle(
                    fontSize: 17,
                    color: const Color(0xff202020).withOpacity(0.88),
                  ),
                  icon: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.search,
                        color: Color(0xff202020).withOpacity(0.5)),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 22),
            child: Text(
              "Add a profile :",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 22.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color(0xffF9F9F9),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(child: _inputField(_nameController, 'Name', false)),
                SizedBox(width: 10),
                Expanded(child: _inputField(_creditController, 'Credit', true)),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    _addProfile(null);
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Color(0xffFFA05D)),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Text(
              "Recently added",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 17,
              ),
            ),
          ),
          Divider(
            indent: 25,
            endIndent: 30,
            height: 25,
            thickness: 2,
            color: Color(0xffE6E6E6),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: BlocBuilder<Session_8_PlanBloc, session_8_PlanState>(
                builder: (context, state) {
              if (state is SuccessState) {
                _allItems = state.users
                    .where((element) => element.plan == plan)
                    .toList();
                if (count == 0) {
                  _filteredItems = state.users;
                  count++;
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Table(
                    columnWidths: {
                      0: FixedColumnWidth(300),
                      1: FixedColumnWidth(230),
                      2: FixedColumnWidth(230),
                      3: FixedColumnWidth(230),
                      4: FixedColumnWidth(230),
                    },
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: Color(0xffFFA05D).withOpacity(0.4),
                        ),
                        children: [
                          _tableHeaderCell("Name"),
                          _tableHeaderCell("Days left"),
                          _tableHeaderCell("Credit"),
                          _tableHeaderCell("Sessions left"),
                          _tableHeaderCell(""),
                        ],
                      ),
                      for (var user in _filteredItems)
                        TableRow(
                          decoration: BoxDecoration(
                            color: Color(0xffFAFAFA),
                          ),
                          children: [
                            _tableCell(user.fullName),
                            _tableCell(user.endDate
                                .difference(user.startingDate)
                                .inDays
                                .toString()),
                            _tableCell(user.credit),
                            _tableCell(user.credit),
                            _tableCellActions(user),
                          ],
                        ),
                    ],
                  ),
                );
              } else if (state is IinitialState) {
                _unlimited_bloc.add(GetUsersEvent());
                return Loading();
              } else if (state is ErrorState) {
                return Loading();
              } else {
                return Loading();
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _inputField(
      TextEditingController controller, String hint, bool numberOrNot) {
    return TextField(
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

  Widget _tableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style:
            TextStyle(fontSize: 19, color: Color(0xff202020).withOpacity(0.55)),
      ),
    );
  }

  Widget _tableCellActions(User_Data user) {
    if (user.lastCheckDate != null) {
      DateTime timeCheck = DateFormat('yyyy-MM-dd').parse(
          user.lastCheckDate!); // check this logic here maybe will not work
      bool isCheckeddd = timeCheck.day.compareTo(DateTime.now().day) > 0;
      bool isCheckedyy = timeCheck.year.compareTo(DateTime.now().year) == 0;
      bool isCheckedmm = timeCheck.month.compareTo(DateTime.now().month) == 0;
      bool isChecked = false;
      if (isCheckeddd && isCheckedmm && isCheckedyy) {
        isChecked = true;
      }
      if (isChecked) {
        user.isSessionMarked = false;
        checkDate = true;
        _addProfile(user);
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.edit, color: Colors.blue),
          onPressed: () {
            _editProfile(user);
          },
        ),
        IconButton(
          icon: Icon(Icons.refresh, color: Colors.green),
          onPressed: () {
            _renewProfile(user);
          },
        ),
        IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            _deleteProfile(user);
          },
        ),
        Checkbox(
          value: user.isSessionMarked,
          onChanged: (bool? value) {
            _toggleSessionMark(user, value!);
          },
        ),
      ],
    );
  }
}
