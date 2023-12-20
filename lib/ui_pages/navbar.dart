import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:todo_app/ui_pages/homepage.dart';
import 'package:todo_app/ui_pages/theme.dart';

import 'articles.dart';
import 'home.dart';
import 'medicine_search.dart';
import 'near.dart';

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  int _selectedIndex = 0;
  static TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    BlogsScreen(),
    MyWidget(),
    DrugSearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Color.fromARGB(255, 255, 255, 255),
            hoverColor: Color.fromARGB(255, 255, 255, 255),
            gap: 8,
            activeColor: context.theme.backgroundColor,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: Duration(milliseconds: 400),
            tabBackgroundColor: primaryClr,
            color: Colors.black,
            tabs: [
              GButton(
                icon: LineIcons.home,
                iconColor: Get.isDarkMode ? Colors.white : Colors.black,
                //text: 'Home',
              ),
              GButton(
                icon: LineIcons.newspaperAlt,
                iconColor: Get.isDarkMode ? Colors.white : Colors.black,
                //text: 'Blogs',
              ),
              GButton(
                icon: LineIcons.phone,
                iconColor: Get.isDarkMode ? Colors.white : Colors.black,
                //text: 'Profile',
              ),
              GButton(
                icon: LineIcons.search,
                iconColor: Get.isDarkMode ? Colors.white : Colors.black,
                //text: 'Search',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
