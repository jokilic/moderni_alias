import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../constants/videos.dart';

class VideoWidget extends StatefulWidget {
  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late final VideoPlayerController videoController;

  @override
  void initState() {
    super.initState();
    initVideo();
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  Future<void> initVideo() async {
    videoController = VideoPlayerController.asset(ModerniAliasVideos.josipVideo);
    await videoController.initialize();
    await videoController.setLooping(true);
    await videoController.setVolume(0);
    await videoController.play();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) => videoController.value.isInitialized
      ? AspectRatio(
          aspectRatio: videoController.value.aspectRatio,
          child: VideoPlayer(videoController),
        )
      : const SizedBox.shrink();
}
