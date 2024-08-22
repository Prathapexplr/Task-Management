// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/custom_date_picker.dart';
import '../widgets/custom_button.dart';

class TaskFormView extends StatefulWidget {
  final Task? task;

  const TaskFormView({super.key, this.task});

  @override
  _TaskFormViewState createState() => _TaskFormViewState();
}

class _TaskFormViewState extends State<TaskFormView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  DateTime? _dueDate;
  String? _priority;
  String? _status;
  int? _assignedUserId;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.task?.description ?? '');
    _dueDate = widget.task?.dueDate;
    _priority = widget.task?.priority;
    _status = widget.task?.status;
    _assignedUserId = widget.task?.userId;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Create Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: _titleController,
                labelText: 'Title',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                controller: _descriptionController,
                labelText: 'Description',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomDatePicker(
                initialDate: _dueDate,
                onDateSelected: (date) {
                  setState(() {
                    _dueDate = date;
                  });
                },
              ),
              CustomDropdown(
                value: _priority,
                items: ['High', 'Medium', 'Low'].map((String priority) {
                  return DropdownMenuItem<String>(
                    value: priority,
                    child: Text(priority),
                  );
                }).toList(),
                labelText: 'Priority',
                onChanged: (value) {
                  setState(() {
                    _priority = value;
                  });
                },
              ),
              CustomDropdown(
                value: _status,
                items: ['To-Do', 'In Progress', 'Done'].map((String status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                labelText: 'Status',
                onChanged: (value) {
                  setState(() {
                    _status = value;
                  });
                },
              ),
              Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  return CustomDropdown(
                    value: _assignedUserId?.toString(),
                    items: userProvider.users.map((user) {
                      return DropdownMenuItem<String>(
                        value: user.id.toString(),
                        child: Text('${user.firstName} ${user.lastName}'),
                      );
                    }).toList(),
                    labelText: 'Assign To',
                    onChanged: (value) {
                      setState(() {
                        _assignedUserId = int.tryParse(value!);
                      });
                    },
                  );
                },
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height / 4),
              CustomButton(
                text: widget.task == null ? 'Create Task' : 'Update Task',
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    final task = Task(
                      id: widget.task?.id ??
                          DateTime.now().millisecondsSinceEpoch,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      dueDate: _dueDate!,
                      priority: _priority!,
                      status: _status!,
                      userId: _assignedUserId!,
                    );
                    if (widget.task == null) {
                      await context.read<TaskProvider>().createTask(task);
                    } else {
                      await context.read<TaskProvider>().updateTask(task);
                    }
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
