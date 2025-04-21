import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const MainApp());
  }
}

class Task {
  String describe;
  bool isChecked;

  Task(this.describe, {this.isChecked = false});
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final List<Task> _tasks = [Task("task1"), Task("task2", isChecked: true)];

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          title: Text("TODO List"),
        ),
        body: ReorderableListView.builder(
          itemCount: _tasks.length,
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (newIndex > oldIndex) newIndex--;
              final task = _tasks.removeAt(oldIndex);
              _tasks.insert(newIndex, task);
            });
          },
          itemBuilder: (BuildContext context, int index) {
            final task = _tasks[index];
            return dismissSwipe(task);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => dialogWindow(context),
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget dismissSwipe(task) {
    return Dismissible(
      key: ValueKey(task.describe),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          _tasks.remove(task);
        });
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: taskContainer(task),
    );
  }

  Widget taskContainer(task) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: 150,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      color: task.isChecked ? Colors.green : Colors.amber,
      child: Row(
        children: [
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder:
                  (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
              child: Text(
                task.describe,
                key: ValueKey<bool>(task.isChecked),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: task.isChecked ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          const Spacer(),
          Checkbox(
            value: task.isChecked,
            onChanged: (_) {
              setState(() {
                task.isChecked = task.isChecked == true ? false : true;
              });
            },
          ),
        ],
      ),
    );
  }

  void _addTask() {
    final text = _controller.text.trim();
    setState(() {
      _tasks.insert(0, Task(text));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<String?> dialogWindow(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder:
          (BuildContext context) => Dialog(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 30),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: "Enter task here"),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _addTask();
                          _controller.clear();
                        },
                        child: const Text('Add'),
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
