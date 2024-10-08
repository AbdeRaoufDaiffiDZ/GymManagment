// ignore_for_file: deprecated_member_use, unused_element

import 'package:admin/const/loading.dart';
import 'package:admin/data/mongo_db.dart';
import 'package:admin/entities/user_data_entity.dart';
import 'package:admin/screens/expense_list/expense_plan_bloc/bloc/expense_plan_bloc.dart'
    as Expense;
import 'package:admin/screens/expense_list/expense_plan_bloc/bloc/expense_plan_bloc.dart';
import 'package:admin/screens/plans/12sess/12session_bloc/bloc/12session_bloc.dart';
import 'package:admin/screens/plans/12sess/12session_bloc/bloc/session_12_event.dart'
    as Event12;
import 'package:admin/screens/plans/16session/16session_bloc/bloc/16session_bloc.dart'
    as Session16Bloc;
import 'package:admin/screens/plans/16session/16session_bloc/bloc/session_16_event.dart'
    as Event16;
import 'package:admin/screens/plans/8session/8session_bloc/bloc/8session_bloc.dart';
import 'package:admin/screens/plans/8session/8session_bloc/bloc/session_8_event.dart'
    as Event8;
import 'package:admin/screens/plans/unlimited/unlimited_plan_bloc/bloc/unlimited_plan_bloc.dart'
    as Unlimited;
import 'package:admin/screens/plans/unlimited/unlimited_plan_bloc/bloc/unlimited_plan_bloc.dart';
import 'package:admin/screens/products_screens/products_bloc/products_bloc.dart';
import 'package:admin/screens/products_screens/products_bloc/products_blocEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

int count = 0;
bool edit = false;
late User_Data userr;
final int sessionNumber = 0;

String? _selectedSexForDataEntry;
String? _selectedSexForFiltering;
final int daysNumber = 30;

class unlimited extends StatefulWidget {
  const unlimited({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<unlimited> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _creditController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _tapisController = TextEditingController();

  final MongoDatabase monog = MongoDatabase();
  final String plan = "unlimited";

  List<User_Data> _allItems = [];
  List<User_Data> _filteredItems = [];
  DateTime? selectedDate;

  final List<String> _sexOptions = ['All', 'Male', 'Female'];
  final List<String> _sexOption = ['Male', 'Female'];

  @override
  void initState() {
    super.initState();
    _filteredItems = _allItems;
    _searchController.addListener(_filterItems);
    _tapisController.text = 'false';
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      _filteredItems = _allItems.where((item) {
        final matchesName = item.fullName.toLowerCase().contains(query);
        final matchesSex = _selectedSexForFiltering == 'All' ||
            _selectedSexForFiltering == null ||
            _selectedSexForFiltering!.isEmpty ||
            item.sex == _selectedSexForFiltering;

        return matchesName && matchesSex;
      }).toList();
    });
  }

  void _onSexChangedForFiltering(String? newValue) {
    setState(() {
      _selectedSexForFiltering = newValue;
    });
    _filterItems(); // Call the filtering method here
  }

  void _onSexChangedForDataEntry(String? newValue) {
    setState(() {
      _selectedSexForDataEntry = newValue;
      _sexController.text = newValue!;
    });
  }

  Widget DropDownForDataEntry() {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.white,
      decoration: InputDecoration(
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
        fillColor: Colors.transparent,
        filled: true,
      ),
      hint: Text(
        'Sex',
        style: TextStyle(color: Colors.black.withOpacity(0.8)),
      ),
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.orange,
      ),
      value: _selectedSexForDataEntry,
      items: _sexOption.map((String sex) {
        return DropdownMenuItem<String>(
          value: sex,
          child: Text(
            sex,
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: 16.0,
            ),
          ),
        );
      }).toList(),
      onChanged: _onSexChangedForDataEntry,
    );
  }

  Widget DropDownForFiltering() {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.white,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.orange),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        fillColor: Colors.transparent,
        filled: true,
      ),
      hint: Text(
        'Sex',
        style: TextStyle(color: Colors.black.withOpacity(0.8)),
      ),
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.orange,
      ),
      value: _selectedSexForFiltering,
      items: _sexOptions.map((String sex) {
        return DropdownMenuItem<String>(
          value: sex,
          child: Text(
            sex,
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: 16.0,
            ),
          ),
        );
      }).toList(),
      onChanged: _onSexChangedForFiltering,
    );
  }

  Future<void> _addProfile(User_Data? user) async {
    if (_nameController.text.isNotEmpty &&
        _idController.text.isNotEmpty &&
        int.tryParse(_creditController.text) != null &&
        _sexController.text.isNotEmpty &&
        _tapisController.text.isNotEmpty &&
        _creditController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty) {
      final Unlimited_PlanBloc _unlimited_bloc =
          BlocProvider.of<Unlimited_PlanBloc>(context);
        MongoDatabase mn = MongoDatabase();

      if (edit) {
        final userNew = User_Data(
            isEdit: true,
            tapis: _tapisController.text.toLowerCase() == 'true',
            sex: _sexController.text,
            id: _idController.text,
            fullName: _nameController.text,
            plan: userr.plan,
            startingDate: userr.startingDate,
            endDate: userr.endDate,
            credit: _creditController.text,
            sessionLeft: sessionNumber,
            lastCheckDate: userr.lastCheckDate,
            phoneNumber: _phoneController.text);
      if (userNew.tapis && !userr.tapis) {
  var gymParam = await mn.GymParamRetrive(collectionName: "Expense", context: context);
        if(gymParam.isRight){
          userNew.credit = userNew.tapis
              ? (int.parse(userNew.credit) +gymParam.right.PlanPrices['tapis']!).toString()
              : userNew.credit;
        }
          
        }
        _unlimited_bloc.add(Unlimited.UpdateUserEvent(user: userNew, context: context));
      } else {
        User_Data newUser = User_Data(
            isNewUser: true,
            sex: _sexController.text,
            tapis: _tapisController.text.toLowerCase() == 'true',
            fullName: _nameController.text,
            plan: plan,
            startingDate: DateTime.now(),
            endDate: DateTime.now().add(Duration(days: daysNumber)),
            credit: _creditController.text,
            id: _idController.text,
            sessionLeft: sessionNumber,
            lastCheckDate: '',
            phoneNumber: _phoneController.text);
        _unlimited_bloc.add(AddUserEvent(user: newUser, context: context));
      }

      setState(() {
        _selectedSexForDataEntry = null;
        _nameController.clear();
        _idController.clear();
        _creditController.clear();
        _phoneController.clear();
        _sexController.clear();
        _tapisController.text = 'false';
      });

      _filteredItems = _allItems;
      count = 0;
      edit = false;
    }
  }

  void _editProfile(User_Data user) {
    setState(() {
      _phoneController.text = user.phoneNumber;
      _nameController.text = user.fullName;

      _idController.text = user.id;
      _creditController.text = user.credit;
      _sexController.text = user.sex;
      _selectedSexForDataEntry = user.sex;
      _tapisController.text = user.tapis.toString();

      edit = true;
    });
    userr = user;
  }

  void _renewProfile(User_Data user, String credit, DateTime? startDate) {
    final Unlimited_PlanBloc _unlimited_bloc =
        BlocProvider.of<Unlimited_PlanBloc>(context);

    final DateTime renewalStartDate = startDate ?? DateTime.now();
    final DateTime renewalEndDate =
        renewalStartDate.add(Duration(days: daysNumber));
    // final int daysLeft = renewalEndDate.difference(DateTime.now()).inDays;

    final renewUser = User_Data(
      renew: true,
      sex: user.sex,
      id: user.id,
      fullName: user.fullName,
      plan: user.plan,
      startingDate: renewalStartDate,
      endDate: renewalEndDate,
      credit: credit,
      sessionLeft: 0,
      lastCheckDate: '',
      phoneNumber: user.phoneNumber,
    );

    _unlimited_bloc.add(Unlimited.UpdateUserEvent(user: renewUser, context: context));
  }

  void _deleteProfile(User_Data user) {
    final Unlimited_PlanBloc _unlimited_bloc =
        BlocProvider.of<Unlimited_PlanBloc>(context);
    _unlimited_bloc.add(DeleteUserEvent(user: user, context: context));
  }

  void _toggleSessionMark(User_Data user, bool value) {
    setState(() {
      user.isSessionMarked = value;
    });
    // Implement the checkbox functionality if needed
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();

    _searchController.dispose();
    _nameController.dispose();
    _idController.dispose();
    _creditController.dispose();
    _phoneController.dispose();
    _tapisController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Unlimited_PlanBloc _unlimited_bloc =
        BlocProvider.of<Unlimited_PlanBloc>(context);
    final Session16Bloc.Session_16_PlanBloc session_16_planBloc =
        BlocProvider.of<Session16Bloc.Session_16_PlanBloc>(context);
    final Session_8_PlanBloc session_8_planBloc =
        BlocProvider.of<Session_8_PlanBloc>(context);

    final Session_12_PlanBloc session_12_planBloc =
        BlocProvider.of<Session_12_PlanBloc>(context);
    final Expense_PlanBloc expense_planBloc =
        BlocProvider.of<Expense_PlanBloc>(context);
    final ProductsBloc productsBloc = BlocProvider.of<ProductsBloc>(context);
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 22),
          child: Row(
            children: [
              Expanded(
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
              SizedBox(width: 10),
              Container(
                width: 110,
                child: DropDownForFiltering(),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 22),
          child: Text(
            edit ? "Edit a profile:" : "Add a profile:",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 18.0),
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
              Expanded(child: _inputField(_idController, 'ID', false)),
              SizedBox(width: 20),
              Expanded(child: _inputField(_nameController, 'Name', false)),
              SizedBox(width: 10),
              Expanded(
                  child: _inputField(_phoneController, 'Phone Number', true)),
              SizedBox(width: 30),
              Expanded(child: _inputField(_creditController, 'Credit', true)),
              SizedBox(width: 10),
              Expanded(
                  child:
                      DropDownForDataEntry()), // Use the dropdown for data entry
              SizedBox(width: 40),
              Checkbox(
                value: _tapisController.text.toLowerCase() == 'true',
                onChanged: (bool? value) {
                  setState(() {
                    _tapisController.text = value.toString();
                  });
                },
              ),
              SizedBox(width: 30),
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
        Row(
          children: [
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
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.green,
              ),
              onPressed: () {
                _unlimited_bloc.add(Unlimited.GetUsersEvent(context: context));
                session_8_planBloc.add(Event8.GetUsersEvent(context: context));
                session_12_planBloc.add(Event12.GetUsersEvent(context: context));
                session_16_planBloc.add(Event16.GetUsersEvent(context: context));
                expense_planBloc.add(Expense.GetExpensesEvent(context: context));
                productsBloc.add(GetProductsEvent(context: context));
                count = 0;
              },
            ),
          ],
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
          child: BlocBuilder<Unlimited_PlanBloc, Unlimited_PlanState>(
              builder: (context, state) {
            if (state is Unlimited.SuccessState) {
              _allItems = state.users;
              if (count == 0) {
                _filteredItems = state.users;
                count++;
              }
             
              return Scrollbar(
                thumbVisibility: true, // Always show the scrollbar thumb
                controller:
                    _scrollController, // Attach the controller to the Scrollbar

                child: SingleChildScrollView(
                  controller:
                      _scrollController, // Attach the controller to the SingleChildScrollView

                  scrollDirection: Axis.horizontal,
                  child: Table(
                    columnWidths: {
                      0: FixedColumnWidth(250),
                      1: FixedColumnWidth(250),
                      2: FixedColumnWidth(170),
                      3: FixedColumnWidth(170),
                      4: FixedColumnWidth(170),
                      5: FixedColumnWidth(170),
                      6: FixedColumnWidth(220),
                    },
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: Color(0xffFFA05D).withOpacity(0.4),
                        ),
                        children: [
                          _tableHeaderCell("Name"),
                          _tableHeaderCell("Phone Number"),
                          _tableHeaderCell("Sex"),
                          _tableHeaderCell("Days left"),
                          _tableHeaderCell("Tapis"),
                          _tableHeaderCell("Credit"),
                          _tableHeaderCell(""),
                        ],
                      ),
                      for (var user in _filteredItems)
                        TableRow(
                          decoration: BoxDecoration(
                            color: (user.endDate
                                        .difference(DateTime.now())
                                        .inDays <=
                                    0)
                                ? Colors.red.withOpacity(0.3)
                                : Color(0xffFAFAFA),
                          ),
                          children: [
                            _tableCell(user.fullName),
                            _tableCell(user.phoneNumber),
                            _tableCell(user.sex),
                            _tableCell(user.endDate
                                .difference(DateTime.now())
                                .inDays
                                .toString()),
                            _tableCell(user.tapis.toString()),
                            _tableCell(user.credit),
                            _tableCellActions(user),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            } else if (state is Unlimited.IinitialState) {
              _unlimited_bloc.add(GetUsersEvent(context: context));
              return Loading();
            } else if (state is Unlimited.ErrorState) {
              return Loading();
            } else {
              count = 0;
              return Loading();
            }
          }),
        ),
      ]),
    );
  }

  Widget _inputField(
      TextEditingController controller, String hint, bool numberOrNot,
      {bool isRenew = false, User_Data? user = null}) {
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
      onFieldSubmitted: (value) {
        if (isRenew && selectedDate != null) {
          _renewProfile(user!, value, selectedDate);
          _creditController.clear();
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        } else {
          _addProfile(null);
        }
      },
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
            TextStyle(fontSize: 19, color: Color(0xff202020).withOpacity(0.8)),
      ),
    );
  }

  Widget _tableCellActions(User_Data user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.edit, color: Colors.blue),
          onPressed: () {
            _editProfile(user);
            count = 0;
          },
        ),
        IconButton(
          icon: Icon(Icons.refresh, color: Colors.green),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                DateTime? selectedDate;
                final TextEditingController _creditController =
                    TextEditingController();

                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text('Renew Profile'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _inputField(_creditController, 'Credit', true,
                              isRenew: true, user: user),
                          SizedBox(height: 20),
                          TextButton(
                            onPressed: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );

                              if (pickedDate != null &&
                                  pickedDate != selectedDate) {
                                setState(() {
                                  selectedDate = pickedDate;
                                });
                              }
                            },
                            child: Text(
                              selectedDate == null
                                  ? 'Select Start Date'
                                  : 'Start Date: ${DateFormat('yyyy-MM-dd').format(selectedDate!)}', // Format the date
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            if (selectedDate != null) {
                              _renewProfile(
                                  user, _creditController.text, selectedDate);
                              Navigator.pop(context);
                            } else {}
                          },
                          child: Text('Save'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                      ],
                    );
                  },
                );
              },
            );
            count = 0;
          },
        ),

        IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            _deleteProfile(user);
            count = 0;
          },
        ),
        // Checkbox(
        //   value: user.isSessionMarked,
        //   onChanged: (bool? value) {
        //     _toggleSessionMark(user, value!);
        //   },
        // ),
      ],
    );
  }
}
