import 'dart:async';

import 'package:flutter/foundation.dart';

import '../database_helper.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;
  Task getTaskById(int taskId) {
    return _tasks.firstWhere((task) => task.id == taskId, orElse: () => Task(title: '', description: '', dueDate: '', startTime:  DateTime.now(), endTime: DateTime.now()));
  }
  Future<void> loadTasks() async {
    final dbHelper = DatabaseHelper();
    _tasks = await dbHelper.getAllTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    final dbHelper = DatabaseHelper();
    await dbHelper.insertTask(task);
    print('title : ${task.title} , description :${task.description} , date :${task.dueDate} , start time : ${task.startTime} , end time :${task.endTime}');
    await loadTasks(); // Reload tasks after adding a new task
  }
  void updateTask(Task updatedTask) {
    int index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }
  Future<void> editTask(Task updatedTask) async {
    final dbHelper = DatabaseHelper();
    await dbHelper.updateTask(updatedTask);
    await loadTasks(); // Reload tasks after editing a task
  }

  Future<void> deleteTask(int taskId) async {
    final dbHelper = DatabaseHelper();
    await dbHelper.deleteTask(taskId);
    await loadTasks(); // Reload tasks after deleting a task
  }

  Duration getRemainingTime(int taskId) {
    final task = getTaskById(taskId);
    final currentTime = DateTime.now();

    if (task.endTime.isAfter(currentTime)) {
      final remainingTime = task.endTime.difference(currentTime);

      print('Task ID: $taskId');
      print('Current Time: $currentTime');
      print('Task End Time: ${task.endTime}');
      print('Remaining Time: $remainingTime');

      return remainingTime;
    } else {
      // Task has already ended
      print('Task has already ended.');
      return Duration.zero;
    }
  }



}
