// ignore_for_file:prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors,file_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_utils/src/extensions/num_extensions.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_baby/controllers/homecontroller.dart';
import 'package:yes_baby/services/homeservice.dart';
import 'package:yes_baby/utils/screen_size.dart';
import 'package:yes_baby/widgets/decoration.dart';
import 'package:yes_baby/widgets/widgets.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final HomeController h = Get.find<HomeController>();

  @override
  void initState() {
    Future.delayed(0.seconds).then((value) {
      h.notify(val: false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNav(context),
      body: SafeArea(
        child: Container(
          decoration: decoration(),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              SizedBox(height: 20),
              appbar(text: 'Notifications'),
              SizedBox(height: 20),
              FutureBuilder<List>(
                future: HomeService().userNotifications(),
                builder: (ctx, d) {
                  print(d.data);
                  if (d.hasData) {
                    return ListView.builder(
                      itemCount: d.data!.length, 
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) => Container(
                        height: height(context) * 0.09,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        margin: EdgeInsets.symmetric(vertical: 5,horizontal: 2),
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                 d.data![i]['title'],
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff2D2D2D),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 3,
                                  backgroundColor: Color(0xffD2A776),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                 d.data![i]['time'].toString().replaceAll(' ', ''),
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xff2D2D2D),
                                    wordSpacing: 10,
                                  ),
                                ),
                                Text(
                                 d.data![i]['date'],
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xff2D2D2D),
                                    wordSpacing: 10,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
