import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckinFlowScreen extends StatefulWidget {
  const CheckinFlowScreen({super.key});

  @override
  State<CheckinFlowScreen> createState() => _CheckinFlowScreenState();
}

class _CheckinFlowScreenState extends State<CheckinFlowScreen> {
  bool _isSleeping = false;
  DateTime? _sleepTime;

  void _startSleep() {
    setState(() {
      _isSleeping = true;
      _sleepTime = DateTime.now();
    });
  }

  void _endSleep() {
    setState(() {
      _isSleeping = false;
    });
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text('打卡成功'),
        content: const Text('恭喜你完成了今天的睡眠打卡！'),
        actions: [
          TextButton(
            onPressed: () => context.go('/home'),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  String _formatDuration() {
    if (_sleepTime == null) return '00:00';
    final duration = DateTime.now().difference(_sleepTime!);
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('睡眠打卡'),
      ),
      body: Center(
        child: _isSleeping ? _buildSleepingState() : _buildStartState(),
      ),
    );
  }

  Widget _buildStartState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Colors.purple, Colors.blue],
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.nightlight_round,
              size: 80,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          '准备睡觉了吗？',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        const SizedBox(height: 16),
        const Text(
          '点击下方按钮开始记录睡眠',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 48),
        SizedBox(
          width: 200,
          height: 60,
          child: ElevatedButton(
            onPressed: _startSleep,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purpleAccent,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              '开始睡觉',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSleepingState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Colors.blue, Colors.indigo],
            ),
          ),
          child: Center(
            child: Text(
              _formatDuration(),
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          '睡眠中...',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        const SizedBox(height: 16),
        const Text(
          '好好休息，醒来后点击结束',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 48),
        SizedBox(
          width: 200,
          height: 60,
          child: ElevatedButton(
            onPressed: _endSleep,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              '我醒了',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}