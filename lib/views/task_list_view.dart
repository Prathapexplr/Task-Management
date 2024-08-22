// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement/models/task_model.dart';
import '../providers/task_provider.dart';
import '../widgets/task_item_widget.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key});

  @override
  _TaskListViewState createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialTasks();
    });
  }

  void _loadInitialTasks() {
    final taskProvider = context.read<TaskProvider>();
    taskProvider.listKey = _listKey;
    final tasks = taskProvider.tasks;
    for (int i = 0; i < tasks.length; i++) {
      _listKey.currentState
          ?.insertItem(i, duration: const Duration(milliseconds: 500));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('  Tasks'),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.add_circle_outline_rounded,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () async {
                await Navigator.pushNamed(context, '/task-form');
                _loadInitialTasks();
              },
            ),
          ],
        ),
        body: Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            if (taskProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (taskProvider.tasks.isEmpty) {
              return const Center(child: Text('No tasks available.'));
            }

            return AnimatedList(
              key: _listKey,
              initialItemCount: taskProvider.tasks.length,
              itemBuilder: (context, index, animation) {
                if (index >= taskProvider.tasks.length) {
                  return Container();
                }
                final task = taskProvider.tasks[index];
                return _buildTaskItem(task, index, animation);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildTaskItem(Task task, int index, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: TaskItemWidget(task: task),
    );
  }
}
