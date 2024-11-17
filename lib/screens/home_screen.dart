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
                icon: Icon(Icons.home,color: Colors.white,),
                text: 'Home',
              ),
              Tab(
                icon: Icon(Icons.video_call,color: Colors.white,),
                text: 'Video',
              ),
              Tab(
                icon: Icon(Icons.music_note,color: Colors.white,),
                text: 'Music',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              color: Colors.teal.shade50,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.home, size: 100, color: Colors.teal),
                    Text(
                      'Welcome to the Home Screen',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.lightBlue.shade50,
              child: const Center(
                child: VideoScreen(),
              ),
            ),
            Container(
              color: Colors.pink.shade50,
              child: const Center(
                child: AudioScreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




