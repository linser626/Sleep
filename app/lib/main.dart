import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const MainTabScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '好眠',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFFF5E6A3),
          secondary: const Color(0xFF9B8EC4),
          surface: const Color(0xFF1A1A3E),
          background: const Color(0xFF12122A),
        ),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '好眠',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF5E6A3),
              ),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                context.go('/');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF5E6A3),
                foregroundColor: const Color(0xFF1A1A3E),
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                '进入梦乡',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SleepContentScreen(),
    const CommunityScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF1A1A3E),
        selectedItemColor: const Color(0xFFF5E6A3),
        unselectedItemColor: const Color(0xFF9B8EC4),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.nightlight_round),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: '助眠',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: '社区',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('好眠'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '今天也要好好睡觉哦',
              style: TextStyle(fontSize: 18, color: Color(0xFFE8E4F0)),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF5E6A3),
                foregroundColor: const Color(0xFF1A1A3E),
                padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 24),
                shape: const CircleBorder(),
                minimumSize: const Size(160, 160),
              ),
              child: const Text(
                '我要睡觉',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SleepContentScreen extends StatelessWidget {
  const SleepContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('助眠内容', style: TextStyle(color: Color(0xFFE8E4F0))),
    );
  }
}

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('社区', style: TextStyle(color: Color(0xFFE8E4F0))),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('我的', style: TextStyle(color: Color(0xFFE8E4F0))),
    );
  }
}
