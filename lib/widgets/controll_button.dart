import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:podcast_app/models/audio.dart';

class ControllButton extends StatelessWidget {
  const ControllButton({
    Key? key,
    required Stream<QueueState> queueStateStream,
  })  : _queueStateStream = queueStateStream,
        super(key: key);

  final Stream<QueueState> _queueStateStream;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  final queue = queueState?.queue ?? [];
                  final mediaItem = queueState?.mediaItem;
                  return Container(
                      child: queue.isNotEmpty
                          ? GestureDetector(
                              onTap: mediaItem == queue.first
                                  ? null
                                  : AudioService.skipToPrevious,
                              child: Icon(
                                Icons.fast_rewind,
                                color: Colors.white.withOpacity(
                                    mediaItem == queue.first ? 0.5 : 1),
                                size: 24,
                              ),
                            )
                          : Container());
                },
              ),
              StreamBuilder<AudioProcessingState>(
                stream: AudioService.playbackStateStream
                    .map((state) => state.processingState)
                    .distinct(),
                builder: (context, snapshot) {
                  final processingState =
                      snapshot.data ?? AudioProcessingState.none;

                  if (describeEnum(processingState) == "buffering") {
                    return Container(
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.0,
                      ),
                    );
                  }
                  return Container(
                    child: StreamBuilder<bool>(
                      stream: AudioService.playbackStateStream
                          .map((event) => event.playing)
                          .distinct(),
                      builder: (context, snapshot) {
                        final playing = snapshot.data ?? false;
                        return GestureDetector(
                          onTap: () {
                            if (playing) {
                              AudioService.pause();
                            } else {
                              AudioService.play();
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Icon(
                              playing
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_filled,
                              size: 60,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              StreamBuilder<QueueState>(
                stream: _queueStateStream,
                builder: (context, snapshot) {
                  final queueState = snapshot.data;
                  final queue = queueState?.queue ?? [];
                  final mediaItem = queueState?.mediaItem;

                  return Container(
                    child: queue.isNotEmpty
                        ? GestureDetector(
                            onTap: mediaItem == queue.last
                                ? null
                                : AudioService.skipToNext,
                            child: Icon(
                              Icons.fast_forward,
                              color: Colors.white.withOpacity(
                                  mediaItem == queue.last ? 0.6 : 1),
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
    );
  }
}
