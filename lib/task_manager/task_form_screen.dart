import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';

class TaskFormScreen extends StatefulWidget {
  final Task? task;
  TaskFormScreen({this.task});

  @override
  _TaskFormScreenState createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final deadlineController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      titleController.text = widget.task!.title;
      descriptionController.text = widget.task!.description;
      deadlineController.text = widget.task!.deadline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.task == null ? 'Tambah Tugas' : 'Edit Tugas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: InputDecoration(labelText: 'Judul')),
            TextField(controller: descriptionController, decoration: InputDecoration(labelText: 'Deskripsi')),
            TextField(controller: deadlineController, decoration: InputDecoration(labelText: 'Deadline')),
            ElevatedButton(
              onPressed: () {
                if (widget.task == null) {
                  Provider.of<TaskProvider>(context, listen: false).addTask(
                    Task(title: titleController.text, description: descriptionController.text, deadline: deadlineController.text),
                  );
                } else {
                  Provider.of<TaskProvider>(context, listen: false).updateTask(
                    Task(id: widget.task!.id, title: titleController.text, description: descriptionController.text, deadline: deadlineController.text),
                  );
                }
                Navigator.pop(context);
              },
              child: Text('Simpan'),
            )
          ],
        ),
      ),
    );
  }
}
