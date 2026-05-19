import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            _buildStats(context),
            const SizedBox(height: 24),
            _buildMenu(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.purpleAccent,
                ),
                child: const Icon(Icons.person, size: 40),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.nickname ?? '用户',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Lv.${user?.level ?? 1} ${_getLevelTitle(user?.level ?? 1)}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.purpleAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildExpProgress(context),
        ],
      ),
    );
  }

  Widget _buildExpProgress(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final currentExp = user?.exp ?? 0;
    final nextLevelExp = 100;
    final progress = currentExp / nextLevelExp;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '经验值',
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              '$currentExp / $nextLevelExp',
              style: const TextStyle(color: Colors.purpleAccent),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * progress,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.purple, Colors.purpleAccent],
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStats(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return Row(
      children: [
        const Spacer(),
        _buildStatItem('连续天数', '${user?.streakDays ?? 0}天'),
        const Spacer(),
        Container(width: 1, height: 40, color: Colors.white20),
        const Spacer(),
        _buildStatItem('星月币', '${user?.starMoonCoins ?? 0}'),
        const Spacer(),
        Container(width: 1, height: 40, color: Colors.white20),
        const Spacer(),
        _buildStatItem('总睡眠', '${user?.totalSleepHours ?? 0}h'),
        const Spacer(),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildMenu(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            _buildMenuItem(
              context,
              Icons.settings,
              '设置',
              () {},
            ),
            _buildMenuItem(
              context,
              Icons.bluetooth,
              '设备管理',
              () => context.push('/profile/devices'),
            ),
            _buildMenuItem(
              context,
              Icons.help,
              '帮助与反馈',
              () {},
            ),
            _buildMenuItem(
              context,
              Icons.info,
              '关于我们',
              () {},
            ),
            _buildMenuItem(
              context,
              Icons.logout,
              '退出登录',
              () => _handleLogout(context),
              isDestructive: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.red : Colors.grey),
      title: Text(
        label,
        style: TextStyle(
          color: isDestructive ? Colors.red : Colors.white,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: onTap,
    );
  }

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text('确认退出'),
        content: const Text('确定要退出登录吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              await context.read<UserProvider>().logout();
              if (context.mounted) {
                context.go('/login');
              }
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  String _getLevelTitle(int level) {
    const titles = {
      1: '初入梦乡',
      2: '睡眠学徒',
      3: '规律睡眠者',
      4: '睡眠达人',
      5: '睡眠专家',
      6: '睡神',
      7: '传说级睡神',
    };
    return titles[level] ?? '睡眠爱好者';
  }
}