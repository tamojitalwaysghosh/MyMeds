import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/ui_pages/theme.dart';

class TaskDetails extends StatefulWidget {
  final String med_title;
  final String med_doc;
  final String med_date;
  final String med_time;
  final String med_type;
  const TaskDetails(
      {super.key,
      required this.med_title,
      required this.med_doc,
      required this.med_date,
      required this.med_time,
      required this.med_type});

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20, bottom: 10),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primaryClr,
                  ),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Get.isDarkMode
                            ? Colors.black
                            : Colors.white.withOpacity(0.73),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, right: 20, bottom: 10),
                child: Text(
                  "About my Med",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Get.isDarkMode
                          ? Colors.white.withOpacity(0.73)
                          : Color.fromARGB(255, 13, 13, 13),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Medicine name:',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Get.isDarkMode
                                ? Color.fromARGB(255, 227, 224, 224)
                                : Color.fromARGB(226, 64, 63, 63),
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.med_title,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Get.isDarkMode
                                ? Color.fromARGB(255, 227, 224, 224)
                                : Color.fromARGB(226, 64, 63, 63),
                            fontSize: 17),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Medicine Detals:',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Get.isDarkMode
                                ? Color.fromARGB(255, 227, 224, 224)
                                : Color.fromARGB(226, 64, 63, 63),
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.med_doc,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Get.isDarkMode
                                ? Color.fromARGB(255, 227, 224, 224)
                                : Color.fromARGB(226, 64, 63, 63),
                            fontSize: 17),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Added on:',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Get.isDarkMode
                                ? Color.fromARGB(255, 227, 224, 224)
                                : Color.fromARGB(226, 64, 63, 63),
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.med_date,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Get.isDarkMode
                                ? Color.fromARGB(255, 227, 224, 224)
                                : Color.fromARGB(226, 64, 63, 63),
                            fontSize: 17),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Time it is to be taken at:',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Get.isDarkMode
                                ? Color.fromARGB(255, 227, 224, 224)
                                : Color.fromARGB(226, 64, 63, 63),
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.med_time,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Get.isDarkMode
                                ? Color.fromARGB(255, 227, 224, 224)
                                : Color.fromARGB(226, 64, 63, 63),
                            fontSize: 17),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Type:',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Get.isDarkMode
                                ? Color.fromARGB(255, 227, 224, 224)
                                : Color.fromARGB(226, 64, 63, 63),
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.med_type,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Get.isDarkMode
                                ? Color.fromARGB(255, 227, 224, 224)
                                : Color.fromARGB(226, 64, 63, 63),
                            fontSize: 17),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
