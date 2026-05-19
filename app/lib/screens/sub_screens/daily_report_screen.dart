import 'package:flutter/material.dart';

class DailyReportScreen extends StatelessWidget {
  const DailyReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('今日报告'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildScoreCard(),
            const SizedBox(height: 24),
            _buildSleepTimeCard(),
            const SizedBox(height: 24),
            _buildSleepStagesCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.purple, Colors.blue],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            '睡眠评分',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 16),
          const Text(
            '85',
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '优秀！继续保持',
            style: TextStyle(color: Colors.yellow),
          ),
        ],
      ),
    );
  }

  Widget _buildSleepTimeCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.access_time, color: Colors.purpleAccent),
              SizedBox(width: 8),
              Text(
                '睡眠时长',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                '7小时45分',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '达成目标',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '入睡时间',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    '22:30',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '醒来时间',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    '06:15',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '睡眠效率',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    '92%',
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSleepStagesCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.bar_chart, color: Colors.purpleAccent),
              SizedBox(width: 8),
              Text(
                '睡眠阶段分布',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStageBar(Colors.blue, 20, '深睡眠'),
              _buildStageBar(Colors.purple, 40, '浅睡眠'),
              _buildStageBar(Colors.pink, 25, 'REM'),
              _buildStageBar(Colors.grey, 15, '清醒'),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text('1小时33分', style: TextStyle(color: Colors.blue)),
                    Text('深睡眠', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text('3小时06分', style: TextStyle(color: Colors.purple)),
                    Text('浅睡眠', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text('1小时56分', style: TextStyle(color: Colors.pink)),
                    Text('REM', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text('49分钟', style: TextStyle(color: Colors.grey)),
                    Text('清醒', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStageBar(Color color, int percentage, String label) {
    return Expanded(
      child: Container(
        height: 20,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}