import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanagement/providers/task_provider.dart';
import '../models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  final Task task;

  const TaskItemWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white24),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(
                task.title,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    'Description: ${task.description}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 176, 176, 176),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.date_range,
                          color: Colors.blueAccent, size: 16),
                      const SizedBox(width: 5),
                      Text(
                        'Due Date: ${task.dueDate.toLocal().toString().split(' ')[0]}',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 176, 176, 176),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.priority_high,
                          color: Colors.yellowAccent, size: 16),
                      const SizedBox(width: 5),
                      Text(
                        'Priority: ${task.priority}',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 176, 176, 176),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.check_circle,
                          color: Colors.greenAccent, size: 16),
                      const SizedBox(width: 5),
                      Text(
                        'Status: ${task.status}',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 176, 176, 176),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  context.read<TaskProvider>().deleteTask(task.id);
                },
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/task-form',
                  arguments: task,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
