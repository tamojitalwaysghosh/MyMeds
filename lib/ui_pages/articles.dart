import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui_pages/a1.dart';
import 'package:todo_app/ui_pages/theme.dart';
import 'package:todo_app/ui_pages/widgets/article_card.dart';
import 'package:todo_app/ui_pages/widgets/text_widget.dart';

import 'a2.dart';
import 'a3.dart';

class BlogsScreen extends StatefulWidget {
  const BlogsScreen({super.key});

  @override
  State<BlogsScreen> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: TextWidget(
                  fontsize: 24,
                  fontweight: FontWeight.w500,
                  text: "Health Articles",
                  color: Get.isDarkMode
                      ? Colors.white
                      : Color.fromARGB(255, 35, 34, 34)),
            ),
          ),
          AticleWidget(
            image: "assets/a1.jpg",
            name: "Health Tips for children",
            page: Blogs1Screen(),
            website: 'https://sm-2102.github.io/',
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                for (int i = 0; i < MediaQuery.of(context).size.width; i++)
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: CircleAvatar(
                      backgroundColor: primaryClr,
                      radius: 1,
                    ),
                  ),
              ],
            ),
          ),
          AticleWidget(
            image: "assets/a2.jpg",
            name: "Health Tips for middle aged",
            page: Blogs2Screen(),
            website: 'https://sm139.github.io/',
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                for (int i = 0; i < MediaQuery.of(context).size.width; i++)
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: CircleAvatar(
                      backgroundColor: primaryClr,
                      radius: 1,
                    ),
                  ),
              ],
            ),
          ),
          AticleWidget(
            image: "assets/a3.jpg",
            name: "Health Tips for the aged",
            page: Blogs3Screen(),
            website: 'https://dyutiprovo.github.io/',
          ),
        ],
      ),
    );
  }
}
