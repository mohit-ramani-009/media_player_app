import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
        "https://drive.google.com/file/d/1QL5aLu_HisH82LSuI2sDwuLAhIJpMRnv/view?usp=drive_link",
      ),
    );

    videoPlayerController.initialize().then((_) {
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: false,
      );
      setState(() {});
    });
  }

  @override
  void dispose() {
    chewieController?.dispose();
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (chewieController != null) {
      return Scaffold(
        appBar: AppBar(title: Text("Video Player")),
        body: Center(
          child: AspectRatio(
            aspectRatio: videoPlayerController.value.aspectRatio,
            child: Chewie(controller: chewieController!),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text("Video Player")),
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
