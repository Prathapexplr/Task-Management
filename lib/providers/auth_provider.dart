import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

class AuthProvider with ChangeNotifier {
  final AuthController _authController = AuthController();

  Future<bool> login(
      String email, String password, BuildContext context) async {
    return await _authController.login(email, password, context);
  }

  Future<bool> register(
      String email, String password, BuildContext context) async {
    return await _authController.register(email, password, context);
  }

  Future<void> logout(BuildContext context) async {
    await _authController.logout(context);
  }

  Future<bool> isLoggedIn() async {
    return await _authController.isLoggedIn();
  }
}
