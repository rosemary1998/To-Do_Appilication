

import '../models/task.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}
//state for loading
class TaskLoaded extends TaskState {
  final List<Task> tasks;
  TaskLoaded(this.tasks);
}
//state for filtering
class TaskFiltered extends TaskState {
  final List<Task> filteredTasks;
  TaskFiltered(this.filteredTasks);
}

