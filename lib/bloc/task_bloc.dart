import 'package:bloc/bloc.dart';
import 'package:to_do_application/bloc/task_event.dart';
import 'package:to_do_application/bloc/task_state.dart';

import '../repository/task_repository.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;
//interacting between db and block for adding task
  TaskBloc(this.repository) : super(TaskInitial()) {
    on<AddTaskEvent>((event, emit) async {
      await repository.addTask(event.task);
      emit(TaskLoaded(await repository.getTasks()));
    });
//interacting between db and block for update task
    on<UpdateTaskEvent>((event, emit) async {
      await repository.updateTask(event.task);
      emit(TaskLoaded(await repository.getTasks()));
    });
//interacting between db and block for delete the generated task
    on<DeleteTaskEvent>((event, emit) async {
      await repository.deleteTask(event.id);
      emit(TaskLoaded(await repository.getTasks()));
    });
//interacting between db and block for filtering the task
    on<FilterTasksEvent>((event, emit) async {
      final allTasks = await repository.getTasks();
      final filteredTasks = event.isCompleted == null
          ? allTasks
          : allTasks.where((task) => task.isCompleted == event.isCompleted).toList();
      emit(TaskFiltered(filteredTasks));
    });
  }
}

