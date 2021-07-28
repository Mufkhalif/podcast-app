import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:podcast_app/controller/audioController.dart';
import 'package:podcast_app/controller/popularController.dart';
import 'package:podcast_app/theme/theme.dart';
import 'package:podcast_app/widgets/cardTop.dart';
import 'package:podcast_app/widgets/cardVertical.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF7F8FA),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 400,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment
                                .bottomLeft, // 10% of the width, so there are ten blinds.
                            colors: [
                              Color(0xff2D51D0),
                              Color(0xff0B2990),
                            ], // red to yellow
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(height: 70),
                          Center(
                            child: Container(
                              width: width - 30,
                              padding: EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Search Podcast',
                                    style: regularText.copyWith(
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                  ),
                                  Icon(
                                    Icons.search,
                                    color: Colors.white.withOpacity(0.7),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Podcast in Trending',
                                  style: boldText.copyWith(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'See All',
                                  style: regularText.copyWith(
                                    color: Colors.white.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 21),
                          ListPopular(),
                          SizedBox(height: 31),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recommend for your',
                          style: boldText.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'See All',
                          style: regularText.copyWith(
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 21),
                  CardVertical(),
                  CardVertical(),
                  CardVertical(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ListPopular extends StatelessWidget {
  final PopularController popularC = Get.put(PopularController());
  final AudioController aC = Get.put(AudioController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      child: GetBuilder<PopularController>(
        builder: (_) {
          return ListView.builder(
            itemCount: popularC.list.length,
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return CardTop(
                item: popularC.list[index],
                queueList: popularC.list,
              );
            },
          );
        },
      ),
    );
  }
}
