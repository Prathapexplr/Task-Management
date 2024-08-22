// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Response?> post(String url, Map<String, dynamic> data) async {
    try {
      return await _dio.post(url, data: data);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<Response?> get(String url) async {
    try {
      return await _dio.get(url);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<Response?> put(String url, Map<String, dynamic> data) async {
    try {
      return await _dio.put(url, data: data);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<Response?> delete(String url) async {
    try {
      return await _dio.delete(url);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
