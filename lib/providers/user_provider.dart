import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../controllers/user_controller.dart';

class UserProvider extends ChangeNotifier {
  final UserController _userController = UserController();
  List<User> _users = [];
  bool _isLoading = false;

  List<User> get users => _users;
  bool get isLoading => _isLoading;

  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    _users = await _userController.getUsers();

    _isLoading = false;
    notifyListeners();
  }
}
