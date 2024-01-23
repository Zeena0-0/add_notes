import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:task_manager/core/providers/TaskProvider.dart';
import 'package:task_manager/theme/app_colors.dart';
import 'package:task_manager/theme/app_text_styles.dart';

class ChartData {
  ChartData(this.x, this.y, [this.color]);

  final String x;
  final double y;
  final Color? color;
}

class TasksChart extends StatelessWidget {
  const TasksChart({Key? key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final completedTasks = taskProvider.completedTasks;
    final notCompletedTasks = taskProvider.tasks.where((task) => !task.isCompleted).toList();
    const completedColor = AppColors.purple;
    const notCompletedColor = AppColors.orange;
    final List<ChartData> chartData = [
      ChartData('Completed', completedTasks.length.toDouble(), completedColor),
      ChartData('Not Completed', notCompletedTasks.length.toDouble(), notCompletedColor),
    ];

    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: screenSize.width * 0.8, // Use a percentage of the screen width
          height: screenSize.height * 0.3, // Use a square chart
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: screenSize.width * 0.8,
                height: screenSize.height * 0.15, // Adjust the height accordingly
                child: SfCircularChart(
                  series: <CircularSeries>[
                    // Render pie chart
                    PieSeries<ChartData, String>(
                      dataSource: chartData,
                      pointColorMapper: (ChartData data, _) => data.color,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        labelPosition: ChartDataLabelPosition.outside,
                        textStyle: TextStyle(
                          color: Colors.black, // Customize label text color
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      enableTooltip: false,
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'غير منجزة',
                      style: AppTextStyles.notdone
                  ),
                  Text(
                      'منجزة',
                      style: AppTextStyles.done
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
