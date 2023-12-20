import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/ui_pages/theme.dart';

class DrugDetailsScreen extends StatelessWidget {
  final dynamic drug;

  const DrugDetailsScreen({Key? key, required this.drug}) : super(key: key);

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
                  "Medicine Details",
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
                Text(
                  drug['openfda']['brand_name'][0],
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Generic name:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode
                            ? Colors.white.withOpacity(0.73)
                            : Color.fromARGB(255, 13, 13, 13),
                      ),
                    ),
                    Text(
                      '${drug['openfda']['generic_name'][0]}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Get.isDarkMode
                            ? Colors.white.withOpacity(0.73)
                            : Color.fromARGB(255, 13, 13, 13),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Manufacturer:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode
                            ? Colors.white.withOpacity(0.73)
                            : Color.fromARGB(255, 13, 13, 13),
                      ),
                    ),
                    Text(
                      '${drug['openfda']['manufacturer_name'][0]}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Get.isDarkMode
                            ? Colors.white.withOpacity(0.73)
                            : Color.fromARGB(255, 13, 13, 13),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Indications and usage:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode
                            ? Colors.white.withOpacity(0.73)
                            : Color.fromARGB(255, 13, 13, 13),
                      ),
                    ),
                    Text(
                      'Indications and usage: ${drug['indications_and_usage'][0]}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Get.isDarkMode
                            ? Colors.white.withOpacity(0.73)
                            : Color.fromARGB(255, 13, 13, 13),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dosage and administration:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode
                            ? Colors.white.withOpacity(0.73)
                            : Color.fromARGB(255, 13, 13, 13),
                      ),
                    ),
                    Text(
                      '${drug['dosage_and_administration'][0]}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Get.isDarkMode
                            ? Colors.white.withOpacity(0.73)
                            : Color.fromARGB(255, 13, 13, 13),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Warnings:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode
                            ? Colors.white.withOpacity(0.73)
                            : Color.fromARGB(255, 13, 13, 13),
                      ),
                    ),
                    Text(
                      '${drug['warnings'][0]}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Get.isDarkMode
                            ? Colors.white.withOpacity(0.73)
                            : Color.fromARGB(255, 13, 13, 13),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Disclaimar: All the data is shown using the OpenFDA api and the developer does not hold any rights in them.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Get.isDarkMode
                        ? Color.fromARGB(255, 196, 194, 194)
                        : Color.fromARGB(255, 187, 186, 186),
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
