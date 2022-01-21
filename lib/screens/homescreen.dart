//ignore_for_file:prefer_const_constructors,prefer_const_literals_to_create_immutables
// ignore: import_of_legacy_library_into_null_safe
import 'package:cached_network_image/cached_network_image.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_baby/controllers/homecontroller.dart';
import 'package:yes_baby/screens/topicdetails_screen.dart';
import 'package:yes_baby/services/firebase_messaging.dart';
import 'package:yes_baby/utils/screen_size.dart';
import 'package:yes_baby/utils/spinner.dart';
import 'package:yes_baby/widgets/cards.dart';
import 'package:yes_baby/widgets/decoration.dart';
import 'package:yes_baby/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    NotificationService().checkforMsg();
    Future.delayed(Duration(seconds: 0), () {
      homeController.getHome();
      homeController.getProfile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Spinner(
      child: Scaffold(
        key: key,
        drawer: drawer(context),
        bottomNavigationBar: bottomNav(context),
        body: SafeArea(
          child: GetBuilder(
            init: HomeController(),
            builder: (_) => Container(
              decoration: decoration(),
              child: homeController.homeLoad
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
                      children: [
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.only(left: 24, right: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      key.currentState!.openDrawer();
                                    },
                                    child: Image(
                                      height: 18,
                                      image: AssetImage('images/menu.png'),
                                    ),
                                  ),
                                  Image(
                                    height: height(context) * 0.06,
                                    image: AssetImage('images/appLogo.png'),
                                  ),
                                  homeController.profileLoad
                                      ? CircleAvatar(
                                          radius: 16,
                                        )
                                      : CircleAvatar(
                                          radius: 16,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                  homeController
                                                      .profileDetails['image']),
                                        ),
                                ],
                              ),
                              SizedBox(height: 20),
                              homeController.userDetails == null
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Welcome',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              homeController
                                                      .userDetails['name'] ??
                                                  '',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 23,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Due Date',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              homeController.userDetails[
                                                      'due_date_view'] ??
                                                  '',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                              SizedBox(height: 10),
                              CarouselSlider.builder(
                                itemCount: homeController.homeSlider.length,
                                itemBuilder: (ctx, index) => Container(
                                  width: width(context),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          homeController.homeSlider[index]
                                              ['image']),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                options: CarouselOptions(
                                  height: height(context) * 0.24,
                                  viewportFraction: 1,
                                  enableInfiniteScroll: false,
                                  // autoPlay: true,
                                ),
                              ),
                              Center(
                                child: SizedBox(
                                  height: 20,
                                  child: ListView.builder(
                                    itemCount: 3,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (ctx, i) => Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2),
                                      child: CircleAvatar(
                                        radius: 1 == i ? 3 : 2,
                                        backgroundColor: 1 == i
                                            ? Color(0xff587391)
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              homeController.userDetails == null
                                  ? Container()
                                  : Row(
                                      children: [
                                        daysContainer(
                                          context,
                                          text: 'Month',
                                          number: homeController
                                                  .userDetails['month'] ??
                                              '',
                                          power: int.parse(homeController
                                                      .userDetails['month']) >
                                                  3
                                              ? 'th'
                                              : int.parse(homeController
                                                              .userDetails[
                                                          'month']) ==
                                                      3
                                                  ? 'rd'
                                                  : int.parse(homeController
                                                                  .userDetails[
                                                              'month']) ==
                                                          2
                                                      ? 'nd'
                                                      : 'st',
                                        ),
                                        // SizedBox(width: 5),
                                        // daysContainer(
                                        //   context,
                                        //   text: 'Week',
                                        //   number: homeController
                                        //           .userDetails['week'] ??
                                        //       '',
                                        //   power: int.parse(homeController
                                        //               .userDetails['week']) >
                                        //           3
                                        //       ? 'th'
                                        //       : int.parse(homeController
                                        //                       .userDetails[
                                        //                   'week']) ==
                                        //               3
                                        //           ? 'rd'
                                        //           : int.parse(homeController
                                        //                           .userDetails[
                                        //                       'week']) ==
                                        //                   2
                                        //               ? 'nd'
                                        //               : 'st',
                                        // ),
                                      ],
                                    ),
                              SizedBox(height: 15),
                              // SizedBox(
                              //   height: height(context) * 0.05,
                              //   child: ListView.builder(
                              //     itemCount: 7,
                              //     shrinkWrap: true,
                              //     scrollDirection: Axis.horizontal,
                              //     itemBuilder: (ctx, i) => Container(
                              //       margin: EdgeInsets.only(right: 9, top: 1),
                              //       width: width(context) * 0.102,
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(11),
                              //         color: i ==
                              //                 int.parse(homeController
                              //                     .userDetails['day'])
                              //             ? Color(0xffD2A776)
                              //             : Colors.white,
                              //         boxShadow: [
                              //           BoxShadow(
                              //             color: Colors.black.withOpacity(0.2),
                              //             blurRadius: 2,
                              //           ),
                              //         ],
                              //       ),
                              //       child: Column(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.center,
                              //         children: [
                              //           Text(
                              //             'Day',
                              //             style: GoogleFonts.montserrat(
                              //               color: i ==
                              //                       int.parse(homeController
                              //                           .userDetails['day'])
                              //                   ? Colors.white
                              //                   : Color(0xffD2A776),
                              //               fontSize: 9,
                              //               fontWeight: FontWeight.w500,
                              //             ),
                              //           ),
                              //           Text(
                              //             '${i + 1}',
                              //             style: GoogleFonts.montserrat(
                              //               color: i ==
                              //                       int.parse(homeController
                              //                           .userDetails['day'])
                              //                   ? Colors.white
                              //                   : Color(0xff587391),
                              //               fontSize: 20,
                              //               fontWeight: FontWeight.w500,
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(height: 20),
                              homeController.topicDetails == null
                                  ? Container()
                                  : homeColContainer(
                                      context,
                                      heading: "Baby's growth",
                                      image: homeController
                                          .topicDetails['title_image'],
                                      text:
                                          homeController.topicDetails['title'],
                                      value: homeController
                                          .topicDetails['description'],
                                      onTap: () {
                                        Get.to(
                                          () => TopicDetailScreen(
                                              topicId: homeController
                                                  .topicDetails['topic_id']),
                                        );
                                      },
                                    ),
                              SizedBox(height: 10),
                              homeController.topicDetails1 == null
                                  ? Container()
                                  : homeColContainer(
                                      context,
                                      heading: "Physical Activity",
                                      image: homeController
                                          .topicDetails1['title_image'],
                                      text:
                                          homeController.topicDetails1['title'],
                                      value: homeController
                                          .topicDetails1['description'],
                                      onTap: () {
                                        Get.to(() => TopicDetailScreen(
                                            topicId: homeController
                                                .topicDetails1['topic_id']));
                                      },
                                    ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Image(
                            height: height(context) * 0.05,
                            fit: BoxFit.fill,
                            image: AssetImage('images/logos.png'),
                          ),
                        ),
                        SizedBox(height: height(context) * 0.03),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              homeController.wordOfGod == null
                                  ? Container()
                                  : textCol(
                                      heading:
                                          homeController.wordOfGod['title'] ??
                                              '',
                                      text: homeController
                                              .wordOfGod['description'] ??
                                          '',
                                    ),
                              SizedBox(height: height(context) * 0.04),
                              homeController.topicDetails2 == null
                                  ? Container()
                                  : homeColContainer(
                                      context,
                                      heading: "Saint's Stories",
                                      image: homeController
                                          .topicDetails2['title_image'],
                                      text:
                                          homeController.topicDetails2['title'],
                                      value: homeController
                                          .topicDetails2['description'],
                                      onTap: () {
                                        Get.to(() => TopicDetailScreen(
                                            topicId: homeController
                                                .topicDetails2['topic_id']));
                                      },
                                    ),
                              SizedBox(height: height(context) * 0.02),
                              textCol(
                                heading: homeController.prayer['title'] ?? '',
                                text:
                                    homeController.prayer['description'] ?? '',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height(context) * 0.05),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
