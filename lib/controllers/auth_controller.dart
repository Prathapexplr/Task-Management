// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  final ApiService _apiService = ApiService();

  Future<bool> register(String email, String password, BuildContext context) async {
    final response = await _apiService.post('https://reqres.in/api/register', {
      'email': email,
      'password': password,
    });

    if (response != null && response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.data['token']);
      Navigator.pushReplacementNamed(context, '/tasks');
      return true;
    } else {
      print('Registration failed: ${response?.data['error']}');
      return false;
    }
  }

  Future<bool> login(String email, String password, BuildContext context) async {
    final response = await _apiService.post('https://reqres.in/api/login', {
      'email': email,
      'password': password,
    });

    if (response != null && response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.data['token']);
      Navigator.pushReplacementNamed(context, '/tasks');
      return true;
    } else {
      print('Login failed: ${response?.data['error']}');
      return false;
    }
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.pushReplacementNamed(context, '/login');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }
}
