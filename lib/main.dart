import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:podcast_app/ui/detail_podcast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AudioServiceWidget(
        child: DetailPodcast(),
      ),
    );
  }
}
