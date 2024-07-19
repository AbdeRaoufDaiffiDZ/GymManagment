import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class appointments extends StatelessWidget {
  const appointments({
    Key? key,
  }) : super(key: key);

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
                    fontSize: 20),
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
                        userss(
                          svg: "assets/icons/ad.svg",
                          text1: "100",
                          text2: "Total booking",
                        ),
                        SizedBox(width: 30),
                        userss(
                          svg: "assets/icons/ssa.svg",
                          text1: "100",
                          text2: "Bookings by patients",
                        ),
                        SizedBox(width: 30),
                        userss(
                          svg: "assets/icons/sc.svg",
                          text1: "100",
                          text2: "Bookings by doctors",
                        ),
                        SizedBox(width: 30),
                        userss(
                          svg: "assets/icons/qq.svg",
                          text1: "100",
                          text2: "Average booking",
                        ),
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

class userss extends StatelessWidget {
  final String svg;
  final String text1;
  final String text2;
  const userss(
      {Key? key, required this.svg, required this.text1, required this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 300,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Color(0xffE6E6E6), spreadRadius: 1.5, blurRadius: 0.5)
          ]),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Container(
              height: 46,
              width: 46,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xffD3FBF6)),
              child: SvgPicture.asset(
                svg,
                fit: BoxFit.scaleDown,
                colorFilter: ColorFilter.mode(
                    Color(0xff202020).withOpacity(0.7), BlendMode.srcIn),
                height: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1,
                  style: TextStyle(
                    color: Color(0XFF202020),
                    fontSize: 28,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  text2,
                  style: TextStyle(
                    color: Color(0XFF202020).withOpacity(0.6),
                    fontSize: 15,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
