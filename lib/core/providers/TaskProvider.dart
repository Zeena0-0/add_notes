import 'dart:async';

import 'package:flutter/foundation.dart';

import '../database_helper.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;
  List<Task> _completedTasks = [];
  List<Task> get completedTasks => _completedTasks;
  final DatabaseHelper dbHelper = DatabaseHelper();

  void markTaskAsCompleted(int taskId) async {
    Task completedTask = getTaskById(taskId);
    completedTask.isCompleted = true;
    await dbHelper.insertCompletedTask(completedTask);
    await dbHelper.deleteTask(taskId);
    await loadTasks();

    notifyListeners();
  }

  Future<void> loadCompletedTasks() async {
    _completedTasks = await dbHelper.getCompletedTasks();
    notifyListeners();
  }

  Task getTaskById(int taskId) {
    return _tasks.firstWhere((task) => task.id == taskId,
        orElse: () => Task(
            title: '',
            description: '',
            dueDate: '',
            startTime: DateTime.now(),
            endTime: DateTime.now()));
  }

  Future<void> loadTasks() async {
    final dbHelper = DatabaseHelper();
    _tasks = await dbHelper.getAllTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await dbHelper.insertTask(task);
    await loadTasks();
  }

  Future<void> editTask(Task updatedTask) async {
    await dbHelper.updateTask(updatedTask);
    await loadTasks();
    notifyListeners();
  }

  Future<void> deleteCompletedTask(int taskId) async {
    await dbHelper.deleteCompleteTask(taskId);

    _completedTasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  Future<void> deleteTask(int taskId) async {
    await dbHelper.deleteTask(taskId);

    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  Duration getRemainingTime(int taskId) {
    final task = getTaskById(taskId);
    final currentTime = DateTime.now();

    if (task.endTime.isAfter(currentTime)) {
      final remainingTime = task.endTime.difference(currentTime);

      return remainingTime;
    } else {
      print('Task has already ended.');
      return Duration.zero;
    }
  }
}
