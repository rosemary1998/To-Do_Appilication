

import '../models/task.dart';

abstract class TaskEvent {}
//add event
class AddTaskEvent extends TaskEvent {
  final Task task;
  AddTaskEvent(this.task);
}
//update event
class UpdateTaskEvent extends TaskEvent {
  final Task task;
  UpdateTaskEvent(this.task);
}
//delete event
class DeleteTaskEvent extends TaskEvent {
  final int id;
  DeleteTaskEvent(this.id);
}
//filter event
class FilterTasksEvent extends TaskEvent {
  final bool? isCompleted; // null for all tasks
  FilterTasksEvent(this.isCompleted);
}
