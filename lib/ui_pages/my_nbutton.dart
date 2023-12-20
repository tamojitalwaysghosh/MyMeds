import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/ui_pages/theme.dart';

class Botton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const Botton({Key? key, required this.label, this.onTap}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 200,
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.carme(
              textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 227, 224, 224),
                  fontSize: 18),
            ),
          ),
        ),
        height: 60,
        width: 180,
        decoration: BoxDecoration(
          color: primaryClr,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            const BoxShadow(
              color: Colors.grey,
              offset: Offset(4, 4),
              blurRadius: 15,
              spreadRadius: 1,
            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    );
  }
}
