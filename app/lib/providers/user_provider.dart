import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/api_service.dart';

class User {
  final int id;
  final String phone;
  final String nickname;
  final String? avatar;
  final int level;
  final int exp;
  final int starMoonCoins;
  final int streakDays;
  final int sleepGoal;

  User({
    required this.id,
    required this.phone,
    required this.nickname,
    this.avatar,
    required this.level,
    required this.exp,
    required this.starMoonCoins,
    required this.streakDays,
    required this.sleepGoal,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      phone: json['phone'],
      nickname: json['nickname'],
      avatar: json['avatar'],
      level: json['level'] ?? 1,
      exp: json['exp'] ?? 0,
      starMoonCoins: json['starMoonCoins'] ?? 0,
      streakDays: json['streakDays'] ?? 0,
      sleepGoal: json['sleepGoal'] ?? 8,
    );
  }
}

class UserProvider extends ChangeNotifier {
  User? _user;
  String? _token;
  final ApiService _apiService = ApiService();

  User? get user => _user;
  String? get token => _token;

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    if (_token != null) {
      try {
        final userData = await _apiService.getUser();
        _user = User.fromJson(userData);
      } catch (_) {
        _token = null;
        await prefs.remove('token');
      }
    }
    notifyListeners();
  }

  Future<void> sendCode(String phone) async {
    await _apiService.sendCode(phone);
  }

  Future<void> login(String phone, String code) async {
    final result = await _apiService.login(phone, code);
    _token = result['token'];
    _user = User.fromJson(result['user']);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', _token!);
    notifyListeners();
  }

  Future<void> updateUser(Map<String, dynamic> data) async {
    if (_user == null) return;
    final result = await _apiService.updateUser(_user!.id, data);
    _user = User.fromJson(result);
    notifyListeners();
  }

  Future<void> logout() async {
    _user = null;
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    notifyListeners();
  }
}