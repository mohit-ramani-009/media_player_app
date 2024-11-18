import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDetailScreen extends StatefulWidget {
  final String videoPath;
  final String thumbnailPath;
  final String videoTitle;

  const VideoDetailScreen({
    required this.videoPath,
    required this.thumbnailPath,
    required this.videoTitle,
    super.key,
  });

  @override
  State<VideoDetailScreen> createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    initializeVideoController(widget.videoPath);
  }

  // Function to initialize the video controller
  void initializeVideoController(String videoPath) {
    videoPlayerController = VideoPlayerController.asset(videoPath);

    videoPlayerController.initialize().then((_) {
      setState(() {
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          autoPlay: true,
          looping: false, // Optional: Add looping if needed
        );
      });
    });
  }

  @override
  void dispose() {
    // Dispose controllers to release resources
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title:  Text(
          widget.videoTitle,
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple,Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video player wrapped in a Center widget to center it
            if (chewieController != null)
              Center(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: AspectRatio(
                    aspectRatio: videoPlayerController.value.aspectRatio,
                    child: Chewie(controller: chewieController!),
                  ),
                ),
              )
            else
              const Center(child: CircularProgressIndicator()),

            // Space between player and details
            const SizedBox(height: 20),

            // Video details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Video Title
                  Text(
                    widget.videoTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Channel Name
                  const Text(
                    'Channel Name',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Views and Upload Time
                  const Text(
                    '1.5M views • 1 day ago',
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Video Description
                  const Text(
                    'This is a description of the video. It provides more details about the video content. The description could be longer, and it gives viewers more context about what to expect.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),

                  // Like, Dislike, Share, and Comment buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Like and Dislike
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.thumb_up, color: Colors.white),
                            onPressed: () {
                              // Implement like functionality
                            },
                          ),
                          const Text(
                            '12K',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            icon: const Icon(Icons.thumb_down, color: Colors.white),
                            onPressed: () {
                              // Implement dislike functionality
                            },
                          ),
                        ],
                      ),

                      // Share Button
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.share, color: Colors.white),
                            onPressed: () {
                              // Implement share functionality
                            },
                          ),
                          const Text(
                            'Share',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
