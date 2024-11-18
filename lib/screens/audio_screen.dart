import 'package:carousel_slider/carousel_options.dart';
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

  @override
  void initState() {
    super.initState();
    try {
      player.open(Playlist(audios: audios), autoStart: false);
    } catch (e) {
      print("Error initializing player: $e");
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CarouselSlider(
            items: audios.map((audio) {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.music_note,
                      color: Colors.white,
                      size: 60,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      audio.metas.title ?? "Unknown Title",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
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
          Expanded(
            child: ListView.builder(
              itemCount: audios.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SongDetailScreen(
                          audio: audios[index],
                          player: player,
                        ),
                      ),
                    );
                  },
                  leading: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        colors: [Colors.blue, Colors.purple],
                      ).createShader(bounds);
                    },
                    child: const Icon(
                      Icons.music_note,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    audios[index].metas.title ?? "Unknown Title",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    audios[index].metas.artist ?? "Unknown Artist",
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.play_arrow, color: Colors.purple),
                    onPressed: () {
                      player.playlistPlayAtIndex(index);
                    },
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                StreamBuilder<Playing?>(
                  stream: player.current,
                  builder: (context, snapshot) {
                    Playing? playing = snapshot.data;
                    int? currentIndex = playing?.index;
                    int? totalTracks = player.playlist?.audios.length;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: currentIndex != null && currentIndex > 0
                              ? () => player.previous()
                              : null, 
                          icon: Icon(
                            Icons.skip_previous,
                            color: currentIndex != null && currentIndex > 0
                                ? Colors.white
                                : Colors.grey, 
                            size: 30,
                          ),
                        ),
                        StreamBuilder<bool>(
                          stream: player.isPlaying,
                          builder: (context, snapshot) {
                            bool isPlaying = snapshot.data ?? false;
                            return IconButton(
                              onPressed: () => player.playOrPause(),
                              icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                                size: 30,
                              ),
                            );
                          },
                        ),
                        IconButton(
                          onPressed: currentIndex != null &&
                              currentIndex < (totalTracks! - 1)
                              ? () => player.next()
                              : null, 
                          icon: Icon(
                            Icons.skip_next,
                            color: currentIndex != null &&
                                currentIndex < (totalTracks! - 1)
                                ? Colors.white
                                : Colors.grey, 
                            size: 30,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                StreamBuilder<Playing?>(
                  stream: player.current,
                  builder: (context, snapshot) {
                    Playing? playing = snapshot.data;
                    Duration? totalDuration = playing?.audio.duration;

                    return StreamBuilder<Duration>(
                      stream: player.currentPosition,
                      builder: (context, snapshot) {
                        var currentPosition = snapshot.data ?? Duration.zero;

                        String formatDuration(Duration duration) {
                          return "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
                        }

                        return Column(
                          children: [
                            Slider(
                              min: 0,
                              max: totalDuration?.inSeconds.toDouble() ?? 0,
                              value: currentPosition.inSeconds.toDouble(),
                              onChanged: (value) {
                                player.seek(Duration(seconds: value.toInt()));
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  formatDuration(currentPosition),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  formatDuration(totalDuration ?? Duration.zero),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
