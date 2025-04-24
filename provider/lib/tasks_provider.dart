import 'package:flutter/material.dart';
import 'tasks_model.dart';

class TasksProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.insert(0, task);
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void toggleTask(Task task) {
    final index = _tasks.indexOf(task);
    if (index != -1) {
      _tasks[index] = task.copyWith(isChecked: !task.isChecked);
    }
    notifyListeners();
  }
}
