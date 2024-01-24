import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/core/models/task.dart';
import 'package:task_manager/core/providers/TaskProvider.dart';
import 'package:task_manager/theme/app_colors.dart';
import 'package:task_manager/view/components/AppElevatedButton.dart';
import '../../theme/app_text_styles.dart';
import '../widgets/TaskActionsPanel .dart';
import '../widgets/CosWaveTopSide4.dart';
import 'EditTask.dart';

class TaskDetailsPage extends StatelessWidget {
  final Task task;

  const TaskDetailsPage({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final startTime = DateFormat('h:mm a').format(task.startTime);
    final endTime = DateFormat('h:mm a').format(task.endTime);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  Text('تفاصيل المهمة',style: AppTextStyles.bodyText,),
        centerTitle: true,
      ),
      body: Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            final updatedTask = taskProvider.getTaskById(task.id ?? 0);

            return CustomSlidePanel(
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
                          child: TimerCountdown(
                            format: CountDownTimerFormat.hoursMinutesSeconds,
                            endTime: DateTime.now().add(
                              taskProvider.getRemainingTime(updatedTask.id ?? 0),
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
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      updatedTask.title,
                      style: AppTextStyles.headline1,
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        updatedTask.dueDate,
                        style: AppTextStyles.date,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'From $startTime  To $endTime',
                      style: AppTextStyles.date,
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left:20,right: 10,top: 20 ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          updatedTask.description,
                          style: AppTextStyles.bodyText,
                        ),
                      ),
                    ),
                     const SizedBox(height: 150 ,),
                  ],
                ),
              ),
            ),
            panel: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: CustomPaint(
                painter: CosWaveTopSide4(
                  waveColor4: AppColors.purple,
                ),
                child:  Stack(
                  children: [
                   SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit , color: Colors.white,size: 30,),
                            onPressed: (){
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => EditTaskPage(task: task,)));
                            },
                          ),

                          AppElevatedButton(
                            onPressed: () {
                              taskProvider.markTaskAsCompleted(task.id!);
                              taskProvider.deleteTask(task.id!);
                              Navigator.pop(context); // Close the details page
                            },
                            label: 'تم الاكمال', // You can customize the label
                            color: Colors.white,
                            textcolor: AppColors.purple,
                          ),



                          IconButton(
                            icon: const Icon(Icons.delete,color: Colors.white,size: 30),
                            onPressed: () {
                              // Show a confirmation dialog before deleting the task
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title:  Align(alignment: Alignment.center, child: Text('تأكيد الحذف' , style: AppTextStyles.bodyText,)),
                                    content: const Text('هل انت متأكد من حذف هذه المهمة؟'),
                                    actions: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
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
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      )
                    ),
                  ),
                   Positioned(
                     top: 10,
                     right: 0,
                     left: 0,
                     child: Container(
                       width: 30,
                       height: 30,
                       decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         color: Colors.white,
                         boxShadow: [
                           BoxShadow(
                             color: Colors.grey.withOpacity(0.5),
                             spreadRadius: 2,
                             blurRadius: 5,
                             offset: const Offset(0, 3),
                           ),
                         ],
                       ),
                       child: const Center(
                         child: Icon(
                           Icons.keyboard_double_arrow_up_outlined,
                           color:AppColors.purple,
                         ),
                       ),
                     ),
                   )

                 ]
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
