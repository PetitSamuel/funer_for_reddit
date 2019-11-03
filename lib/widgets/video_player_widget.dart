import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String url;
  final int w;
  final int h;
  VideoPlayerScreen({this.url, this.h, this.w});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  var videoPlayerController;
  var chewieController;
  var playerWidget;
  @override
  void initState() {
    AutoOrientation.portraitMode();
    videoPlayerController = VideoPlayerController.network(widget.url);
    double ratio = 0;
    if (widget.h != null && widget.w != null) {
      ratio = widget.w / widget.h;
    }
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: true,
      autoInitialize: true,
      aspectRatio: ratio,
    );

    playerWidget = Chewie(
      controller: chewieController,
    );
    super.initState();
  }

  @override
  void dispose() {
    AutoOrientation.portraitMode();

    videoPlayerController.dispose();
    chewieController.dispose();
    // Ensure disposing of the VideoPlayerController to free up resources.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return playerWidget;
  }
}
