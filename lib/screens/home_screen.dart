import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';
import '../models/task.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = "";
  bool? filterStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          //  for Search Bar
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search tasks...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),

          // Segmented Control for Filtering
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ToggleButtons(
              isSelected: [filterStatus == null, filterStatus == true, filterStatus == false],
              onPressed: (index) {
                setState(() {
                  if (index == 0) filterStatus = null;
                  if (index == 1) filterStatus = true;
                  if (index == 2) filterStatus = false;
                  context.read<TaskBloc>().add(FilterTasksEvent(filterStatus));
                });
              },
              children: const [
                Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Text("All")),
                Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Text("Completed")),
                Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Text("Pending")),
              ],
            ),
          ),

          // Task List
          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskLoaded || state is TaskFiltered) {
                  final tasks = state is TaskLoaded ? state.tasks : (state as TaskFiltered).filteredTasks;
                  final filteredTasks = tasks.where((task) =>
                  task.title.toLowerCase().contains(searchQuery) ||
                      (task.description ?? "").toLowerCase().contains(searchQuery)).toList();

                  if (filteredTasks.isEmpty) {
                    return const Center(child: Text("No tasks found."));
                  }

                  return ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          leading: Checkbox(
                            value: task.isCompleted,
                            onChanged: (value) {
                              context.read<TaskBloc>().add(UpdateTaskEvent(task.copyWith(isCompleted: value ?? false)));
                            },
                          ),
                          title: /*Text(task.title,
                              style: TextStyle(
                                  decoration: task.isCompleted ? TextDecoration.lineThrough : null)),
                         */

                          Text(
                            "${task.id} - ${task.title}", // Displaying ID
                            style: TextStyle(
                                decoration: task.isCompleted ? TextDecoration.lineThrough : null),
                          ),
                          subtitle: Text(task.description ?? "No description"),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              context.read<TaskBloc>().add(DeleteTaskEvent(task.id!));
                            },
                          ),
                          onTap: () => _editTask(context, task),
                        ),
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),

      // Floating Action Button to Add Task
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNewTask(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
//function for adding new task
  void _addNewTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const AddTaskScreen(),
    );
  }
//function for editing the existing task
  void _editTask(BuildContext context, Task task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddTaskScreen(task: task),
    );
  }
}
