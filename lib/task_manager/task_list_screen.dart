import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task_model.dart';
import 'task_form_screen.dart';
import '../services/auth_service.dart';

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider()..fetchTasks(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Daftar Tugas'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => AuthService().signOut(),
            )
          ],
        ),
        body: Consumer<TaskProvider>(
          builder: (context, provider, child) {
            return ListView.builder(
              itemCount: provider.tasks.length,
              itemBuilder: (context, index) {
                Task task = provider.tasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text('${task.description} | Deadline: ${task.deadline}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => provider.deleteTask(task.id!),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TaskFormScreen(task: task),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => TaskFormScreen()),
            );
          },
        ),
      ),
    );
  }
}
