import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui_pages/polosk.dart';
import 'package:todo_app/ui_pages/theme.dart';
import 'package:todo_app/ui_pages/widgets/text_widget.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'about.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  static Future<void> openMap(String location) async {
    String googleUrl = 'https://www.google.com/maps/search/$location';
    final Uri _url = Uri.parse(googleUrl);
    try {
      await launchUrl(_url);
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'something went wrong! call emergency number');
    }
  }

  List<bool> _isSelected = [false, true];
  bool _isTrue = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextWidget(
              color: Get.isDarkMode ? Colors.white : Colors.black,
              fontsize: 20,
              fontweight: FontWeight.w400,
              text: "Explore Nearby",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  openMap('pharmacies near me');
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryClr,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.41,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextWidget(
                          color: Colors.white,
                          fontsize: 16,
                          fontweight: FontWeight.w400,
                          text: "Pharmacy",
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Image.asset(
                          'assets/pharm.png',
                          height: 32,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  openMap('Hospitals near me');
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.41,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextWidget(
                          color: Colors.white,
                          fontsize: 16,
                          fontweight: FontWeight.w400,
                          text: "Hospitals",
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Image.asset(
                          'assets/hosp.png',
                          height: 32,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextWidget(
              color: Get.isDarkMode ? Colors.white : Colors.black,
              fontsize: 20,
              fontweight: FontWeight.w400,
              text: "Speed Dial",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 120,
            child: Police(
              title: 'Ambulance',
              subtitle: "Tap here or dial 1-0-2",
              image: "assets/e5.jpg",
              number: "102",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextWidget(
              color: Get.isDarkMode ? Colors.white : Colors.black,
              fontsize: 20,
              fontweight: FontWeight.w400,
              text: "Speed Dial",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => About(),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: primaryClr,
                borderRadius: BorderRadius.circular(20),
              ),
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      color: Colors.white,
                      fontsize: 18,
                      fontweight: FontWeight.w400,
                      text: "About Us",
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
          //Transform.scale(
          //scale: 1.2,
          //child: Switch(
          //  activeThumbImage: AssetImage('assets/healthcare.png'),
          //activeColor: Colors.orangeAccent,
          //value: _isTrue,
          //onChanged: ((value) {
          //setState(() {
          //_isTrue = !_isTrue;
          //});
          //ThemeServices().switchTheme();
          // })),
          //),
        ],
      ),
    );
  }
}
