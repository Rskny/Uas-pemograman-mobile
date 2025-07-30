import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/db_helper.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  final DBHelper _dbHelper = DBHelper();

  List<Task> get tasks => _tasks;

  Future<void> fetchTasks() async {
    _tasks = await _dbHelper.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _dbHelper.insertTask(task);
    await fetchTasks();
  }

  Future<void> updateTask(Task task) async {
    await _dbHelper.updateTask(task);
    await fetchTasks();
  }

  Future<void> deleteTask(int id) async {
    await _dbHelper.deleteTask(id);
    await fetchTasks();
  }
}
