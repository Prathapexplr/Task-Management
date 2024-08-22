// ignore_for_file: avoid_print

import '../models/task_model.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';

class TaskController {
  final ApiService _apiService = ApiService();
  final LocalStorageService _localStorageService = LocalStorageService();

  Future<List<Task>> getTasks() async {
    try {
      final response =
          await _apiService.get('https://jsonplaceholder.typicode.com/todos');
      if (response != null && response.statusCode == 200) {
        final List<dynamic> data = response.data;
        List<Task> tasks = data.map((json) => Task.fromJson(json)).toList();

        await _localStorageService.saveTasks(tasks);
        return tasks;
      } else {
        return _localStorageService.getTasks();
      }
    } catch (e) {
      print('Error fetching tasks: $e');
      return _localStorageService.getTasks();
    }
  }

  Future<void> createTask(Task task) async {
    final response = await _apiService.post(
      'https://jsonplaceholder.typicode.com/todos',
      task.toJson(),
    );
    if (response != null && response.statusCode == 201) {
      await _localStorageService.saveTask(task);
    } else {
      print('Failed to create task: ${response?.data}');
    }
  }

  Future<void> updateTask(Task task) async {
    final response = await _apiService.put(
      'https://jsonplaceholder.typicode.com/todos/${task.id}',
      task.toJson(),
    );
    if (response != null && response.statusCode == 200) {
      await _localStorageService.saveTask(task);
    } else {
      print('Failed to update task: ${response?.data}');
    }
  }

  Future<void> deleteTask(int taskId) async {
    final response = await _apiService.delete(
      'https://jsonplaceholder.typicode.com/todos/$taskId',
    );
    if (response != null && response.statusCode == 200) {
      await _localStorageService.deleteTask(taskId);
    } else {
      print('Failed to delete task: ${response?.data}');
    }
  }
}
