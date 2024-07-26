import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _planController = TextEditingController();
  final TextEditingController _daysLeftController = TextEditingController();
  final TextEditingController _creditController = TextEditingController();

  List<Item> _allItems = [
    Item(
        name: "Hariri Sofian",
        plan: "Cardio",
        daysLeft: "20 days",
        credit: "1000 DA"),
    Item(
        name: "Hariri Sofian",
        plan: "Cardio",
        daysLeft: "10 days",
        credit: "1000 DA"),
    Item(
        name: "Hariri Sofian",
        plan: "Cardio",
        daysLeft: "12 days",
        credit: "1000 DA"),
    Item(
        name: "Hariri Sofian",
        plan: "Cardio",
        daysLeft: "1 day",
        credit: "1000 DA"),
    Item(
        name: "Daiffi Raouf",
        plan: "Cardio",
        daysLeft: "31 days",
        credit: "1000 DA"),
    Item(
        name: "Hariri Sofian",
        plan: "Cardio",
        daysLeft: "6 days",
        credit: "1000 DA"),
  ];

  List<Item> _filteredItems = [];

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
        return item.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _addProfile() {
    if (_nameController.text.isNotEmpty &&
        _planController.text.isNotEmpty &&
        _daysLeftController.text.isNotEmpty &&
        _creditController.text.isNotEmpty) {
      setState(() {
        _allItems.add(Item(
          name: _nameController.text,
          plan: _planController.text,
          daysLeft: _daysLeftController.text,
          credit: _creditController.text,
        ));
        _filteredItems = _allItems;
      });
      _nameController.clear();
      _planController.clear();
      _daysLeftController.clear();
      _creditController.clear();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _nameController.dispose();
    _planController.dispose();
    _daysLeftController.dispose();
    _creditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                Expanded(child: _inputField(_nameController, 'Name')),
                SizedBox(width: 10),
                Expanded(child: _inputField(_planController, 'Plan')),
                SizedBox(width: 10),
                Expanded(child: _inputField(_daysLeftController, 'Days left')),
                SizedBox(width: 10),
                Expanded(child: _inputField(_creditController, 'Credit')),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addProfile,
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Table(
                columnWidths: {
                  0: FixedColumnWidth(300),
                  1: FixedColumnWidth(300),
                  2: FixedColumnWidth(300),
                  3: FixedColumnWidth(300),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Color(0xffFFA05D).withOpacity(0.4),
                    ),
                    children: [
                      _tableHeaderCell("Name"),
                      _tableHeaderCell("Plan"),
                      _tableHeaderCell("Days left"),
                      _tableHeaderCell("Credit"),
                    ],
                  ),
                  for (var item in _filteredItems)
                    TableRow(
                      decoration: BoxDecoration(
                        color: Color(0xffFAFAFA),
                      ),
                      children: [
                        _tableCell(item.name),
                        _tableCell(item.plan),
                        _tableCell(item.daysLeft),
                        _tableCell(item.credit),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
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
        style: TextStyle(
            fontSize: 19, color: Color(0xff2020202).withOpacity(0.55)),
      ),
    );
  }
}

class Item {
  final String name;
  final String plan;
  final String daysLeft;
  final String credit;

  Item({
    required this.name,
    required this.plan,
    required this.daysLeft,
    required this.credit,
  });

  static fromJson(json) {}
}
