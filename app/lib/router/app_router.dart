import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/main_tab/home_screen.dart';
import '../screens/main_tab/sleep_content_screen.dart';
import '../screens/main_tab/community_screen.dart';
import '../screens/main_tab/profile_screen.dart';
import '../screens/sub_screens/checkin_flow_screen.dart';
import '../screens/sub_screens/calendar_screen.dart';
import '../screens/sub_screens/daily_report_screen.dart';
import '../screens/sub_screens/music_player_screen.dart';
import '../screens/sub_screens/video_player_screen.dart';
import '../screens/sub_screens/post_detail_screen.dart';
import '../screens/sub_screens/create_post_screen.dart';
import '../screens/sub_screens/device_manage_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  login,
  register,
  home,
  sleepContent,
  community,
  profile,
  checkinFlow,
  calendar,
  dailyReport,
  musicPlayer,
  videoPlayer,
  postDetail,
  createPost,
  deviceManage,
}

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: AppRoute.login.name,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: AppRoute.register.name,
      builder: (context, state) => const RegisterScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => MainTabScaffold(child: child),
      routes: [
        GoRoute(
          path: '/home',
          name: AppRoute.home.name,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeScreen(),
          ),
          routes: [
            GoRoute(
              path: 'checkin',
              name: AppRoute.checkinFlow.name,
              builder: (context, state) => const CheckinFlowScreen(),
            ),
            GoRoute(
              path: 'calendar',
              name: AppRoute.calendar.name,
              builder: (context, state) => const CalendarScreen(),
            ),
            GoRoute(
              path: 'report',
              name: AppRoute.dailyReport.name,
              builder: (context, state) => const DailyReportScreen(),
            ),
          ],
        ),
        GoRoute(
          path: '/sleep-content',
          name: AppRoute.sleepContent.name,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SleepContentScreen(),
          ),
          routes: [
            GoRoute(
              path: 'music/:id',
              name: AppRoute.musicPlayer.name,
              builder: (context, state) => MusicPlayerScreen(
                musicId: state.pathParameters['id']!,
              ),
            ),
            GoRoute(
              path: 'video/:id',
              name: AppRoute.videoPlayer.name,
              builder: (context, state) => VideoPlayerScreen(
                videoId: state.pathParameters['id']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/community',
          name: AppRoute.community.name,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: CommunityScreen(),
          ),
          routes: [
            GoRoute(
              path: 'post/:id',
              name: AppRoute.postDetail.name,
              builder: (context, state) => PostDetailScreen(
                postId: state.pathParameters['id']!,
              ),
            ),
            GoRoute(
              path: 'create',
              name: AppRoute.createPost.name,
              builder: (context, state) => const CreatePostScreen(),
            ),
          ],
        ),
        GoRoute(
          path: '/profile',
          name: AppRoute.profile.name,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ProfileScreen(),
          ),
          routes: [
            GoRoute(
              path: 'devices',
              name: AppRoute.deviceManage.name,
              builder: (context, state) => const DeviceManageScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class MainTabScaffold extends StatelessWidget {
  const MainTabScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouterState state = GoRouterState.of(context);
    final String location = state.location;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.purpleAccent,
      unselectedItemColor: Colors.grey,
      currentIndex: _getSelectedIndex(location),
      onTap: (index) => _handleNavigation(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '首页',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.music_note),
          label: '助眠',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: '社区',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: '我的',
        ),
      ],
    );
  }

  int _getSelectedIndex(String location) {
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/sleep-content')) return 1;
    if (location.startsWith('/community')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0;
  }

  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/sleep-content');
        break;
      case 2:
        context.go('/community');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }
}