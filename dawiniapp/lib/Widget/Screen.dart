/*import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Containe extends StatefulWidget {
  Containe({Key? key}) : super(key: key);

  @override
  State<Containe> createState() => _ContainState();
}

class _ContainState extends State<Containe> {
  PageController mycon = PageController(viewportFraction: 0.7.w);
  int selectedindex = 0;
  String? selectedValue;
  late Timer timer;
  int selectedindex2 = 0;
  final cc = [
    Image.asset(
      "images/pp.png",
      fit: BoxFit.cover,
    ),
    Image.asset("images/xx.png"),
    Image.asset("images/cc.png")
  ];

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    timer = Timer.periodic(const Duration(seconds: 4), (timez) {
      if (mycon.hasClients) {
        mycon.animateToPage(
          (mycon.page!.toInt() + 1) % cc.length,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mylist = [
      {"text": "Generalist", "icon": Icons.home},
      {"text": " Dentist", "icon": Icons.work},
      {"text": " Ophtahlam", "icon": Icons.school},
      {"text": " azheme", "icon": Icons.access_alarms_sharp},
      {"text": " Endocrino", "icon": Icons.access_time_filled_rounded},
      {"text": " Cardiology", "icon": Icons.padding_outlined},
      {"text": " Cardiology", "icon": Icons.zoom_in_map},
      {"text": " Cardiology", "icon": Icons.cabin},
    ];

    final items = [
      "Alger",
      "Boumerdes",
      "Oran",
      "chlef",
      "Bejaia",
      " Annaba",
      " Bouira"
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          iconSize: 26,
          unselectedFontSize: 14,
          selectedFontSize: 17,
          currentIndex: selectedindex2,
          onTap: (value) {
            setState(() {
              selectedindex2 = value;
            });
          },
          elevation: 20,
          selectedItemColor: Color(0xFF2CDBC6),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.medication_outlined),
                label: "My Appointement"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favorite")
          ]),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Row(children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 15.w, left: 10.h),
                  child: Container(
                    height: 45.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0XFF202020).withOpacity(0.25),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            size: 26.w,
                            color: const Color(0xFF2CDBC6),
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search for a doctor or clinic',
                                hintStyle: TextStyle(fontSize: 20.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Province',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: items
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 45.h,
                      width: 120.w,
                      padding: EdgeInsets.only(left: 14.w, right: 14.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF2CDBC6),
                        ),
                        color: const Color(0xFF2CDBC6),
                      ),
                      elevation: 1,
                    ),
                    iconStyleData: IconStyleData(
                      icon: const Icon(
                        Icons.arrow_downward_outlined,
                      ),
                      iconSize: 14.w,
                      iconEnabledColor: Colors.white,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.teal.shade100,
                      ),
                      offset: Offset(-10.w, 0.h),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(20),
                        thickness: MaterialStateProperty.all(8),
                        thumbVisibility: MaterialStateProperty.all(true),
                        interactive: true,
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 12, right: 14),
                    ),
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 11.w),
              child: Text("Recommended clinics",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
            ),
          ),
          SizedBox(height: 10.h),

          Container(
            color: Colors.white,
            height: 150.h,
            width: double.infinity,
            child: PageView.builder(
              onPageChanged: (int index) {
                setState(() {
                  selectedindex = index;
                });
              },
              controller: mycon,
              itemCount: cc.length,
              itemBuilder: (context, index) {
                double scale = selectedindex == index ? 1.1 : 0.8;

                return TweenAnimationBuilder(
                  tween: Tween<double>(begin: scale, end: scale),
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeIn,
                  builder: (context, double value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Container(
                        height: 60,
                        margin: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.grey.shade300,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: Container(
                                width: 120.w,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset(
                                  "images/pp.png",
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.w, top: 15.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Clinic name example",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 50.h),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        size: 16.w,
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        "Contacts info",
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 16.w,
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        "City , Province",
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 2.w),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          color: const Color(0xFF2CDBC6),
                                          size: 16.w,
                                        ),
                                        SizedBox(width: 5.w),
                                        Text(
                                          " At Service",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 13.w),
                child: Text(
                  "Specialty",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(width: 200.w),
              Text(
                "Search",
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2CDBC6)),
              ),
            ],
          ),
          Container(
            height: 100.h,
            child: ListView.builder(
              itemCount: mylist.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
                  child: Column(
                    children: [
                      Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                        ),
                        child: IconButton(
                          icon: Icon(
                            mylist[index]["icon"] as IconData,
                            color: Colors.teal,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Text(
                        mylist[index]["text"] as String,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
            ),
          ),
          // const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(bottom: 8.h, left: 11.w),
            child: Row(
              children: [
                Text("Recommended doctors",
                    style: TextStyle(
                        fontSize: 20.sp, fontWeight: FontWeight.w600)),
                SizedBox(width: 70.w),
                Text("See All",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2CDBC6)))
              ],
            ),
          ),
          //  SizedBox(height: 12),

          GestureDetector(
            onTap: () {
              print("OK");
            },
            child: Container(
              margin: const EdgeInsets.only(
                  top: 1), // Adjust the top margin as needed
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns in the grid
                    crossAxisSpacing: 1.w, // Spacing between columns
                    mainAxisSpacing: 1.h, // Spacing between rows
                    mainAxisExtent: 320),
                itemCount: 6, // Number of items in the grid
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.only(
                          left: 6.w, right: 6.w, top: 14.h, bottom: 14.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey, // Set the border color
                          width: 1.w, // Set the border width
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            color: Colors.grey.withOpacity(0.3),
                            height: 130.h,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.w),
                            child: Text(
                              "Dr.name exepmle",
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w800),
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.w),
                            child: Text(
                              "Speciality",
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 18.sp,
                                  color: Colors.black45,
                                ),
                                Text(
                                  "City , province",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: Row(
                              children: [
                                Icon(Icons.circle,
                                    size: 16.w, color: Colors.teal),
                                Text(
                                  "At service ",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/