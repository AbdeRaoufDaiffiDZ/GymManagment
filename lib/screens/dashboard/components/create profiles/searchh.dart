import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 22),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xffF2F5F5),
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffE6E6E6),
                    spreadRadius: 1.5,
                    blurRadius: 0.5,
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type a name... ',
                  hintStyle: TextStyle(
                    fontSize: 17,
                    color: const Color(0xff202020).withOpacity(0.7),
                  ),
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.search, color: Colors.teal),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 55,
            color: Color(0xffEDF4F4),
            width: double.infinity,
            child: Row(
              children: [
                SizedBox(width: 20),
                Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                SizedBox(width: 190),
                Text(
                  "Speciality",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                SizedBox(width: 130),
                Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                SizedBox(width: 330),
                Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                ),
                SizedBox(width: 190),
                Text(
                  "Default",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                )
              ],
            ),
          ),
          SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.only(left: 22.0),
            child: Text(
              "Receentely added",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
            ),
          ),
          const Divider(
            color: Color(0xffE6E6E6),
            thickness: 2,
          ),
          Container(
            height: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  NewWidget(
                    text1: "Hariri Sofian",
                    text2: "Genraliste",
                    text3: "sofianhariri9@gmail.com",
                    text4: "sofian123",
                  ),
                  SizedBox(height: 15),
                  NewWidget(
                    text1: "Hariri Sofian",
                    text2: "Genraliste",
                    text3: "sofianhariri9@gmail.com",
                    text4: "sofian123",
                  ),
                  SizedBox(height: 15),
                  NewWidget(
                    text1: "Hariri Sofian",
                    text2: "Genraliste",
                    text3: "sofianhariri9@gmail.com",
                    text4: "sofian123",
                  ),
                  SizedBox(height: 15),
                  NewWidget(
                    text1: "Hariri Sofian",
                    text2: "Genraliste",
                    text3: "sofianhariri9@gmail.com",
                    text4: "sofian123",
                  ),
                  SizedBox(height: 15),
                  NewWidget(
                    text1: "Hariri Sofian",
                    text2: "Genraliste",
                    text3: "sofianhariri9@gmail.com",
                    text4: "sofian123",
                  ),
                  SizedBox(height: 15),
                  NewWidget(
                    text1: "Hariri Sofian",
                    text2: "Genraliste",
                    text3: "sofianhariri9@gmail.com",
                    text4: "sofian123",
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NewWidget extends StatefulWidget {
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  const NewWidget(
      {Key? key,
      required this.text1,
      required this.text2,
      required this.text3,
      required this.text4})
      : super(key: key);

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 22),
        Text(
          widget.text1,
          style: TextStyle(fontSize: 19),
        ),
        SizedBox(width: 120),
        Text(
          widget.text2,
          style: TextStyle(fontSize: 19),
        ),
        SizedBox(width: 100),
        Text(
          widget.text3,
          style: TextStyle(fontSize: 19),
        ),
        SizedBox(width: 150),
        Text(
          widget.text4,
          style: TextStyle(fontSize: 19),
        ),
        SizedBox(width: 180),
        Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffF2F5F5),
                ),
                child: Image.asset(
                  "assets/images/doctor.png",
                  color: selectedIndex == 0
                      ? Color(0xff2020020)
                      : Color(0xff202020).withOpacity(0.5),
                ),
              ),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffF2F5F5),
                ),
                child: Image.asset(
                  "assets/images/doctora.png",
                  color: selectedIndex == 1
                      ? Color(0xff2020020)
                      : Color(0xff202020).withOpacity(0.5),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
