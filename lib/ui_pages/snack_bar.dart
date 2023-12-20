import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Snack extends StatelessWidget {
  final String imageloc;
  final String title;
  final String doc;
  const Snack(
      {super.key,
      required this.imageloc,
      required this.title,
      required this.doc});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 120,
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          ClipRRect(
            //borderRadius: BorderRadius.circular(15.0),
            child: Image(
              image: AssetImage(imageloc),
              height: 80,
              width: 80,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            width: 40,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 239, 236, 236),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      doc,
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 239, 236, 236),
                        ),
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          // color: Colors.redAccent,
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 239, 236, 236),
            Color.fromARGB(255, 239, 236, 236),
            Colors.redAccent,
            Colors.redAccent,
            Colors.redAccent,
          ]),
          border: Border.all(width: 0.3, color: Colors.redAccent),
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
