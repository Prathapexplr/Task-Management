// ignore_for_file: avoid_print

import 'package:hive/hive.dart';
import '../models/task_model.dart';

class LocalStorageService {
  static const String taskBoxName = 'tasks';

  Future<void> initHive() async {
    Hive.registerAdapter(TaskAdapter());
    await Hive.openBox<Task>(taskBoxName);
  }

  Future<void> saveTask(Task task) async {
    final box = Hive.box<Task>(taskBoxName);
    await box.put(task.id.toString(), task);
    print('Task saved: ${task.title} with ID: ${task.id}');
  }

  Future<void> saveTasks(List<Task> tasks) async {
    final box = Hive.box<Task>(taskBoxName);
    Map<String, Task> taskMap = {
      for (var task in tasks) task.id.toString(): task
    };
    await box.putAll(taskMap);
    print('Multiple tasks saved: ${tasks.length}');
  }

  List<Task> getTasks() {
    final box = Hive.box<Task>(taskBoxName);
    final tasks = box.values.toList();
    print('Tasks from Hive: $tasks');
    return tasks;
  }

  Future<void> deleteTask(int taskId) async {
    final box = Hive.box<Task>(taskBoxName);
    await box.delete(taskId.toString());
    print('Task deleted with ID: $taskId');
  }
}
