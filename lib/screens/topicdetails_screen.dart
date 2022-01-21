//ignore_for_file:prefer_const_constructors,prefer_const_literals_to_create_immutables,import_of_legacy_library_into_null_safe

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:yes_baby/controllers/homecontroller.dart';
import 'package:yes_baby/utils/screen_size.dart';
import 'package:yes_baby/widgets/cards.dart';
import 'package:yes_baby/widgets/decoration.dart';

class TopicDetailScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const TopicDetailScreen({required this.topicId});
  final String topicId;

  @override
  State<TopicDetailScreen> createState() => _TopicDetailScreenState();
}

class _TopicDetailScreenState extends State<TopicDetailScreen> {
  final HomeController homeController = Get.find<HomeController>();
  int topicBannerIndex = 0;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () {
      homeController.getTopicDetails(topicId: widget.topicId);
    });
    super.initState();
  }

  @override
  void dispose() {
    homeController.player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder(
          init: HomeController(),
          builder: (_) => Container(
            decoration: decoration(),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: homeController.topicDetailed == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    children: [
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.arrow_back_ios,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      CarouselSlider.builder(
                        itemCount: 6,
                        itemBuilder: (ctx, index) => Container(
                          width: width(context),
                          // padding: EdgeInsets.symmetric(horizontal: 10),
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: index == 0
                                  ? CachedNetworkImageProvider(homeController
                                      .topicDetailed['title_image'])
                                  : CachedNetworkImageProvider(homeController
                                      .topicDetailed['image_$index']),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        options: CarouselOptions(
                            height: height(context) * 0.26,
                            viewportFraction: 1,
                            enableInfiniteScroll: false,
                            onPageChanged: (i, r) {
                              setState(() {
                                topicBannerIndex = i;
                              });
                            }
                            // autoPlay: true,
                            ),
                      ),
                      Center(
                        child: SizedBox(
                          height: 20,
                          child: ListView.builder(
                            itemCount: 6,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (ctx, i) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              child: CircleAvatar(
                                radius: topicBannerIndex == i ? 3 : 2,
                                backgroundColor: topicBannerIndex == i
                                    ? Color(0xff587391)
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      imagetextCol(
                        context,
                        heading: homeController.topicDetailed['title'],
                        // image: homeController.topicDetails['title_image'],
                        text: homeController.topicDetailed['description'],
                      ),
                      SizedBox(height: 20),
                      Stack(
                        children: [
                          SizedBox(
                            height: height(context) * 0.26,
                            child: VideoPlayer(
                              homeController.player,
                            ),
                          ),
                          Positioned(
                            top: height(context) * 0.1,
                            left: width(context) * 0.36,
                            child: InkWell(
                              onTap: () {
                                homeController.playVideo();
                              },
                              child: Container(
                                color: Colors.black26,
                                child: Center(
                                  child: Icon(
                                    homeController.player.value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.white,
                                    size: 50.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                homeController.getTopicDetails(
                                    topicId: homeController.previousTopic);
                              },
                              child: Container(
                                height: height(context) * 0.055,
                                width: width(context) * 0.28,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  color: Color(0xff587391),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    'Previous',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                homeController.getTopicDetails(
                                    topicId: homeController.nextTopic);
                              },
                              child: Container(
                                height: height(context) * 0.055,
                                // width: width(context) * 0.32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  color: Color(0xff587391),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    'Next',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height(context) * 0.05),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
