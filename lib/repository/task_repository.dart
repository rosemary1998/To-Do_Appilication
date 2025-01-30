import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class TaskRepository {
  final Database db;

  TaskRepository(this.db);
//for adding task to bd
  Future<void> addTask(Task task) async {
    await db.insert('tasks', task.toMap());
  }
//for fech task from db
  Future<List<Task>> getTasks() async {
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    orderBy: 'id ASC';
    return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
  }
//updating the existing task from  bd
  Future<void> updateTask(Task task) async {
    await db.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }
//for deleting task from the db
  Future<void> deleteTask(int id) async {
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
