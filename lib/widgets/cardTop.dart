import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:podcast_app/services/audioService.dart';
import 'package:podcast_app/theme/theme.dart';
import 'package:podcast_app/ui/detail_podcast.dart';
import 'package:podcast_app/widgets/badge.dart';

class CardTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // AudioService.stop();
        // AudioService.start(
        //   backgroundTaskEntrypoint: _audioPlayerTaskEntryPoint,
        //   androidNotificationChannelName: 'Audio Service Demo',
        //   androidNotificationColor: 0xFF2196f3,
        //   androidNotificationIcon: 'mipmap/ic_launcher',
        //   androidEnableQueue: true,
        // );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return DetailPodcast();
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
                  'https://images.unsplash.com/photo-1625909244134-2e2412edd4cd?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
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
                      'Mengatur waktu belajar agar lebih produktir',
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
                              '12 Des 2021',
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
                              '47 menit',
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

void _audioPlayerTaskEntryPoint() async {
  AudioServiceBackground.run(() => AudioPlayerTask());
}
