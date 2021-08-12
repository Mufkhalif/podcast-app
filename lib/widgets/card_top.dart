import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcast_app/controller/audioController.dart';
import 'package:podcast_app/models/podcast.dart';
import 'package:podcast_app/theme/theme.dart';
import 'package:podcast_app/ui/detail_podcast/detail_podcast.dart';
import 'package:podcast_app/widgets/badge.dart';

class CardTop extends StatelessWidget {
  final PodcastModel item;
  final List<PodcastModel> queueList;

  final AudioController ac = Get.find<AudioController>();

  CardTop({
    required this.item,
    required this.queueList,
  });

  @override
  Widget build(BuildContext context) {
    var durasi = (double.parse(item.time) / 60).toString().substring(0, 3);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return DetailPodcast(item: item);
          }),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Container(
          width: 241,
          height: 301,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              14.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
                child: Image.network(
                  item.imgSrc,
                  width: 241,
                  height: 183,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Badge(),
                    SizedBox(height: 10),
                    Text(
                      item.title,
                      style: boldText.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              color: Color(0xffA0A9B5),
                              size: 16,
                            ),
                            SizedBox(width: 5),
                            Text(
                              item.date,
                              style: regularText.copyWith(
                                fontSize: 12,
                                color: Color(0xffA0A9B5),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Color(0xffA0A9B5),
                              size: 16,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '$durasi menit',
                              style: regularText.copyWith(
                                fontSize: 12,
                                color: Color(0xffA0A9B5),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
