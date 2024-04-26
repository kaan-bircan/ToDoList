import 'package:flutter/material.dart';
import 'package:sqflitedatabase/screens/TaskDetailsScreen.dart';
import '../model/Task.dart';
import '../model/SubTask.dart';
import 'package:uuid/uuid.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = []; // List to hold tasks

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: _buildTaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskList() {
    if (tasks.isEmpty) {
      return Center(child: Text('No tasks yet'));
    } else {
      return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          Task task = tasks[index];
          return ListTile(
                title: Text(task.title),
              subtitle: Text(task.description),
  trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
             builder: (context) => TaskDetailsScreen(task: task),
            ),
          );
        },
        child: Icon(Icons.info),
      ),
      SizedBox(width: 16), 
      GestureDetector(
        onTap: () {
          _showDeleteDialog(task);
        },
        child: Icon(Icons.delete),
      ),
    ],
  ),
  onTap: () {
    _showEditDialog(task);
  },
);
        },
      );
    }
  }

  void _showAddDialog() {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String title = titleController.text.trim();
                String description = descriptionController.text.trim();
                if (title.isNotEmpty) {
                  String id = Uuid().v4(); // Generate a unique ID
                  Task newTask = Task(id: id, title: title, description: description, isCompleted: false);
                  setState(() {
                    tasks.add(newTask); // Add the new task to the list
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(Task task) {
  TextEditingController titleController =
      TextEditingController(text: task.title);
  TextEditingController descriptionController =
      TextEditingController(text: task.description);

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Edit Task',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    String newTitle = titleController.text.trim();
                    String newDescription = descriptionController.text.trim();
                    if (newTitle.isNotEmpty) {
                      setState(() {
                        task.title = newTitle;
                        task.description = newDescription;
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}


  void _showDeleteDialog(Task task) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Task'),
          content: Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  tasks.remove(task); // Remove task from the list
                });
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
