import 'package:flutter/material.dart';

class MusicPlayerScreen extends StatefulWidget {
  final String musicId;

  const MusicPlayerScreen({super.key, required this.musicId});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  bool _isPlaying = false;
  double _progress = 0.3;
  double _volume = 0.7;
  int _timerMinutes = 30;

  void _togglePlay() {
    setState(() => _isPlaying = !_isPlaying);
  }

  void _adjustTimer(int minutes) {
    setState(() => _timerMinutes = minutes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('音乐播放'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildAlbumArt(),
            const SizedBox(height: 24),
            _buildInfo(),
            const SizedBox(height: 24),
            _buildProgressBar(),
            const SizedBox(height: 24),
            _buildControls(),
            const SizedBox(height: 24),
            _buildTimer(),
            const SizedBox(height: 24),
            _buildVolume(),
          ],
        ),
      ),
    );
  }

  Widget _buildAlbumArt() {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.purple, Colors.blue],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
        child: Icon(
          Icons.music_note,
          size: 80,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return const Column(
      children: [
        Text(
          '雨声入梦',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '白噪音',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        Row(
          children: const [
            Text('00:00', style: TextStyle(color: Colors.grey)),
            Spacer(),
            Text('60:00', style: TextStyle(color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 4,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(2),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * _progress,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.purple, Colors.purpleAccent],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.skip_previous, color: Colors.white),
          iconSize: 32,
        ),
        const SizedBox(width: 16),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.purpleAccent,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: _togglePlay,
            icon: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.black,
            ),
            iconSize: 32,
          ),
        ),
        const SizedBox(width: 16),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.skip_next, color: Colors.white),
          iconSize: 32,
        ),
      ],
    );
  }

  Widget _buildTimer() {
    return Column(
      children: [
        const Row(
          children: [
            Icon(Icons.timer, color: Colors.purpleAccent),
            SizedBox(width: 8),
            Text('定时关闭', style: TextStyle(color: Colors.white)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildTimerButton(15),
            const SizedBox(width: 12),
            _buildTimerButton(30),
            const SizedBox(width: 12),
            _buildTimerButton(45),
            const SizedBox(width: 12),
            _buildTimerButton(60),
          ],
        ),
      ],
    );
  }

  Widget _buildTimerButton(int minutes) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _adjustTimer(minutes),
        style: ElevatedButton.styleFrom(
          backgroundColor: _timerMinutes == minutes ? Colors.purpleAccent : Colors.white10,
          foregroundColor: _timerMinutes == minutes ? Colors.black : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text('$minutes分钟'),
      ),
    );
  }

  Widget _buildVolume() {
    return Column(
      children: [
        const Row(
          children: [
            Icon(Icons.volume_up, color: Colors.purpleAccent),
            SizedBox(width: 8),
            Text('音量', style: TextStyle(color: Colors.white)),
            Spacer(),
            Text('70%', style: TextStyle(color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 8),
        Slider(
          value: _volume,
          onChanged: (value) => setState(() => _volume = value),
          activeColor: Colors.purpleAccent,
          inactiveColor: Colors.white10,
        ),
      ],
    );
  }
}