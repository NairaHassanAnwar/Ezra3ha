import 'package:application_project/BottomNavBar.dart';
import 'package:application_project/Location.dart';
import 'package:flutter/material.dart';
import 'package:application_project/Profile.dart';
import 'package:application_project/Search.dart';
import 'package:application_project/Bag.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late YoutubePlayerController _controller1;
  late YoutubePlayerController _controller2;

  @override
  void initState() {
    super.initState();

    const videoUrl1 = 'https://youtu.be/g6LMw9I6rxU?si=fx96paIjwyZAbJSN';
    final videoId1 = YoutubePlayer.convertUrlToId(videoUrl1);
    _controller1 = YoutubePlayerController(
      initialVideoId: videoId1!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    const videoUrl2 = 'https://youtu.be/Y-XPkRnI-ls?si=O4KhgjcsqaoYLVoQ';
    final videoId2 = YoutubePlayer.convertUrlToId(videoUrl2);
    _controller2 = YoutubePlayerController(
      initialVideoId: videoId2!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Location()));
        break;
      case 2:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Search()));
        break;
      case 3:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Bag()));
        break;
      case 4:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Profile()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello User'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              imageUrl: "https://assets.speakcdn.com/assets/2522/pasted_ttt0708_2.jpg",
              title: 'Trees',
              description: 'Soil, fertilizer, watering',
            ),
            const SizedBox(height: 16),
            _buildSection(
              imageUrl: "https://cdn.shopify.com/s/files/1/0278/6652/9932/files/repotting_810f6b47-f92a-4537-adfe-95df10c3f4ff_600x600.jpg?v=1618605218",
              title: 'Repotting',
              description: 'How not to harm',
            ),
            const SizedBox(height: 16),
            _buildSection(
              imageUrl: "https://hips.hearstapps.com/hmg-prod/images/colorado-beetle-eats-a-potato-leaves-young-royalty-free-image-542328690-1531259828.jpg?crop=0.738xw:0.558xh;0.221xw,0.183xh&resize=640:*",
              title: 'Pests',
              description: 'Ways of fighting',
            ),
            const SizedBox(height: 24),
            _buildVideosSection(),
            const SizedBox(height: 12),
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: SizedBox(
                        width: 300,
                        height: 170,
                        child: YoutubePlayer(
                          controller: _controller1,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: const Color(0xFF3A5A40),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      height: 170,
                      child: YoutubePlayer(
                        controller: _controller2,
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: const Color(0xFF3A5A40),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 0,
        onItemTapped: (index) => _onItemTapped(context, index),
      ),
    );
  }

  Widget _buildSection({
    required String imageUrl,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3A5A40),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideosSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Videos',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () async {
            const url = 'https://youtu.be/g6LMw9I6rxU?si=fx96paIjwyZAbJSN';
            final uri = Uri.parse(url);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: const Text(
            'See all',
            style: TextStyle(color: Color(0xFF3A5A40)),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }
}


