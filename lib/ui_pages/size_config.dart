import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icon.dart';

class MYqu extends StatefulWidget {
  @override
  _MYquState createState() => _MYquState();
}

class _MYquState extends State<MYqu> {
  String _quote = '';

  @override
  void initState() {
    super.initState();

    _fetchQuote();
  }

  Future<void> _fetchQuote() async {
    final response =
        await http.get(Uri.parse('https://api.quotable.io/random'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      setState(() {
        _quote = data['content'] +
            '                                                                                                        - ' +
            data['author'];
      });
    } else {
      throw Exception('Failed to fetch quote');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Quote Generator',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Random Quote Generator'),
        ),
        body: Container(
          //height: 200,
          margin: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Get.isDarkMode
                ? Color.fromARGB(255, 74, 73, 73)
                : Color.fromARGB(255, 240, 241, 245),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _quote.isNotEmpty
                      ? Column(
                          children: [
                            SizedBox(
                              height: 24,
                            ),
                            Text(_quote,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      color: Get.isDarkMode
                                          ? Color.fromARGB(255, 40, 40, 40)
                                          : Colors.black,
                                      fontWeight: FontWeight.w500),
                                )),
                          ],
                        )
                      : CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Container(
                    height: 40,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 0.3, color: Colors.black),
                      color: Get.isDarkMode
                          ? Color.fromARGB(255, 74, 73, 73)
                          : Color.fromARGB(255, 240, 241, 245),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: _fetchQuote,
                            icon: LineIcon(
                              Icons.refresh,
                              size: 20,
                              color: Colors.black,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
