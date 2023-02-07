import 'package:flutter/material.dart';
import 'package:musix/utils/utils.dart';
import 'package:video_player/video_player.dart';

import '../../theme/theme.dart';

enum VideoStatus { idle, play, pause, increase, decrease, retry }

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final double height;
  const VideoPlayerWidget({
    Key? key,
    required this.videoUrl,
    this.height = 240,
  }) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with WidgetsBindingObserver {
  VideoPlayerController? _videoController;
  VideoStatus _status = VideoStatus.idle;

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
        child: GestureDetector(
          onTap: _pauseVideo,
          child: SizedBox(
            height: widget.height,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  VideoPlayer(_videoController!),
                  VideoProgressIndicator(
                    _videoController!,
                    allowScrubbing: true,
                    colors: VideoProgressColors(
                      playedColor: ColorTheme.primaryLighten.withOpacity(0.8),
                      backgroundColor: ColorTheme.grey100.withOpacity(0.6),
                    ),
                    padding: EdgeInsets.only(
                      top: 256 / 320 * widget.height,
                      bottom: 60 / 320 * widget.height,
                      left: 16,
                      right: 16,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SizedBox(
                        height: 36,
                        child: ValueListenableBuilder(
                            valueListenable: _videoController!,
                            builder: (context, VideoPlayerValue value, child) {
                              if (value.position.compareTo(value.duration) >=
                                      0 &&
                                  _status != VideoStatus.retry) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((timeStamp) {
                                  _resetVideo();
                                });
                              }
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    printDuration(value.position),
                                    style: TextStyleTheme.ts10.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  GestureDetector(
                                    onTap: _checkCanDecrease(value)
                                        ? () => _decrease(value)
                                        : null,
                                    child: const Icon(
                                      Icons.fast_rewind_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  GestureDetector(
                                    onTap: _status == VideoStatus.idle ||
                                            _status == VideoStatus.retry ||
                                            _status == VideoStatus.pause
                                        ? _playVideo
                                        : _pauseVideo,
                                    child: Icon(
                                      _iconBaseOnVideoStatus[_status],
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  GestureDetector(
                                    onTap: _checkCanIncrease(value)
                                        ? () => _increase(value)
                                        : null,
                                    child: const Icon(
                                      Icons.fast_forward_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    printDuration(value.duration),
                                    style: TextStyleTheme.ts10.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
    if (validVideo) {
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
        _status = VideoStatus.retry;
      });
    } else {
      return;
    }
  }

  bool _checkCanIncrease(VideoPlayerValue value) {
    return value.position
            .compareTo(value.duration - const Duration(seconds: 5)) <
        0;
  }

  void _increase(VideoPlayerValue value) {
    DebugLogger().log('Call Increase Method');
    _videoController
        ?.seekTo(value.position + const Duration(seconds: 5))
        .then((value) => setState(() {}));
  }

  bool _checkCanDecrease(VideoPlayerValue value) {
    return (value.position - const Duration(seconds: 5))
            .compareTo(Duration.zero) >=
        0;
  }

  void _decrease(VideoPlayerValue value) {
    DebugLogger().log('Call Decrease Method');
    _videoController
        ?.seekTo(value.position - const Duration(seconds: 5))
        .then((value) => setState(() {}));
  }

  final Map<VideoStatus, IconData> _iconBaseOnVideoStatus = {
    VideoStatus.idle: Icons.play_arrow_outlined,
    VideoStatus.play: Icons.pause,
    VideoStatus.pause: Icons.play_arrow_outlined,
    VideoStatus.retry: Icons.refresh,
  };
}
