import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:musix/utils/utils.dart';
import 'package:video_player/video_player.dart';

import '../../theme/color.dart';
import '../../theme/text_style.dart';

enum VideoStatus { idle, play, pause, end }

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final double height;
  final String titleVideo;
  final String authorVideo;

  const VideoPlayerWidget({
    Key? key,
    required this.videoUrl,
    required this.authorVideo,
    required this.titleVideo,
    this.height = 360,
  }) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with WidgetsBindingObserver {
  VideoPlayerController? _videoController;
  VideoStatus _status = VideoStatus.pause;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoController?.pause();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        initializePlayer();
        break;
      case AppLifecycleState.inactive:
        _videoController?.pause();
        break;
      case AppLifecycleState.paused:
        _videoController?.pause();
        break;
      case AppLifecycleState.detached:
        _videoController?.dispose();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Video Player $_videoController');
    if (!_checkIsVideoValid()) {
      return const CircularProgressIndicator();
    }
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ValueListenableBuilder(
            valueListenable: _videoController!,
            builder: (context, VideoPlayerValue value, child) {
              if (value.position == value.duration) {
                _status = VideoStatus.end;
              }
              return GestureDetector(
                onTap: _pauseVideo,
                onDoubleTapDown: (TapDownDetails? details) {
                  var position = details?.globalPosition;
                  if (position == null) {
                    return;
                  }
                  // you can also check out details.localPosition;

                  if (position.dx < MediaQuery.of(context).size.width / 2) {
                    _decrease(value);
                  } else {
                    // tap right size
                    _increase(value);
                  }
                },
                child: SizedBox(
                  height: widget.height,
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        VideoPlayer(_videoController!),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.titleVideo,
                                  style: TextStyleTheme.ts14.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    letterSpacing: 0.1,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  widget.authorVideo,
                                  style: TextStyleTheme.ts12.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: ColorTheme.primary,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (_status == VideoStatus.pause) ...[
                          Center(
                            child: InkWell(
                              onTap: _playVideo,
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(180),
                                  border: Border.all(
                                    width: 0.8,
                                    color: Colors.white,
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                        if (value.position == value.duration) ...[
                          Center(
                            child: InkWell(
                              onTap: _resetVideo,
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(180),
                                  border: Border.all(
                                    width: 0.8,
                                    color: Colors.white,
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.refresh,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: ProgressBar(
                              progress: value.position,
                              total: value.duration,
                              progressBarColor: ColorTheme.primary,
                              baseBarColor: Colors.white30,
                              bufferedBarColor: Colors.white54,
                              thumbColor: Colors.white,
                              barHeight: 2,
                              thumbRadius: 6,
                              timeLabelTextStyle: TextStyleTheme.ts12.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                              timeLabelPadding: 8,
                              onSeek: (duration) {
                                _videoController
                                    ?.seekTo(duration)
                                    .then((value) => setState(() {}));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Future<void> initializePlayer() async {
    _videoController = VideoPlayerController.network(
      widget.videoUrl,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    setState(() {});
    _videoController!.initialize().then((_) {
      setState(() {});
    });
  }

  bool _checkIsVideoValid() {
    if (_videoController == null) {
      DebugLogger().log('Video is null');
      return false;
    }
    if (!_videoController!.value.isInitialized) {
      DebugLogger().log('Video is not initialized');
      return false;
    }
    return true;
  }

  void _playVideo() {
    DebugLogger().log('Call Play Method');
    final validVideo = _checkIsVideoValid();
    if (validVideo) {
      setState(() {
        _status = VideoStatus.play;
        _videoController?.play();
      });
    } else {
      return;
    }
  }

  void _pauseVideo() {
    DebugLogger().log('Call Pause Method');
    final validVideo = _checkIsVideoValid();
    if (validVideo && _status != VideoStatus.end) {
      setState(() {
        _status = VideoStatus.pause;
        _videoController?.pause();
      });
    } else {
      return;
    }
  }

  void _resetVideo() {
    DebugLogger().log('Call Reset Method');
    final validVideo = _checkIsVideoValid();
    if (validVideo) {
      setState(() {
        _videoController?.play();
        _status = VideoStatus.play;
      });
    } else {
      return;
    }
  }

  void _increase(VideoPlayerValue value) {
    DebugLogger().log('Call Increase Method');
    _videoController
        ?.seekTo(value.position + const Duration(seconds: 5))
        .then((value) => setState(() {}));
  }

  void _decrease(VideoPlayerValue value) {
    DebugLogger().log('Call Decrease Method');
    _videoController
        ?.seekTo(value.position < const Duration(seconds: 5)
            ? value.position - const Duration(seconds: 5)
            : Duration.zero)
        .then((value) => setState(() {}));
  }
}
