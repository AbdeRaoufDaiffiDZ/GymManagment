// ignore_for_file: deprecated_member_use

import 'package:admin/entities/gym_parm_entity.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/expense_list/expense_plan_bloc/bloc/expense_plan_bloc.dart';
import 'package:flutter/material.dart';

import 'package:admin/const/loading.dart';
import 'package:admin/data/mongo_db.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants.dart';

class ExpenseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(0),
          child: Column(
            children: [
              Header(),
              SizedBox(height: defaultPadding),
              expense(),
            ],
          ),
        ),
      ),
    );
  }
}

int count = 0;
bool edit = false;
bool checkDate = false;
late Expense userr;

class expense extends StatefulWidget {
  const expense({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<expense> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final MongoDatabase monog = MongoDatabase();
  final String plan = "GymParam";
  final startingDate = DateTime.now();
  final int sessionNumber = 8;
  final int daysNumber = 45;
  List<Expense> _allItems = [];
  List<Expense> _filteredItems = [];

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
        return item.expenseName.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _addProfile(Expense? user) {
    BlocProvider.of<Expense_PlanBloc>(context);

    if (_nameController.text.isNotEmpty &&
       
        _priceController.text.isNotEmpty) {
      final Expense_PlanBloc expense_planBloc =
          BlocProvider.of<Expense_PlanBloc>(context);

      Expense expenseNew = Expense(
          expensePrice: int.parse(_priceController.text),
          dateTime: DateTime.now(),
          expenseName: _nameController.text);

      expense_planBloc.add(AddExpenseEvent(expense: expenseNew));
      _nameController.clear();
      _priceController.clear();
    }
    _filteredItems = _allItems;
    count = 0;
    edit = false;
    checkDate = false;
  }

  void _editProfile(Expense user) {
    setState(() {
      _nameController.text = user.expenseName;
      _priceController.text = user.expensePrice.toString();
      edit = true;
    });
    userr = user;
  }

  void _deleteProfile(Expense expense) {
    final Expense_PlanBloc _expense_bloc =
        BlocProvider.of<Expense_PlanBloc>(context);
    _expense_bloc.add(DeleteExpenseEvent(expense: expense));
    count = 0;
  }

  /*void _renewProfile(User_Data user) {
    final Unlimited_PlanBloc _unlimited_bloc =
        BlocProvider.of<Unlimited_PlanBloc>(context);
    user.endDate = DateTime.now().add(const Duration(days: 30));
    _unlimited_bloc.add(UpdateUserEvent(user: user));
  }
*/

  @override
  void dispose() {
    _searchController.dispose();
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
final Expense_PlanBloc _expense_bloc =
        BlocProvider.of<Expense_PlanBloc>(context);
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
                      color: const Color(0xff202020).withOpacity(0.88)),
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
              edit ? "edit a profile :" : "Add a profile :",
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
                Expanded(child: _inputField(_priceController, 'Price', true)),
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
            child: BlocBuilder<Expense_PlanBloc, Expense_PlanState>(
                builder: (context, state) {
              if (state is SuccessState) {
                _allItems = state.expense!;

                if (count == 0) {
                  _filteredItems = state.expense!;
                  count++;
                }
                _filteredItems
                    .sort((a, b) => a.expensePrice.compareTo(b.expensePrice));
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Table(
                    columnWidths: {
                      0: FixedColumnWidth(300),
                      1: FixedColumnWidth(230),
                      2: FixedColumnWidth(230),
                    },
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: Color(0xffFFA05D).withOpacity(0.4),
                        ),
                        children: [
                          _tableHeaderCell("Name"),
                          _tableHeaderCell("Price"),
                          _tableHeaderCell(""),
                        ],
                      ),
                      for (var user in _filteredItems)
                        TableRow(
                          decoration: BoxDecoration(
                            color: Color(0xffFAFAFA),
                          ),
                          children: [
                            _tableCell(user.expenseName),
                            _tableCell(user.expensePrice.toString()),
                            _tableCellActions(user),
                          ],
                        ),
                    ],
                  ),
                );
              } else if (state is IinitialState) {
               _expense_bloc .add(GetExpensesEvent());
                return Loading();
              } else if (state is ErrorState) {
               _expense_bloc .add(GetExpensesEvent());
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
        // Call _addProfile() when Enter is pressed.
        _addProfile(null);
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

  bool isDate1BeforeDate2(String yyyymmdd1, String yyyymmdd2) {
    DateTime date1 = DateTime.parse(yyyymmdd1);
    DateTime date2 = DateTime.parse(yyyymmdd2);

    return date1.isBefore(date2);
  }

  Widget _tableCellActions(Expense user) {
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
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            _deleteProfile(user);
          },
        ),
      ],
    );
  }
}
