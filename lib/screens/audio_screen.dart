import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import '../utils/global.dart';
import 'audio_detail_screen.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  int cIndex = 0;
  final AssetsAudioPlayer player = AssetsAudioPlayer.newPlayer();
  bool isPlaying = false; // Flag to track if a song is playing

  @override
  void initState() {
    super.initState();
    player.open(Playlist(audios: audios), autoStart: false);
    player.current.listen((playing) {
      if (playing != null) {
        setState(() {
          isPlaying = true;
        });
      } else {
        setState(() {
          isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 20),

          // Carousel for displaying songs
          GestureDetector(
            onTap: () {
              if (audios.isNotEmpty && cIndex < audios.length) {
                player.playlistPlayAtIndex(cIndex);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AudioDetailPage(
                      audio: audios[cIndex],
                      player: player,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("No audio selected."),
                  ),
                );
              }
            },
            child: CarouselSlider(
              items: audios.map((audio) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: audio.metas.image != null
                        ? DecorationImage(
                      image: NetworkImage(audio.metas.image!.path),
                      fit: BoxFit.cover,
                    )
                        : null,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          audio.metas.title ?? "Unknown Title",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          audio.metas.artist ?? "Unknown Artist",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 0.8,
                enlargeCenterPage: true,
                autoPlayInterval: const Duration(seconds: 3),
                onPageChanged: (index, reason) {
                  setState(() {
                    cIndex = index;
                  });
                },
              ),
            ),
          ),

          const SizedBox(height: 20),

          // List of songs
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: audios.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white.withOpacity(0.7),
                  shadowColor: Colors.black,
                  elevation: 7,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    onTap: () {
                      player.playlistPlayAtIndex(index);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AudioDetailPage(
                            audio: audios[index],
                            player: player,
                          ),
                        ),
                      );
                    },
                    leading:Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.purpleAccent, Colors.blueAccent], // Gradient colors
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle, // Makes the container circular
                      ),
                      child:  Center(
                        child: Icon(
                          Icons.music_note,
                          color: Colors.white,
                          size: 30, // Adjust size if needed
                        ),
                      ),
                    ),

                    title: Text(
                      audios[index].metas.title ?? "Unknown Title",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      audios[index].metas.artist ?? "Unknown Artist",
                      style: const TextStyle(color: Colors.black),
                    ),
                    trailing: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.purpleAccent, Colors.blueAccent], // Gradient colors
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle, // Makes the container circular
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.play_arrow, color: Colors.white), // White icon to contrast the gradient
                        onPressed: () {
                          player.playlistPlayAtIndex(index);
                        },
                        iconSize: 20,
                        padding: EdgeInsets.zero, // Remove default padding
                      ),
                    ),

                  ),
                );
              },
            ),
          ),

          // Bottom playback controls (only show when playing)
          if (isPlaying)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.blue], // Gradient background
                ),
              ),
              child: StreamBuilder<Playing?>(
                stream: player.current,
                builder: (context, snapshot) {
                  Duration? totalDuration = snapshot.data?.audio.duration ?? Duration.zero;

                  return StreamBuilder<Duration>(
                    stream: player.currentPosition,
                    builder: (context, snapshot) {
                      Duration currentPosition = snapshot.data ?? Duration.zero;

                      String formatDuration(Duration duration) {
                        return "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
                      }

                      return Row(
                        children: [
                          // Previous button
                          IconButton(
                            onPressed: () => player.previous(),
                            icon: const Icon(Icons.skip_previous, color: Colors.white, size: 30),
                          ),
                          // Play/pause button
                          StreamBuilder<bool>(
                            stream: player.isPlaying,
                            builder: (context, snapshot) {
                              bool isPlaying = snapshot.data ?? false;
                              return IconButton(
                                onPressed: () => player.playOrPause(),
                                icon: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              );
                            },
                          ),
                          // Next button
                          IconButton(
                            onPressed: () => player.next(),
                            icon: const Icon(Icons.skip_next, color: Colors.white, size: 30),
                          ),
                          // Slider
                          Expanded(
                            child: Slider(
                              min: 0,
                              max: totalDuration.inSeconds.toDouble(),
                              value: currentPosition.inSeconds.toDouble(),
                              onChanged: (value) {
                                player.seek(Duration(seconds: value.toInt()));
                              },
                              activeColor: Colors.white,
                              inactiveColor: Colors.white38,
                            ),
                          ),
                          // Current time / Total duration
                          Text(
                            "${formatDuration(currentPosition)} / ${formatDuration(totalDuration)}",
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          // Close song button
                          IconButton(
                            onPressed: () {
                              player.stop();
                            },
                            icon: const Icon(
                              Icons.close, // Close icon
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),

        ],
      ),
    );
  }
}
