import 'package:flutter/material.dart';
import 'package:taskmanagement/models/task_model.dart';
import 'package:taskmanagement/utils/custom_animations.dart';
import 'views/login_view.dart';
import 'views/registration_view.dart';
import 'views/task_list_view.dart';
import 'views/task_form_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return FadePageRoute(page: const LoginView());
      case '/register':
        return FadePageRoute(page: const RegistrationView());
      case '/tasks':
        return FadePageRoute(page: const TaskListView());
      case '/task-form':
        final task = settings.arguments as Task?;
        return FadePageRoute(page: TaskFormView(task: task));
      default:
        return FadePageRoute(page: const LoginView());
    }
  }
}
