import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icon.dart';

import 'medi_details.dart';

class DrugSearchScreen extends StatefulWidget {
  @override
  _DrugSearchScreenState createState() => _DrugSearchScreenState();
}

class _DrugSearchScreenState extends State<DrugSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<dynamic>? _searchResults = [];
  bool _isLoading = false;
  bool _isError = false;
  // bool _isFind = true;

  Future<List<String>> _getSuggestedDrugNames(String query) async {
    final response = await http.get(Uri.parse(
        'https://api.fda.gov/drug/label.json?search=openfda.brand_name:${query.trim()}&limit=5'));

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final results = decodedResponse['results'] as List<dynamic>;
      return results.map<String>((result) {
        return result['openfda']['brand_name'][0];
      }).toList();
    } else {
      return [];
    }
  }

  Future<void> _searchDrugs(String query) async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(Uri.parse(
        'https://api.fda.gov/drug/label.json?search=openfda.brand_name:"$query"&limit=10'));

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      setState(() {
        _searchResults = decodedResponse['results'];
        _isLoading = false;
        _isError = false;
      });
    } else if (_searchResults!.isEmpty) {
      setState(() {
        _isError = true;
        _isLoading = false;
      });
    } else {
      setState(() {
        _searchResults = [];
        _isLoading = false;
        _isError = true;
      });
      throw Exception('Failed to search drugs');
    }
  }

  void _navigateToDrugDetails(dynamic drug) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DrugDetailsScreen(drug: drug),
      ),
    );
  }

  String _quote = '';
  bool _isO = false;

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
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Container(
                decoration: BoxDecoration(
                  //color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  color: Get.isDarkMode
                      ? Color.fromARGB(255, 74, 73, 73)
                      : Color.fromARGB(255, 240, 241, 245),

                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 228, 220, 220),
                      offset: Offset(-0, -0),
                      blurRadius: 2,
                      spreadRadius: 0.05,
                    ),
                    BoxShadow(
                      color: Color.fromARGB(255, 217, 209, 209),
                      offset: Offset(1, 1),
                      blurRadius: 2,
                      spreadRadius: 0.05,
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  cursorColor: Color.fromARGB(255, 44, 44, 44),
                  decoration: InputDecoration(
                    labelText: "Search for a medicine...",
                    labelStyle: TextStyle(
                      fontFamily: 'Comfortaa',
                      letterSpacing: 1.23,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Get.isDarkMode
                          ? Color.fromARGB(255, 240, 241, 245)
                          : Color.fromARGB(255, 74, 73, 73),
                    ),
                    hintText: "Enter the medicine name",
                    hintStyle: TextStyle(
                      fontFamily: 'Comfortaa',
                      letterSpacing: 1.16,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Get.isDarkMode
                          ? Color.fromARGB(255, 240, 241, 245)
                          : Color.fromARGB(255, 74, 73, 73),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
                    fillColor: Colors.transparent,
                    filled: true,
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(12),
                    // borderSide: BorderSide(
                    //  width: 0.8,
                    //)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          width: 2,
                          color: Get.isDarkMode
                              ? Color.fromARGB(255, 240, 241, 245)
                              : Color.fromARGB(255, 74, 73, 73),
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.transparent,
                        )),

                    suffixIcon: IconButton(
                      onPressed: () async {
                        await _searchDrugs(_searchQuery);
                      },
                      icon: Icon(
                        Icons.search,
                        color: Get.isDarkMode
                            ? Color.fromARGB(255, 240, 241, 245)
                            : Color.fromARGB(255, 74, 73, 73),
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _isError = false;
                      //_isFind = true;
                    });
                  },
                  onChanged: (value) async {
                    if (_searchController.text == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("data")),
                      );
                    } else {
                      setState(() {
                        _searchQuery = value;
                      });
                    }
                  },
                  onSubmitted: (value) async {
                    if (_searchController.text == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("data")),
                      );
                    } else {
                      await _searchDrugs(_searchQuery);
                    }
                  },
                ),
              ),
            ),
            _searchController.text.isEmpty
                ? Container(
                    margin: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 0.3,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                      color: Get.isDarkMode
                          ? Color.fromARGB(255, 74, 73, 73)
                          : Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _quote.isNotEmpty
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(_quote,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.abhayaLibre(
                                            textStyle: TextStyle(
                                                fontSize: 24,
                                                color: Get.isDarkMode
                                                    ? Color.fromARGB(
                                                        255, 247, 246, 246)
                                                    : Colors.black,
                                                fontWeight: FontWeight.w500),
                                          )),
                                    ],
                                  )
                                : CircularProgressIndicator(
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                            SizedBox(height: 20),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    width: 0.3,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  color: Colors.transparent),
                              child: IconButton(
                                  onPressed: _fetchQuote,
                                  icon: LineIcon(
                                    Icons.refresh,
                                    size: 20,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : _isError == true
                    ? Column(
                        children: [
                          Image(
                            image: AssetImage('assets/none.png'),
                            width: 163,
                            height: 163,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                              "      Sorry, Nothing found by that name\nPlease try to re-check the medicine name"),
                        ],
                      )
                    : FutureBuilder<List<String>>(
                        future: _getSuggestedDrugNames(_searchQuery),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final suggestedDrugNames = snapshot.data!;
                            return Expanded(
                              child: ListView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Suggestions',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300,
                                        color: Get.isDarkMode
                                            ? Color.fromARGB(255, 112, 111, 111)
                                                .withOpacity(0.73)
                                            : Color.fromARGB(
                                                255, 105, 104, 104),
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: suggestedDrugNames.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final suggestedDrugName =
                                          suggestedDrugNames[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 3),
                                        child: GestureDetector(
                                          onTap: () async {
                                            _searchController.text =
                                                suggestedDrugName;
                                            setState(() {
                                              _searchQuery = suggestedDrugName;
                                              //_isFind = false;
                                            });
                                            await _searchDrugs(_searchQuery);
                                          },
                                          child: Container(
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Get.isDarkMode
                                                  ? Color.fromARGB(
                                                      255, 74, 73, 73)
                                                  : Color.fromARGB(
                                                      255, 240, 241, 245),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      suggestedDrugName,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Get.isDarkMode
                                                            ? Colors.white
                                                                .withOpacity(
                                                                    0.73)
                                                            : Color.fromARGB(
                                                                255,
                                                                92,
                                                                91,
                                                                91),
                                                      ),
                                                    ),
                                                    Icon(Icons
                                                        .arrow_forward_ios_rounded)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          } else if (snapshot.hasData == false) {
                            return Text("loading...");
                          } else {
                            return Text('');
                          }
                        },
                      ),
            Expanded(
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                    )
                  : _searchController.text.isEmpty
                      ? Text('')
                      : _isError == true
                          ? Text('')
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1,
                                        color: Color.fromARGB(
                                            255, 243, 241, 241))),
                                child: ListView(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Search Results:',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300,
                                          color: Get.isDarkMode
                                              ? Color.fromARGB(
                                                      255, 112, 111, 111)
                                                  .withOpacity(0.73)
                                              : Color.fromARGB(
                                                  255, 105, 104, 104),
                                        ),
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: _searchResults?.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final drug = _searchResults![index];
                                        return ListTile(
                                          title: Text(
                                              drug['openfda']['brand_name'][0]),
                                          subtitle: Text(drug['openfda']
                                              ['generic_name'][0]),
                                          onTap: () {
                                            _navigateToDrugDetails(drug);
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
            ),
          ],
        ),
      ),
    );
  }
}
