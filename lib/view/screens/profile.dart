import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/theme/app_colors.dart';
import 'package:task_manager/theme/app_text_styles.dart';
import 'package:task_manager/view/components/CustomAppBar.dart';
import '../../core/models/task.dart';
import '../../core/providers/TaskProvider.dart';
import '../widgets/TaskChart.dart';
import '../widgets/customCard.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    taskProvider.loadCompletedTasks();

    List<Task> completedTasks = taskProvider.completedTasks;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'ملخص النشاط',
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: const TasksChart(), // Add the TasksChart widget
                ),
                 Text('المهام المنجزة', style: AppTextStyles.bodyText),
                const SizedBox(height: 10),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.56,
                  child: ListView.builder(
                    itemCount: completedTasks.length,
                    itemBuilder: (context, index) {
                      Task task = completedTasks[index];
                      return CustomTaskCard(
                        height: 130,
                        taskName: task.title,
                        date: task.dueDate,
                        startTime: task.startTime,
                        endTime: task.endTime,
                        onPressed: () {
                          // Handle onTap for completed task card
                        },
                        index: index,
                        deleteIcone: () {
                          taskProvider.deleteCompletedTask(task.id ?? 0);
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2 ,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
