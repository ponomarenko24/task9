import 'package:flutter_bloc/flutter_bloc.dart';
import 'tasks_model.dart';

class TasksCubit extends Cubit<List<Task>> {
  TasksCubit() : super([]);

  void addTask(Task task) => emit([task, ...state]);

  void removeTask(Task task) => emit(state.where((t) => t != task).toList());

  void toggleTask(Task task) {
  final updatedTasks = state.map((t) {
    if (t == task) {
      return t.copyWith(isChecked: !t.isChecked);
    }
    return t;
  }).toList();

  emit(updatedTasks);
  }
}
