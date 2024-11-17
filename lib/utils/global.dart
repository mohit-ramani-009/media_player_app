import 'package:assets_audio_player/assets_audio_player.dart';

List<Audio> audios = [
  Audio.network(
    "https://www.pagalworld.com.sb/files/download/type/128/id/71764/1.mp3?1",
    metas: Metas(
      title: "Aaj Ki Raat",
      artist: "Madhubanti Bagchi, Divya Kumar",
    ),
  ),
  Audio.network(
    "https://www.pagalworld.com.sb/files/download/type/128/id/71907/1.mp3?1",
    metas: Metas(
      title: "KRISHNA MASHUP",
      artist: "No Artist",
    ),
  ),
  Audio.network(
    "https://www.pagalworld.com.sb/files/download/type/128/id/71941/1.mp3?1",
    metas: Metas(
      title: "Dil Tu Jaan T",
      artist: "Gurnazar",
    ),
  ),
  Audio.network(
    "https://www.pagalworld.com.sb/files/download/type/128/id/72241/1.mp3?1",
    metas: Metas(
      title: "Mere Mehboob",
      artist: "Shankar Mahadevan",
    ),
  ),
  Audio.network(
    "https://www.pagalworld.com.sb/files/download/type/128/id/71251/1.mp3?1",
    metas: Metas(
      title: "Dekha Tenu",
      artist: "Mohammad Faiz",
    ),
  ),
  Audio.network(
    "https://www.pagalworld.com.sb/files/download/type/128/id/6793/1.mp3?1",
    metas: Metas(
      title: "Tere Hawaale",
      artist: "Arijit Singh, Shilpa Rao",
    ),
  ),
  Audio.network(
    "https://www.pagalworld.com.sb/files/download/type/128/id/70608/1.mp3?1",
    metas: Metas(
      title: "Soulmate",
      artist: "Badshah, Arijit Singh",
    ),
  ),
  Audio.network(
    "https://www.pagalworld.com.sb/files/download/type/128/id/68830/1.mp3?1",
    metas: Metas(
      title: "Raam Aayenge",
      artist: "Swati Mishra",
    ),
  ),
  Audio.network(
    "https://www.pagalworld.com.sb/files/download/type/128/id/71592/1.mp3?1",
    metas: Metas(
      title: "Suniya Suniya",
      artist: "Juss",
    ),
  ),
  Audio.network(
    "https://www.pagalworld.com.sb/files/download/type/128/id/72237/1.mp3?1",
    metas: Metas(
      title: "Kasturi",
      artist: "Arijit Singh",
    ),
  ),
];

class AudioFile {
  String? name;
  String path;

  AudioFile(this.name, this.path);
}
