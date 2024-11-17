import 'package:assets_audio_player/assets_audio_player.dart';

// List song = [
//   {"title": "Shiv Tandav Stotram", "artist": "Shankar Mahadevan"},
//   {"title": "Lagdi Lahore Di", "artist": "Guru Randhawa"},
//   {"title": "Kamariya", "artist": "Darshan Raval"},
//   {"title": "Chogada", "artist": "Darshan Raval, Asees Kaur"},
//   {"title": "Lahu Munh Lag Gaya", "artist": "Shail Hada"},
//   {"title": "Radha Ne Shyam Mali Jase", "artist": "Kinjal Dave"},
//   {"title": "Tujh Mein Rab Dikhta Hai", "artist": "Roop Kumar Rathod"},
//   {"title": "Kamli", "artist": "Sunidhi Chauhan"},
//   {"title": "Naina Da Kya Kasoor", "artist": "Amit Trivedi"},
//   {"title": "Kesariya", "artist": "Arijit Singh"},
//   {"title": "Mitwa", "artist": "Shankar-Ehsaan-Loy"},
//   {"title": "Dholida", "artist": "Udit Narayan, Karsan Sagathia"},
//   {"title": "Prem Ratan Dhan Payo", "artist": "Palak Muchhal"},
//   {"title": "Mann Bharryaa", "artist": "B Praak"},
//   {"title": "Lamborghini", "artist": "The Doorbeen, Ragini"},
//   {"title": "Sanedo", "artist": "DJ Chetas, Darshan Raval"},
//   {"title": "Tum Mile", "artist": "Neeraj Shridhar"},
//   {"title": "Sun Saathiya", "artist": "Priya Saraiya, Divya Kumar"},
//   {"title": "Tujhko Jo Paaya", "artist": "Mohit Chauhan"},
//   {"title": "Mehendi Te Vavi Malve Thi", "artist": "Kinjal Dave"},
//   {"title": "Galliyan", "artist": "Ankit Tiwari"},
//   {"title": "Jeene Laga Hoon", "artist": "Atif Aslam, Shreya Ghoshal"},
//   {"title": "Jab Koi Baat Bigad Jaye", "artist": "Atif Aslam, Shirley Setia"},
//   {"title": "Garba Queen", "artist": "Geeta Rabari"},
//   {"title": "Rang Jo Lagyo", "artist": "Kirtidan Gadhvi"}
// ];
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
// ListView.builder(
// itemCount: song.length,
// itemBuilder: (context, index) {
// return Container(
// margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(10),
// boxShadow: [
// BoxShadow(
// color: Colors.grey.withOpacity(0.3),
// spreadRadius: 2,
// blurRadius: 5,
// offset: const Offset(0, 3),
// ),
// ],
// ),
// child: ListTile(
// contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// leading: Icon(Icons.music_note, color: Colors.teal.shade300, size: 30),
// title: Text(
// song[index]["title"],
// style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
// ),
// subtitle: Text(
// song[index]["artist"],
// style: const TextStyle(fontSize: 14, color: Colors.grey),
// ),
// trailing: const Icon(Icons.play_circle_fill, color: Colors.teal, size: 30),
// onTap: () {
// showDialog<String>(
// context: context,
// builder: (BuildContext context) => AlertDialog(
// title: Text(song[index]["title"]),
// content: Text('Playing: ${song[index]["title"]} by ${song[index]["artist"]}'),
// actions: [
// TextButton(
// onPressed: () => Navigator.pop(context, 'Cancel'),
// child: const Text('Cancel'),
// ),
// TextButton(
// onPressed: () => Navigator.pop(context, 'OK'),
// child: const Text('OK'),
// ),
// ],
// ),
// );
// },
// ),
// );
// },
// ),
