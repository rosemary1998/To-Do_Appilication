import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_application/main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Create a mock database for testing
Future<Database> createTestDatabase() async {
  return openDatabase(
    // Use in-memory database for testing
    inMemoryDatabasePath, 
    version: 1,
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
  );
}

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Create a test database
    final database = await createTestDatabase();

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(database: database));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
