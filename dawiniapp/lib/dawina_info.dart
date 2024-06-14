import 'package:dawini_full/team.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DawinaInfo extends StatefulWidget {
  const DawinaInfo({super.key});

  @override
  State<DawinaInfo> createState() => _DawinaInfoState();
}

class _DawinaInfoState extends State<DawinaInfo> {
  String _selectedLanguage = "FR"; // Variable to track selected language

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final widthh = constraints.maxWidth;
            final heightt = constraints.maxHeight;
            return Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: widthh - 53),
                      child: InkWell(
                        onTap: () {},
                        customBorder: const CircleBorder(),
                        child: Ink(
                          height: heightt * 0.055,
                          width: heightt * 0.055,
                          decoration: const BoxDecoration(
                            color: Color(0xffECF2F2),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.close,
                              color: Color(0xff0AA9A9),
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: heightt * 0.07,
                      width: widthh,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          "General",
                          style: TextStyle(
                              fontFamily: "Nunito",
                              color: Color(0xff202020),
                              fontWeight: FontWeight.w600,
                              fontSize: 22),
                        ),
                      ),
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) => Container(
                        height: heightt * 0.34,
                        width: widthh,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                margin:
                                    EdgeInsets.only(bottom: heightt * 0.004),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xff202020)
                                          .withOpacity(0.1),
                                      blurRadius: 1,
                                    )
                                  ],
                                ),
                                width: widthh,
                                height: heightt * 0.08,
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      height: 37,
                                      width: 37,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Image.asset(
                                          "assets/images/bb.png",
                                          color: const Color(0xff202020)
                                              .withOpacity(0.7),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Text(
                                        "What is Dawina ?",
                                        style: TextStyle(
                                          fontFamily: "Nunito",
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          color: const Color(0xff202020)
                                              .withOpacity(0.7),
                                          Icons.arrow_forward_ios,
                                          size: 18,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => Team())));
                              },
                              child: Container(
                                margin:
                                    EdgeInsets.only(bottom: heightt * 0.004),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xff202020)
                                          .withOpacity(0.1),
                                      blurRadius: 1,
                                    )
                                  ],
                                ),
                                width: widthh,
                                height: heightt * 0.08,
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      height: 37,
                                      width: 37,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Image.asset(
                                          "assets/images/team.png",
                                          color: const Color(0xff202020)
                                              .withOpacity(0.7),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Text(
                                        "Our Team",
                                        style: TextStyle(
                                          fontFamily: "Nunito",
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          color: const Color(0xff202020)
                                              .withOpacity(0.7),
                                          Icons.arrow_forward_ios,
                                          size: 18,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: heightt * 0.004),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xff202020)
                                        .withOpacity(0.1),
                                    blurRadius: 1,
                                  )
                                ],
                              ),
                              width: widthh,
                              height: heightt * 0.08,
                              child: Row(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    height: 37,
                                    width: 37,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Image.asset(
                                        "assets/images/payment.png",
                                        color: const Color(0xff202020)
                                            .withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      "Payment",
                                      style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        color: const Color(0xff202020)
                                            .withOpacity(0.7),
                                        Icons.arrow_forward_ios,
                                        size: 18,
                                      ))
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: _launchInstagram,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 3),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xff202020)
                                          .withOpacity(0.1),
                                      blurRadius: 1,
                                    )
                                  ],
                                ),
                                width: widthh,
                                height: heightt * 0.08,
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      height: 37,
                                      width: 37,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Image.asset(
                                          "assets/images/social.png",
                                          color: const Color(0xff202020)
                                              .withOpacity(0.7),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Text(
                                        "Follow us on instagram",
                                        style: TextStyle(
                                          fontFamily: "Nunito",
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          color: const Color(0xff202020)
                                              .withOpacity(0.7),
                                          Icons.arrow_forward_ios,
                                          size: 18,
                                        ))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: heightt * 0.07,
                      width: widthh,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 15, top: 8),
                        child: Text(
                          "Contact us",
                          style: TextStyle(
                              fontFamily: "Nunito",
                              color: Color(0xff202020),
                              fontWeight: FontWeight.w600,
                              fontSize: 22),
                        ),
                      ),
                    ),
                    Container(
                      height: heightt * 0.25,
                      width: widthh,
                      child: Column(children: [
                        Container(
                          margin: EdgeInsets.only(bottom: heightt * 0.004),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xff202020).withOpacity(0.1),
                                blurRadius: 1,
                              )
                            ],
                          ),
                          width: widthh,
                          height: heightt * 0.078,
                          child: Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                height: 37,
                                width: 37,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Image.asset(
                                    "assets/images/email.png",
                                    color: const Color(0xff202020)
                                        .withOpacity(0.7),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  "Send to us by e-mail",
                                  style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    color: const Color(0xff202020)
                                        .withOpacity(0.7),
                                    Icons.arrow_forward_ios,
                                    size: 18,
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: heightt * 0.004),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xff202020).withOpacity(0.1),
                                blurRadius: 1,
                              )
                            ],
                          ),
                          width: widthh,
                          height: heightt * 0.078,
                          child: Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                height: 37,
                                width: 37,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Image.asset(
                                    "assets/images/call.png",
                                    color: const Color(0xff202020)
                                        .withOpacity(0.7),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  "Call us",
                                  style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    color: const Color(0xff202020)
                                        .withOpacity(0.7),
                                    Icons.arrow_forward_ios,
                                    size: 18,
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: heightt * 0.004),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xff202020).withOpacity(0.1),
                                blurRadius: 1,
                              )
                            ],
                          ),
                          width: widthh,
                          height: heightt * 0.078,
                          child: Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                height: 37,
                                width: 37,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Image.asset(
                                    "assets/images/feedback.png",
                                    color: const Color(0xff202020)
                                        .withOpacity(0.7),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  "Send feedback",
                                  style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    color: const Color(0xff202020)
                                        .withOpacity(0.7),
                                    Icons.arrow_forward_ios,
                                    size: 18,
                                  ))
                            ],
                          ),
                        )
                      ]),
                    ),
                    Container(
                      height: heightt * 0.1,
                      width: 200,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: Row(children: [
                            _buildLanguageContainer("EN"),
                            const Spacer(),
                            _buildLanguageContainer("FR"),
                            const Spacer(),
                            _buildLanguageContainer("AR"),
                          ])),
                    ),
                  ]),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLanguageContainer(String language) {
    bool isSelected = _selectedLanguage == language;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Ink(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xffE6FAFA) : const Color(0xffFAFAFA),
          border: Border.all(
            color: isSelected ? const Color(0xff04CBCB) : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff202020).withOpacity(0.5),
              blurRadius: 1.5,
              spreadRadius: 0,
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedLanguage = language;
            });
          },
          child: Center(
            child: Text(
              language,
              style: TextStyle(
                fontSize: 22,
                color: const Color(0xff202020).withOpacity(0.65),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _launchInstagram() async {
    const nativeUrl = "instagram://user?username=dawina.app";
    const webUrl = "https://www.instagram.com/dawina.app/";
    if (await canLaunch(nativeUrl)) {
      await launch(nativeUrl);
    } else if (await canLaunch(webUrl)) {
      await launch(webUrl);
    } else {
      print("Can't open Instagram");
    }
  }
}
