import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SleepContentScreen extends StatefulWidget {
  const SleepContentScreen({super.key});

  @override
  State<SleepContentScreen> createState() => _SleepContentScreenState();
}

class _SleepContentScreenState extends State<SleepContentScreen> {
  int _selectedTab = 0;
  final List<String> _categories = ['全部', '白噪音', '自然声', '轻音乐', '冥想'];

  final List<Map<String, dynamic>> _musicList = [
    {'id': '1', 'title': '雨声入梦', 'category': '白噪音', 'duration': '60:00'},
    {'id': '2', 'title': '溪水潺潺', 'category': '自然声', 'duration': '60:00'},
    {'id': '3', 'title': '森林鸟语', 'category': '自然声', 'duration': '60:00'},
    {'id': '4', 'title': '轻柔钢琴', 'category': '轻音乐', 'duration': '30:00'},
    {'id': '5', 'title': '冥想引导', 'category': '冥想', 'duration': '30:00'},
  ];

  final List<Map<String, dynamic>> _videoList = [
    {'id': '1', 'title': '星空入眠', 'category': '自然风景', 'duration': '60:00'},
    {'id': '2', 'title': '海浪轻拍', 'category': '自然风景', 'duration': '60:00'},
    {'id': '3', 'title': '睡前呼吸练习', 'category': '呼吸练习', 'duration': '10:00'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('助眠内容'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildTabBar(),
          _buildCategoryFilter(),
          Expanded(
            child: _selectedTab == 0 ? _buildMusicList() : _buildVideoList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedTab = 0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderBottom: BorderSide(
                  color: _selectedTab == 0 ? Colors.purpleAccent : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Text(
                '音乐',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: _selectedTab == 0 ? FontWeight.bold : FontWeight.normal,
                  color: _selectedTab == 0 ? Colors.purpleAccent : Colors.grey,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedTab = 1),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderBottom: BorderSide(
                  color: _selectedTab == 1 ? Colors.purpleAccent : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Text(
                '视频',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: _selectedTab == 1 ? FontWeight.bold : FontWeight.normal,
                  color: _selectedTab == 1 ? Colors.purpleAccent : Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: _categories
            .map((category) => Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      category,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildMusicList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _musicList.length,
      itemBuilder: (context, index) {
        final music = _musicList[index];
        return ListTile(
          onTap: () => context.push('/sleep-content/music/${music['id']}'),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.purple, Colors.blue],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.music_note, color: Colors.white),
          ),
          title: Text(
            music['title'],
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            music['category'],
            style: const TextStyle(color: Colors.grey),
          ),
          trailing: Text(
            music['duration'],
            style: const TextStyle(color: Colors.grey),
          ),
        );
      },
    );
  }

  Widget _buildVideoList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _videoList.length,
      itemBuilder: (context, index) {
        final video = _videoList[index];
        return ListTile(
          onTap: () => context.push('/sleep-content/video/${video['id']}'),
          leading: Container(
            width: 80,
            height: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.purple, Colors.blue],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.play_arrow, color: Colors.white),
          ),
          title: Text(
            video['title'],
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            video['category'],
            style: const TextStyle(color: Colors.grey),
          ),
          trailing: Text(
            video['duration'],
            style: const TextStyle(color: Colors.grey),
          ),
        );
      },
    );
  }
}