import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class SongDetailScreen extends StatefulWidget {
  final Audio audio;
  final AssetsAudioPlayer player;

  const SongDetailScreen({super.key, required this.audio, required this.player});

  @override
  _SongDetailScreenState createState() => _SongDetailScreenState();
}

class _SongDetailScreenState extends State<SongDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _artworkAnimationController;

  @override
  void initState() {
    super.initState();
    _artworkAnimationController =
    AnimationController(vsync: this, duration: const Duration(seconds: 10))
      ..repeat();
    widget.player.open(
      Playlist(audios: widget.player.playlist!.audios),
      showNotification: true,
      autoStart: true,
    );
  }

  @override
  void dispose() {
    _artworkAnimationController.dispose();
    super.dispose();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 60),
              Text(
                "Now Playing",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.purple.withOpacity(0.5),
                          Colors.transparent
                        ],
                        stops: const [0.6, 1],
                      ),
                    ),
                  ),
                  RotationTransition(
                    turns: _artworkAnimationController,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: const DecorationImage(
                          image: AssetImage('assets/images/placeholder.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Song Title and Artist
              Column(
                children: [
                  Text(
                    widget.audio.metas.title ?? "Unknown Title",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.audio.metas.artist ?? "Unknown Artist",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Song Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => widget.player.previous(),
                    icon: const Icon(
                      Icons.skip_previous,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  StreamBuilder<bool>(
                    stream: widget.player.isPlaying,
                    builder: (context, snapshot) {
                      bool isPlaying = snapshot.data ?? false;
                      return IconButton(
                        icon: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 50,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (isPlaying) {
                            widget.player.pause();
                          } else {
                            widget.player.play();
                          }
                        },
                      );
                    },
                  ),
                  IconButton(
                    onPressed: () => widget.player.next(),
                    icon: const Icon(
                      Icons.skip_next,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              StreamBuilder<Playing?>(
                stream: widget.player.current,
                builder: (context, snapshot) {
                  Playing? playing = snapshot.data;
                  Duration? audioDuration = playing?.audio.duration;

                  if (audioDuration != null) {
                    return StreamBuilder<Duration>(
                      stream: widget.player.currentPosition,
                      builder: (context, snapshot) {
                        var duration = snapshot.data ?? Duration.zero;

                        String formatDuration(Duration duration) {
                          int minutes = duration.inMinutes;
                          int seconds = duration.inSeconds % 60;
                          return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
                        }
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  formatDuration(duration),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  formatDuration(audioDuration),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SliderTheme(
                              data: SliderThemeData(
                                trackHeight: 6,
                                thumbColor: Colors.white,
                                activeTrackColor: Colors.purpleAccent,
                                inactiveTrackColor: Colors.white24,
                                thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 8),
                              ),
                              child: Slider(
                                value: duration.inSeconds.toDouble(),
                                min: 0,
                                max: audioDuration.inSeconds.toDouble(),
                                onChanged: (value) {
                                  widget.player
                                      .seek(Duration(seconds: value.toInt()));
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
