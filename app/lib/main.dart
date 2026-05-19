import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'router/app_router.dart';
import 'providers/user_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    await Provider.of<UserProvider>(context, listen: false).loadUser();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: CircularProgressIndicator(color: Colors.purpleAccent),
          ),
        ),
      );
    }

    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp.router(
        title: '好眠',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          brightness: Brightness.dark,
          backgroundColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
        ),
        routerConfig: goRouter,
      ),
    );
  }
}