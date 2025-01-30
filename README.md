# To-Do_Appilication

Overview
--------

A simple To-Do application built using Flutter with BLoC (Business Logic Component) state management and SQLite for persistent local storage. The app allows users to create, read, update, delete, and filter tasks based on completion status.

Features
--------

	Create Task: Add new tasks with a title and optional description.

	Read Tasks: View a list of all tasks with their unique ID.

	Update Task: Edit existing tasks, including title and description.

	Delete Task: Remove tasks from the list.

	Filter Tasks: View tasks based on their completion status (All, Completed, Pending).

	Task ID: Each task has an auto-incrementing unique identifier.

	Search Functionality: Search for tasks by title or description.

	BLoC State Management: Handles business logic for better performance.

	SQLite Database: Ensures tasks persist even after restarting the app.

Installation
------------

 1 Clone the repository

	git clone https://github.com/rosemary1998/To-Do_Appilication

2 Add the commands for installing
	Install dependencies

  		flutter pub get

	Run the app

		flutter run

3 Project Structure

lib/

    │-- main.dart              # Entry point of the application

   
    │-- models/
  
      │   ├── task.dart          # Task model with ID, title, description, and status 

    │-- screens/

      │   ├── home_screen.dart   # Displays the task list and provides user controls

      │   ├── add_task_screen.dart  # UI for adding and editing tasks

    │-- bloc/

      │   ├── task_bloc.dart     # BLoC implementation for handling business logic

      │   ├── task_event.dart    # Defines different events for task actions (add, update, delete)

      │   ├── task_state.dart    # Defines different states for task handling (loading, success, failure)

    │-- repository/

      │   ├── task_repository.dart  # Handles all SQLite database operations for storing and retrieving tasks



How It Works
------------

1 Task Creation

	When the user taps the + button, a modal bottom sheet opens for entering task details, and the task is saved to the database and displayed in the task list.

2 Task Completion Toggle

	Each task has a checkbox that, when checked, marks the task as completed.

3 Updating a Task

	Tapping a task opens an edit modal where changes are saved and updated in the database.

4 Deleting a Task

	A delete button removes the task from the list and database.

5 Filtering Tasks

	A toggle button allows filtering tasks by status (All, Completed, Pending).


Dependencies
------------

    dependencies:

        flutter:
  
          sdk: flutter
    
        bloc: ^9.0.0
  
        sqflite: ^2.3.3+1
  
        flutter_bloc: ^9.0.0

