import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcast_app/controller/audioController.dart';
import 'package:podcast_app/models/audio_model.dart';
import 'package:podcast_app/models/podcast_model.dart';
import 'package:podcast_app/services/audioService.dart';
import 'package:podcast_app/theme/theme.dart';
import 'package:podcast_app/widgets/seekerBar.dart';
import 'package:rxdart/rxdart.dart' as Rx;

class DetailPodcast extends StatefulWidget {
  final PodcastModel item;

  DetailPodcast({required this.item});
  @override
  _DetailPodcastState createState() => _DetailPodcastState();
}

class _DetailPodcastState extends State<DetailPodcast> {
  final AudioController ac = Get.find<AudioController>();

  Stream<MediaState> get _mediaStateStream =>
      Rx.Rx.combineLatest2<MediaItem?, Duration, MediaState>(
          AudioService.currentMediaItemStream,
          AudioService.positionStream,
          (mediaItem, position) => MediaState(mediaItem, position));

  Stream<QueueState> get _queueStateStream =>
      Rx.Rx.combineLatest2<List<MediaItem>?, MediaItem?, QueueState>(
          AudioService.queueStream,
          AudioService.currentMediaItemStream,
          (queue, mediaItem) => QueueState(queue, mediaItem));

  ElevatedButton audioPlayerButton() => ElevatedButton(
        child: Text('Start session'),
        onPressed: () {
          AudioService.start(
            backgroundTaskEntrypoint: _audioPlayerTaskEntryPoint,
            androidNotificationChannelName: 'Audio Service Demo',
            androidNotificationColor: 0xFF2196f3,
            androidNotificationIcon: 'mipmap/ic_launcher',
            androidEnableQueue: true,
          );
        },
      );

  onUpdateChange() async {
    await AudioService.stop();

    List<MediaItem> globalQueue = [
      MediaItem(
        id: widget.item.url,
        album: 'hello',
        duration: Duration(seconds: 180),
        title: widget.item.title,
        artist: "Chandra",
        artUri: Uri.parse(widget.item.imgSrc),
      )
    ];

    await AudioService.start(
      backgroundTaskEntrypoint: _audioPlayerTaskEntryPoint,
      androidNotificationChannelName: 'Podcast',
      androidNotificationColor: 0xFF181818,
      androidEnableQueue: true,
    );

    await AudioService.updateQueue(globalQueue);
    await AudioService.play();

    ac.goToDetail(
      item: widget.item,
    );
  }

  @override
  void initState() {
    var beforeValue = ac.currentQueue.value;
    if (beforeValue.isNotEmpty) {
      if (widget.item.url != beforeValue) {
        onUpdateChange();
      }
    } else {
      onUpdateChange();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: StreamBuilder<bool>(
        stream: AudioService.runningStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return SizedBox();
          }
          final running = snapshot.data ?? false;

          if (!running) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xff0B2990),
              ),
            );
          }

          return Container(
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment
                          .bottomLeft, // 10% of the width, so there are ten blinds.
                      colors: [
                        Color(0xff2D51D0),
                        Color(0xff0B2990)
                      ], // red to yellow
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: 50,
                          left: 20,
                        ),
                        width: double.infinity,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop(null);
                              },
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 30),
                            Center(
                              child: Text(
                                'Now Playing',
                                textAlign: TextAlign.center,
                                style: boldText.copyWith(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: 32,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Container(
                                width: width * 0.9,
                                height: width * 0.9,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    8.0,
                                  ),
                                  child: Image.network(
                                    widget.item.imgSrc,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 24),
                              Container(
                                width: width,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.item.title,
                                      style: boldText.copyWith(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(height: 13),
                                    Text(
                                      widget.item.type.toString(),
                                      style: regularText.copyWith(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              StreamBuilder<MediaState>(
                                stream: _mediaStateStream,
                                builder: (context, snapshot) {
                                  final mediaState = snapshot.data;

                                  if (mediaState != null) {
                                    return SeekBar(
                                      duration:
                                          mediaState.mediaItem?.duration ??
                                              Duration.zero,
                                      position: mediaState.position,
                                      onChangeEnd: (newPosition) {
                                        AudioService.seekTo(newPosition);
                                      },
                                    );
                                  } else {
                                    return SeekBar(
                                      duration: Duration.zero,
                                      position: Duration.zero,
                                      onChangeEnd: (newPosition) {},
                                    );
                                  }
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.shuffle,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        StreamBuilder<QueueState?>(
                                          stream: _queueStateStream,
                                          builder: (context, snapshot) {
                                            final queueState = snapshot.data;
                                            final queue =
                                                queueState?.queue ?? [];
                                            final mediaItem =
                                                queueState?.mediaItem;
                                            return Container(
                                                child: queue.isNotEmpty
                                                    ? GestureDetector(
                                                        onTap: mediaItem ==
                                                                queue.first
                                                            ? null
                                                            : AudioService
                                                                .skipToPrevious,
                                                        child: Icon(
                                                          Icons.fast_rewind,
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  mediaItem ==
                                                                          queue
                                                                              .first
                                                                      ? 0.5
                                                                      : 1),
                                                          size: 24,
                                                        ),
                                                      )
                                                    : Container());
                                          },
                                        ),
                                        StreamBuilder<AudioProcessingState>(
                                          stream: AudioService
                                              .playbackStateStream
                                              .map((state) =>
                                                  state.processingState)
                                              .distinct(),
                                          builder: (context, snapshot) {
                                            final processingState =
                                                snapshot.data ??
                                                    AudioProcessingState.none;

                                            final processState =
                                                describeEnum(processingState);

                                            if (processState == "ready") {
                                              return Container(
                                                child: StreamBuilder<bool>(
                                                  stream: AudioService
                                                      .playbackStateStream
                                                      .map((event) =>
                                                          event.playing)
                                                      .distinct(),
                                                  builder: (context, snapshot) {
                                                    final playing =
                                                        snapshot.data ?? false;
                                                    return Column(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            if (playing) {
                                                              AudioService
                                                                  .pause();
                                                            } else {
                                                              AudioService
                                                                  .play();
                                                            }
                                                          },
                                                          child: Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                              horizontal: 20,
                                                            ),
                                                            child: Icon(
                                                              playing
                                                                  ? Icons
                                                                      .pause_circle_filled
                                                                  : Icons
                                                                      .play_circle_filled,
                                                              size: 60,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              );
                                            } else {
                                              return Container(
                                                width: 40,
                                                height: 40,
                                                margin: EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                ),
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 2.0,
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                        StreamBuilder<QueueState>(
                                          stream: _queueStateStream,
                                          builder: (context, snapshot) {
                                            final queueState = snapshot.data;
                                            final queue =
                                                queueState?.queue ?? [];
                                            final mediaItem =
                                                queueState?.mediaItem;

                                            return Container(
                                              child: queue.isNotEmpty
                                                  ? GestureDetector(
                                                      onTap: mediaItem ==
                                                              queue.last
                                                          ? null
                                                          : AudioService
                                                              .skipToNext,
                                                      child: Icon(
                                                        Icons.fast_forward,
                                                        color: Colors.white
                                                            .withOpacity(
                                                                mediaItem ==
                                                                        queue
                                                                            .last
                                                                    ? 0.6
                                                                    : 1),
                                                        size: 24,
                                                      ),
                                                    )
                                                  : Container(),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.repeat,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

void _audioPlayerTaskEntryPoint() async {
  AudioServiceBackground.run(() => AudioPlayerTask());
}
