import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/core/models/task.dart';
import 'package:task_manager/core/providers/TaskProvider.dart';
import 'package:task_manager/theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../widgets/TaskCountdownTimer.dart';
import 'EditTask.dart';

class TaskDetailsPage extends StatelessWidget {
  final Task task;

  const TaskDetailsPage({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final startTime = DateFormat('h:mm a').format(task.startTime);
    final endTime = DateFormat('h:mm a').format(task.endTime);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTaskPage(task: task),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Show a confirmation dialog before deleting the task
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('تأكيد الحذف'),
                    content: const Text('هل انت متأكد من حذف هذه المهمة؟'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: const Text('الغاء'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Perform the delete operation
                          taskProvider.deleteTask(task.id!);
                          Navigator.pop(context); // Close the dialog
                          Navigator.pop(context); // Close the details page
                        },
                        child: const Text('حذف'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.purple,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 100,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),

                    child:TimerCountdown(
                    format: CountDownTimerFormat.hoursMinutesSeconds,
                    endTime: DateTime.now().add(
                      taskProvider.getRemainingTime(task.id ?? 0),
                    ),
                    timeTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    descriptionTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                    ),
                    onEnd: () {
                      print('Current Time: ${DateTime.now()}');
                      print('End Time: ${task.endTime}');
                      print('Remaining Time: ${taskProvider.getRemainingTime(task.id ?? 0)}');
                      print('endtime : ${endTime}');
                      print("Timer finished");
                    },
                  ),


                ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                task.title,
                style: AppTextStyles.headline1,
              ),
              const SizedBox(height: 16),
              Text(
                'Due Date: ${task.dueDate}',
                style: AppTextStyles.bodyText,
              ),
              const SizedBox(height: 16),
              Text(
                'Start Time: $startTime',
                style: AppTextStyles.bodyText,
              ),
              const SizedBox(height: 16),
              Text(
                'End Time: $endTime',
                style: AppTextStyles.bodyText,
              ),
              const SizedBox(height: 16),
              Text(
                'Description:',
                style: AppTextStyles.headline1,
              ),
              const SizedBox(height: 8),
              Text(
                task.description,
                style: AppTextStyles.bodyText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}