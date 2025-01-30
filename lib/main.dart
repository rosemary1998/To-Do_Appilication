import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'bloc/task_bloc.dart';
import 'bloc/task_event.dart';
import 'repository/task_repository.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SQLite database
  final database = await openDatabase(
    join(await getDatabasesPath(), 'tasks_database.db'),
    onCreate: (db, version) {
      return db.execute(
        '''
        CREATE TABLE tasks ( 
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          title TEXT NOT NULL,
          description TEXT,
          isCompleted INTEGER NOT NULL DEFAULT 0
        )
        ''',
      );
    },
    version: 1,
  );

  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final Database database;

  const MyApp({Key? key, required this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(TaskRepository(database))
        ..add(FilterTasksEvent(null)), // Initialize the app with all tasks
      child: MaterialApp(
        title: 'To-Do App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
