class Task {
  String describe;
  bool isChecked;

  Task(this.describe, {this.isChecked = false});

  Task copyWith({String? describe, bool? isChecked}) {
    return Task(
      describe ?? this.describe,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
