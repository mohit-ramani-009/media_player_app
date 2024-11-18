import 'package:flutter/material.dart';
import 'package:media_player_app/screens/video_screen.dart';
import 'audio_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: const Text('Media Player',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 4,
            labelColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.music_note,color: Colors.white,),
                text: 'Music',
              ),
              Tab(
                icon: Icon(Icons.video_call,color: Colors.white,),
                text: 'Video',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              color: Colors.pink.shade50,
              child: const Center(
                child: AudioScreen(),
              ),
            ),
            Container(
              color: Colors.lightBlue.shade50,
              child: const Center(
                child: VideoView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




