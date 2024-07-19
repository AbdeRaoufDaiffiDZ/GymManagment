import 'package:flutter/material.dart';

class userPerRegion extends StatelessWidget {
  const userPerRegion({
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
                "Users per region",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color(0xff2020202).withOpacity(0.65),
                    fontSize: 20),
              ),
            ),
            Row(
              children: [
                userss(
                  svg: "16",
                  text1: "100",
                  text2: "Algiers",
                ),
                SizedBox(width: 30),
                userss(
                  svg: "35",
                  text1: "100",
                  text2: "Boumerdes",
                ),
                SizedBox(width: 30),
                userss(
                  svg: "31",
                  text1: "2356321",
                  text2: "Oran",
                )
              ],
            )
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
                    shape: BoxShape.circle, color: Color(0xffE8EDED)),
                child: Center(
                  child: Text(
                    svg,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                )),
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
