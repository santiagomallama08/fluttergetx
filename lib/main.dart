import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class Task {
  String title;
  bool completed;

  Task(this.title, this.completed);
}

class TaskController extends GetxController {
  RxList<Task> tasks = <Task>[].obs;

  void addTask(String title) {
    tasks.add(Task(title, false));
  }

  void toggleTask(int index) {
    tasks[index].completed = !tasks[index].completed;
  }

  void removeTask(int index) {
    tasks.removeAt(index);
  }
}

class MyApp extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Task App'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Add a new task',
                ),
                onFieldSubmitted: (value) {
                  taskController.addTask(value);
                },
              ),
              SizedBox(height: 20),
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    itemCount: taskController.tasks.length,
                    itemBuilder: (context, index) {
                      Task task = taskController.tasks[index];
                      return ListTile(
                        title: Text(task.title),
                        leading: Checkbox(
                          value: task.completed,
                          onChanged: (value) {
                            taskController.toggleTask(index);
                          },
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            taskController.removeTask(index);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
