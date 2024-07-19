import 'package:flutter/material.dart';

class MostVisited extends StatelessWidget {
  const MostVisited({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                "Appointments",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xff202020).withOpacity(0.65),
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Row(
                      children: [
                        Tooltip(
                          textStyle: TextStyle(fontSize: 20),
                          decoration: BoxDecoration(
                              color: Color(0xff0AA9A9).withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10)),
                          message: "Dr.full name",
                          child: MostVisitedd(
                            svg: "assets/images/doctor.png",
                            text1: "Dr.full name",
                            text2: "Speciality",
                          ),
                        ),
                        SizedBox(width: 30),
                        Tooltip(
                          textStyle: TextStyle(fontSize: 20),
                          decoration: BoxDecoration(
                              color: Color(0xff0AA9A9).withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10)),
                          message: "Dr.full name",
                          child: MostVisitedd(
                            svg: "assets/images/doctora.png",
                            text1: "Dr.full name",
                            text2: "Speciality",
                          ),
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
      ),
    );
  }
}

class MostVisitedd extends StatelessWidget {
  final String svg;
  final String text1;
  final String text2;
  const MostVisitedd(
      {Key? key, required this.svg, required this.text1, required this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 300.0, // Adjust width as needed based on design and content
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color(0xffE6E6E6),
            spreadRadius: 1.5,
            blurRadius: 0.5,
          )
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffF2F5F5),
              ),
              child: Image.asset(
                svg,
              ),
            ),
          ),
          Expanded(
            // Wrap Text widget with Expanded for flexible sizing
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text1,
                    style: TextStyle(
                      color: Color(0XFF202020),
                      fontSize: 24.0, // Adjust font size as needed
                      overflow: TextOverflow
                          .ellipsis, // Handle overflow with ellipsis
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    text2,
                    style: TextStyle(
                      color: Color(0XFF202020).withOpacity(0.6),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
