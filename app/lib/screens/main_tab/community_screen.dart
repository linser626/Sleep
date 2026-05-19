import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  final List<Map<String, dynamic>> _posts = [
    {
      'id': '1',
      'user': '睡眠达人小王',
      'avatar': null,
      'content': '今天终于完成了30天连续打卡！感觉睡眠质量明显提升了，继续坚持！',
      'time': '2小时前',
      'likes': 128,
      'comments': 23,
    },
    {
      'id': '2',
      'user': '好眠官方',
      'avatar': null,
      'content': '🌙 睡前小贴士：睡前一小时远离电子设备，让大脑有足够时间放松。试试冥想或听一些白噪音，帮助你更快入睡。',
      'time': '5小时前',
      'likes': 356,
      'comments': 45,
      'isOfficial': true,
    },
    {
      'id': '3',
      'user': '新手小白',
      'avatar': null,
      'content': '刚开始使用好眠APP，希望能养成良好的睡眠习惯。有没有一起打卡的小伙伴？',
      'time': '昨天',
      'likes': 45,
      'comments': 12,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('社区'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.push('/community/create'),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          final post = _posts[index];
          return _buildPostCard(context, post);
        },
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, Map<String, dynamic> post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: post['isOfficial'] == true ? Colors.purpleAccent : Colors.grey,
                ),
                child: const Icon(Icons.person, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post['user'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    post['time'],
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              if (post['isOfficial'] == true)
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    '官方',
                    style: TextStyle(
                      color: Colors.purpleAccent,
                      fontSize: 10,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            post['content'],
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border, color: Colors.grey),
              ),
              Text(
                '${post['likes']}',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(width: 16),
              IconButton(
                onPressed: () => context.push('/community/post/${post['id']}'),
                icon: const Icon(Icons.comment, color: Colors.grey),
              ),
              Text(
                '${post['comments']}',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}