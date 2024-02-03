import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/theme/app_text_styles.dart';
import '../../core/models/task.dart';
import '../../core/providers/TaskProvider.dart';
import '../../core/providers/authentication_provider.dart';
import '../widgets/TaskChart.dart';
import '../widgets/customCard.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    taskProvider.loadCompletedTasks();

    List<Task> completedTasks = taskProvider.completedTasks;

    Future<void> confirmLogout() async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Align(
                alignment: Alignment.center,
                child: Text(
                  'تأكيد الخروج',
                  style: AppTextStyles.done,
                )),
            content: Text(
              'هل انت متأكد من تسجيل الخروج',
              style: AppTextStyles.bodyText,
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('الغاء'),
                  ),
                  TextButton(
                    onPressed: () {
                      AuthenticationProvider().logOut();
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/login', (route) => false);
                    },
                    child: const Text('تأكيد'),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'ملخص النشاط',
          style: AppTextStyles.bodyText,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: confirmLogout,
          ),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.24,
                  child: const TasksChart(),
                ),
                Text('المهام المنجزة', style: AppTextStyles.bodyText),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                        onPressed: () {},
                        index: index,
                        deleteIcone: () {
                          taskProvider.deleteCompletedTask(task.id ?? 0);
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
