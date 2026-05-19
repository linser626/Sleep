import 'package:flutter/material.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;

  const VideoPlayerScreen({super.key, required this.videoId});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool _isPlaying = false;
  double _progress = 0.2;
  int _timerMinutes = 30;

  void _togglePlay() {
    setState(() => _isPlaying = !_isPlaying);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('视频播放'),
      ),
      body: Column(
        children: [
          _buildVideoPlayer(),
          _buildInfo(),
          _buildControls(),
          _buildTimer(),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return Expanded(
      child: Container(
        color: Colors.black,
        child: Center(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.blue],
                  ),
                ),
                child: const Icon(Icons.play_circle_outline, size: 80, color: Colors.white),
              ),
              Center(
                child: IconButton(
                  onPressed: _togglePlay,
                  icon: Icon(
                    _isPlaying ? Icons.pause_circle : Icons.play_circle,
                    size: 64,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Row(
            children: [
              Text(
                '星空入眠',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              Text('00:00 / 60:00', style: TextStyle(color: Colors.grey)),
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
      ),
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
        const SizedBox(width: 16),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.fullscreen, color: Colors.white),
          iconSize: 32,
        ),
      ],
    );
  }

  Widget _buildTimer() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
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
      ),
    );
  }

  Widget _buildTimerButton(int minutes) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => setState(() => _timerMinutes = minutes),
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
}