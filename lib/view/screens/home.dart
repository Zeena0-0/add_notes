import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/TaskProvider.dart';
import '../components/CustomAppBar.dart';
import '../widgets/customCard.dart';
import 'TaskDetailsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Load tasks when the widget is initialized
    Provider.of<TaskProvider>(context, listen: false).loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'المهام',
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          if (taskProvider.tasks.isEmpty) {
            // Placeholder when the task list is empty
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/task.png', width: MediaQuery.of(context).size.width * 0.7, // Adjust the width as needed
                      fit: BoxFit.contain,), // Replace with your image path
                     SizedBox(height:  MediaQuery.of(context).size.width * 0.2),
                    Text('ابدأ باضافة مهام جديدة ', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: CustomTaskCard(
                    taskName: task.title,
                    date: task.dueDate,
                    startTime: task.startTime,
                    endTime: task.endTime,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetailsPage(task: task),
                        ),
                      );
                    },
                    index: index,
                    onMarkAsCompleted: () {
                      taskProvider.markTaskAsCompleted(task.id ?? 0);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
