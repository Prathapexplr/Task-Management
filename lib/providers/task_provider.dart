import 'package:flutter/material.dart';
import 'package:taskmanagement/widgets/task_item_widget.dart';
import '../models/task_model.dart';
import '../controllers/task_controller.dart';

class TaskProvider with ChangeNotifier {
  final TaskController _taskController = TaskController();
  List<Task> _tasks = [];
  bool _isLoading = true;
  GlobalKey<AnimatedListState>? _listKey;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  TaskProvider() {
    loadTasks();
  }

  set listKey(GlobalKey<AnimatedListState>? key) {
    _listKey = key;
  }

  Future<void> loadTasks() async {
    _isLoading = true;
    notifyListeners();

    try {
      _tasks = await _taskController.getTasks();
    } catch (e) {
      print('Failed to load tasks: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createTask(Task task) async {
    await _taskController.createTask(task);
    final index = _tasks.length;
    _tasks.add(task);
    _listKey?.currentState
        ?.insertItem(index, duration: Duration(milliseconds: 500));
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    await _taskController.updateTask(task);
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      notifyListeners();
    }
  }

  Future<void> deleteTask(int taskId) async {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index == -1) return; // Ensure the index is valid before proceeding
    final removedTask = _tasks[index];
    await _taskController.deleteTask(taskId);
    _tasks.removeAt(index);
    _listKey?.currentState?.removeItem(
      index,
      (context, animation) =>
          _buildRemovedTaskItem(removedTask, index, animation),
      duration: Duration(milliseconds: 500),
    );
    notifyListeners();
  }

  Widget _buildRemovedTaskItem(
      Task task, int index, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: TaskItemWidget(task: task),
    );
  }
}
