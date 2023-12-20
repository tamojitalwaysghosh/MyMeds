import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/controller/task_controller.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/services/notifications.dart';
import 'package:todo_app/services/theme_services.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo_app/ui_pages/about.dart';
import 'package:todo_app/ui_pages/add_task.dart';
import 'package:todo_app/ui_pages/home.dart';
import 'package:todo_app/ui_pages/login.dart';
import 'package:todo_app/ui_pages/snack_bar.dart';
import 'package:todo_app/ui_pages/theme.dart';
import 'package:todo_app/ui_pages/widgets/button.dart';
import 'package:todo_app/ui_pages/widgets/task_tile.dart';
import 'package:todo_app/ui_pages/widgets/text_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime selecteddate = DateTime.now();
  final _taskController = Get.put(TaskController());
  NotificationsServices notificationsServices = NotificationsServices();
  //  var notifyHelper;
  @override
  void initState() {
    super.initState();
    // notifyHelper = Notify();
    notificationsServices.initializeNotification();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: myappbar(),
      backgroundColor: context.theme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            //_addTaskBar(),
            myappbar(),

            _showTasks(),
          ],
        ),
      ),
    );
  }

  _showTasks() {
    return Expanded(child: Obx(
      () {
        return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              // print(_taskController.taskList.length);
              Task task =
                  _taskController.taskList[index]; //instance of task.dart
              print(task.toJson());
              if (task.repeat == 'Daily') {
                DateTime date =
                    DateFormat.jm().parse(task.startTime.toString());
                var myTime = DateFormat("HH:mm").format(date);
                notificationsServices.scheduledNotification(
                    int.parse(myTime.toString().split(":")[0]),
                    int.parse(myTime.toString().split(":")[1]),
                    task);
                // print(myTime);
                //  });
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                          child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          )
                        ],
                      )),
                    ));
              }
              if (task.date == DateFormat.yMd().format(selecteddate)) {
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                          child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          )
                        ],
                      )),
                    ));
              } else {
                return Container();
              }
            });
      },
    ));
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 4),
      height: MediaQuery.of(context).size.height * 0.34,
      decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[400]),
          ),
          SizedBox(
            height: 20,
          ),
          _bottomSheetButton(
              label: "My Med Details",
              onTap: () {
                //_taskController.markTaskCompleted(task.id!);
                Get.to(TaskDetails(
                  med_date: task.date.toString(),
                  med_time: task.startTime.toString(),
                  med_doc: task.note.toString(),
                  med_title: task.title.toString(),
                  med_type: task.repeat.toString(),
                ));
              },
              color: primaryClr,
              context: context),
          _bottomSheetButton(
              label: "Delete Med",
              onTap: () {
                _taskController.delete(task);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Snack(
                    imageloc: 'assets/healthcare.png',
                    title: 'Med Deleted Successfully!',
                    doc: 'Wish you a healthy life',
                  ),
                  duration: Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ));
                //  _taskController.getTasks();
                Get.back();
              },
              color: Colors.red[300]!,
              context: context),
          SizedBox(
            height: 20,
          ),
          _bottomSheetButton(
              label: "Close",
              onTap: () {
                Get.back();
              },
              color: Colors.red[300]!,
              isClose: true,
              context: context),
          SizedBox(
            height: 10,
          )
        ],
      ),
    ));
  }

  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color color,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        // color: isClose == true? Colors.red:color,
        decoration: BoxDecoration(
          border: Border.all(
              width: 2,
              color: isClose == true
                  ? Get.isDarkMode
                      ? Colors.grey[600]!
                      : Colors.grey[300]!
                  : color),
          borderRadius: BorderRadius.circular(20),
          color: isClose == true ? Colors.transparent : color,
        ),
        child: Center(
            child: Text(
          label,
          style:
              isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
        )),
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  "Today",
                  style: headingStyle,
                ),
              ],
            ),
          ),
          MyButton(
              label: "+ Add Task",
              onTap: () async {
                await Get.to(() => addTask());
                _taskController.getTasks();
              }
              //=> Get.to(addTask())
              ),
        ],
      ),
    );
  }

  myappbar() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "MediHelp",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Get.isDarkMode
                            ? Color.fromARGB(255, 227, 224, 224)
                            : Color.fromARGB(226, 64, 63, 63),
                        fontSize: 24),
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // change theme from services page
                        theme_services().switchTheme();
                        // notifying fun...

                        NotificationsServices().displayNotification(
                            title: "Theme Changed",
                            body: Get.isDarkMode
                                ? "Activated Light Theme"
                                : "Activated Dark Theme");

                        // schedul notidication based on time...............................
                        // notifyHelper.scheduledNotification();
                      },
                      child: Icon(
                        Get.isDarkMode
                            ? Icons.nightlight_round
                            : Icons.wb_sunny_outlined,
                        size: 24,
                        color: Get.isDarkMode
                            ? Color.fromARGB(255, 227, 224, 224)
                            : Color.fromARGB(226, 64, 63, 63),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(About());
                      },
                      child: Icon(
                        Icons.info_outline,
                        size: 24,
                        color: Get.isDarkMode
                            ? Color.fromARGB(255, 227, 224, 224)
                            : Color.fromARGB(226, 64, 63, 63),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 24, right: 24),
          child: DatePicker(
            DateTime.now(),
            height: 90,
            width: 60,
            initialSelectedDate: DateTime.now(),
            selectionColor: primaryClr,
            selectedTextColor: Colors.white,
            dateTextStyle: GoogleFonts.lato(
              textStyle: const TextStyle(
                //fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            dayTextStyle: GoogleFonts.lato(
              textStyle: const TextStyle(
                //fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            monthTextStyle: GoogleFonts.lato(
              textStyle: const TextStyle(
                // fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            onDateChange: (date) {
              //_selectedDate = date;
              setState(() {
                selecteddate = date;
              });
            },
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18, right: 18, bottom: 20),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.08,
            decoration: BoxDecoration(
                color: Get.isDarkMode ? Colors.black26 : Colors.white,
                borderRadius: BorderRadius.circular(10)),
            child: Stack(
              children: [
                Positioned(
                  child: Image(
                    image: AssetImage('assets/healthcare.png'),
                    height: 100,
                    width: 100,
                  ),
                  bottom: -40,
                  left: -40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 50,
                          width: 50,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Your MediPlan for \n    " +
                              DateFormat.yMMMd().format(selecteddate),
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: primaryClr,
                                fontSize: 13),
                          ),
                        )),
                    GestureDetector(
                      onTap: () async {
                        await Get.to(() => addTask());
                        _taskController.getTasks();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                              color: primaryClr,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextWidget(
                                  fontsize: 15,
                                  fontweight: FontWeight.w500,
                                  text: "+ Add Med",
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
