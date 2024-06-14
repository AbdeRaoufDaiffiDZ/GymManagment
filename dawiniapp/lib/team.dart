import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Team extends StatefulWidget {
  const Team({super.key});

  @override
  State<Team> createState() => _TeamState();
}

class _TeamState extends State<Team> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final widthh = constraints.maxWidth;
      final heightt = constraints.maxHeight;
      return Scaffold(
        backgroundColor: Color(0xffFAFAFA),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: widthh * 0.04, top: heightt * 0.03),
              width: (0.5 * widthh) * 0.23,
              height: (0.5 * heightt) * 0.23,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffECF2F2),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Center(
                  child: Icon(
                    Icons.arrow_back,
                    size: 25.sp,
                    color: const Color(0xff0AA9A9),
                  ),
                ),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(left: widthh * 0.04, bottom: heightt * 0.027),
              width: widthh,
              child: Text(
                "Our Team",
                style: TextStyle(
                    color: Color(0xff202020),
                    fontFamily: "Nunito",
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) => Container(
                height: heightt * 0.36,
                width: widthh,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color:
                                    const Color(0xff202020).withOpacity(0.22),
                                blurRadius: 1,
                                spreadRadius: 0.2)
                          ],
                        ),
                        width: widthh,
                        height: heightt * 0.1,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              height: 43.w,
                              width: 43.w,
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/images/spa.jpeg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      final heighttt = constraints.maxHeight;
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: heighttt * 0.34,
                                            child: Text(
                                              "Daiffi Abderaouf",
                                              style: TextStyle(
                                                  color: Color(0xff202020),
                                                  fontFamily: "Nunito",
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            height: heighttt * 0.33,
                                            child: Text(
                                              "Founder & CEO",
                                              style: TextStyle(
                                                  fontFamily: "Nunito",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xff202020)
                                                      .withOpacity(0.7)),
                                            ),
                                          ),
                                          Container(
                                            height: heighttt * 0.33,
                                            child: Text(
                                              "Mobile apps developer",
                                              style: TextStyle(
                                                  fontFamily: "Nunito",
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xff202020)
                                                      .withOpacity(0.7)),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                )),
                            Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  color:
                                      const Color(0xff202020).withOpacity(0.7),
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                ))
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(top: heightt * 0.0099),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color:
                                    const Color(0xff202020).withOpacity(0.22),
                                blurRadius: 1,
                                spreadRadius: 0.2)
                          ],
                        ),
                        width: widthh,
                        height: heightt * 0.1,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              height: 43.w,
                              width: 43.w,
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/images/spa.jpeg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      final heighttt = constraints.maxHeight;
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: heighttt * 0.34,
                                            child: Text(
                                              "Daiffi Abderaouf",
                                              style: TextStyle(
                                                  color: Color(0xff202020),
                                                  fontFamily: "Nunito",
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            height: heighttt * 0.33,
                                            child: Text(
                                              "Founder & CEO",
                                              style: TextStyle(
                                                  fontFamily: "Nunito",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xff202020)
                                                      .withOpacity(0.7)),
                                            ),
                                          ),
                                          Container(
                                            height: heighttt * 0.33,
                                            child: Text(
                                              "Mobile apps developer",
                                              style: TextStyle(
                                                  fontFamily: "Nunito",
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xff202020)
                                                      .withOpacity(0.7)),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                )),
                            Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  color:
                                      const Color(0xff202020).withOpacity(0.7),
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                ))
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(top: heightt * 0.0099),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color:
                                    const Color(0xff202020).withOpacity(0.22),
                                blurRadius: 1,
                                spreadRadius: 0.2)
                          ],
                        ),
                        width: widthh,
                        height: heightt * 0.1,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              height: 43.w,
                              width: 43.w,
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/images/spa.jpeg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      final heighttt = constraints.maxHeight;
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: heighttt * 0.34,
                                            child: Text(
                                              "Daiffi Abderaouf",
                                              style: TextStyle(
                                                  color: Color(0xff202020),
                                                  fontFamily: "Nunito",
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            height: heighttt * 0.33,
                                            child: Text(
                                              "Founder & CEO",
                                              style: TextStyle(
                                                  fontFamily: "Nunito",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xff202020)
                                                      .withOpacity(0.7)),
                                            ),
                                          ),
                                          Container(
                                            height: heighttt * 0.33,
                                            child: Text(
                                              "Mobile apps developer",
                                              style: TextStyle(
                                                  fontFamily: "Nunito",
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xff202020)
                                                      .withOpacity(0.7)),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                )),
                            Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  color:
                                      const Color(0xff202020).withOpacity(0.7),
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
