import 'package:flutter/material.dart';

class RecomDoctors extends StatefulWidget {
  const RecomDoctors({Key? key}) : super(key: key);
  @override
  State<RecomDoctors> createState() => _RecomDoctorsState();
}

class _RecomDoctorsState extends State<RecomDoctors> {
  bool isExpanded = false;
  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              "Recommended Profiles",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xff202020).withOpacity(0.65),
                fontSize: 20,
              ),
            ),
          ),
          Container(
            height: 220,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 2.0, top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25.0),
                        child: Container(
                          height:
                              40, // Align the TextField with the non-expanded height of MostVisitedd
                          width: 300.0,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 0),
                          decoration: BoxDecoration(
                            color: Color(0xffF2F5F5),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffE6E6E6),
                                spreadRadius: 1.5,
                                blurRadius: 0.5,
                              )
                            ],
                          ),
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type a name ',
                                hintStyle: TextStyle(
                                    fontSize: 17,
                                    color: Color(0xff202020).withOpacity(0.7)),
                                icon: Icon(Icons.search, color: Colors.teal),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 30),
                      MostVisitedd(
                        svg: "assets/images/doctor.png",
                        text1: "Dr. Full Name",
                        text2: "Specialty",
                        text3: "example@gmail.com",
                        text4: "password123",
                      ),
                      SizedBox(width: 30),
                      MostVisitedd(
                        svg: "assets/images/doctor.png",
                        text1: "Dr. Full Name",
                        text2: "Specialty",
                        text3: "example@gmail.com",
                        text4: "password123",
                      ),
                      SizedBox(width: 30),
                      MostVisitedd(
                        svg: "assets/images/doctor.png",
                        text1: "Dr. Full Name",
                        text2: "Specialty",
                        text3: "example@gmail.com",
                        text4: "password123",
                      ),
                      SizedBox(width: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MostVisitedd extends StatefulWidget {
  final String svg;
  final String text1;
  final String text2;
  final String text3;
  final String text4;

  const MostVisitedd({
    Key? key,
    required this.svg,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
  }) : super(key: key);

  @override
  State<MostVisitedd> createState() => _MostVisiteddState();
}

class _MostVisiteddState extends State<MostVisitedd> {
  bool isExpanded = false;
  bool isActivated = true;

  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void toggleSwitch() {
    setState(() {
      isActivated = !isActivated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(

      alignment: Alignment.topCenter,
      child: InkWell(
        onTap: toggleExpand,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: 300.0,
          height: isExpanded ? 200 : 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Color(0xffE6E6E6),
                spreadRadius: 1.5,
                blurRadius: 0.5,
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 260.0, top: 5),
                  child: InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 46,
                        width: 46,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffF2F5F5),
                        ),
                        child: Image.asset(
                          widget.svg,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.text1,
                          style: TextStyle(
                            color: Color(0XFF202020),
                            fontSize: 24.0,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          widget.text2,
                          style: TextStyle(
                            color: Color(0XFF202020).withOpacity(0.6),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (isExpanded)
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 48),
                          child: Text(
                            widget.text3,
                            style: TextStyle(
                              color: Color(0XFF202020),
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 48),
                          child: Text(
                            widget.text4,
                            style: TextStyle(
                              color: Color(0XFF202020),
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: toggleSwitch,
                          child: Container(
                            width: 224,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.2),
                                width: 2,
                              ),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isActivated = true;
                                    });
                                  },
                                  child: Container(
                                    width: 105,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: isActivated
                                            ? Color(0xffE3F9F9)
                                            : Color(0xffFAFAFA),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomLeft: Radius.circular(20))),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Activated',
                                      style: TextStyle(
                                        color: isActivated
                                            ? Color(0xff0AA9A9)
                                            : Color(0xff202020)
                                                .withOpacity(0.7),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isActivated = false;
                                    });
                                  },
                                  child: Container(
                                    width: 115,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: isActivated
                                            ? Color(0xffFAFAFA)
                                            : Color(0xffE3F9F9),
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20))),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Deactivated',
                                      style: TextStyle(
                                        color: isActivated
                                            ? Color(0xff202020).withOpacity(0.7)
                                            : Color(0xff0AA9A9),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
