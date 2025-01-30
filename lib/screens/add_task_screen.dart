import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? task;
  const AddTaskScreen({Key? key, this.task}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String? _description;

  @override
  void initState() {
    super.initState();
    _title = widget.task?.title ?? '';
    _description = widget.task?.description ?? '';
  }
//code for saving task
  void _saveTask() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final task = Task(
        id: widget.task?.id,
        title: _title,
        description: _description,
        isCompleted: widget.task?.isCompleted ?? false,
      );

      if (widget.task == null) {
        context.read<TaskBloc>().add(AddTaskEvent(task));
      } else {
        context.read<TaskBloc>().add(UpdateTaskEvent(task));
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.task == null ? 'Add Task' : 'Edit Task',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

              const SizedBox(height: 10),
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                //checking the vale if there is no value showing erroe message as 'Title is required'
                validator: (value) => value == null || value.isEmpty ? 'Title is required' : null,
                onSaved: (value) => _title = value!,
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value,//for saving
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveTask,
                child: const Text('Save Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
