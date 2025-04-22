import 'package:flutter/material.dart';
import 'tasks_model.dart';

class TasksProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  // TasksProvider(this._tasks);

  void addTask(Task task) {
    _tasks.insert(0, task);
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
