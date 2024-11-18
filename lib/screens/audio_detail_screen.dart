import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class AudioDetailPage extends StatelessWidget {
  final AssetsAudioPlayer player;

  const AudioDetailPage(
      {super.key, required this.player, required Audio audio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "Now Playing",
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
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: StreamBuilder<Playing?>(
            stream: player.current,
            builder: (context, snapshot) {
              final playing = snapshot.data;
              final currentAudio = playing?.audio;
              final metas = currentAudio?.audio.metas;

              if (currentAudio == null || metas == null) {
                return const Center(
                  child: Text(
                    "No audio playing",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                );
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: const LinearGradient(
                        colors: [Colors.purple, Colors.blue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: metas.image?.path != null
                          ? Image.network(
                        metas.image!.path,
                        fit: BoxFit.fill,
                      )
                          : const Icon(
                        Icons.music_note,
                        size: 150,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                  // Title and Artist
                  Text(
                    metas.title ?? "Unknown Title",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    metas.artist ?? "Unknown Artist",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 70),
                  // Progress Bar
                  StreamBuilder<Duration>(
                    stream: player.currentPosition,
                    builder: (context, snapshot) {
                      final currentPosition = snapshot.data ?? Duration.zero;
                      final totalDuration = currentAudio.duration;

                      return Column(
                        children: [
                          SliderTheme(
                            data: SliderThemeData(
                              trackHeight: 4,
                              thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 10),
                              overlayShape: const RoundSliderOverlayShape(
                                  overlayRadius: 20),
                              activeTrackColor: Colors.blue,
                              inactiveTrackColor: Colors.purple,
                              thumbColor: Colors.white,
                            ),
                            child: Slider(
                              value: currentPosition.inSeconds.toDouble(),
                              max: totalDuration.inSeconds.toDouble(),
                              onChanged: (value) {
                                player.seek(Duration(seconds: value.toInt()));
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${currentPosition.inMinutes}:${(currentPosition.inSeconds % 60).toString().padLeft(2, '0')}",
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                "${totalDuration.inMinutes}:${(totalDuration.inSeconds % 60).toString().padLeft(2, '0')}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _controlButton(
                        icon: Icons.skip_previous,
                        size: 45,
                        onPressed: () => player.previous(),
                      ),
                      const SizedBox(width: 40),
                      StreamBuilder<bool>(
                        stream: player.isPlaying,
                        builder: (context, snapshot) {
                          final isPlaying = snapshot.data ?? false;
                          return _controlButton(
                            icon: isPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_filled,
                            size: 65,
                            onPressed: () => player.playOrPause(),
                          );
                        },
                      ),
                      const SizedBox(width: 40),
                      _controlButton(
                        icon: Icons.skip_next,
                        size: 45,
                        onPressed: () => player.next(),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        )));
  }

  Widget _controlButton({
    required IconData icon,
    required double size,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size + 12,
        height: size + 12,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Colors.purple,Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            size: size,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
