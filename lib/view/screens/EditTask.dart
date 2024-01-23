
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/view/components/CustomAppBar.dart';
import '../../core/models/task.dart';
import '../../core/providers/TaskProvider.dart';
import '../components/AnimatedTextField.dart';
import '../components/AppElevatedButton.dart';
import '../components/DateTextField.dart';
import '../components/CustomTimeRangeField.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;

  const EditTaskPage({Key? key, required this.task}) : super(key: key);

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  late TextEditingController _dateController;

  bool isSaveButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    // Initialize text controllers with task data
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.description);
    _startDateController = TextEditingController(text: DateFormat('hh:mm a').format(widget.task.startTime));
    _endDateController = TextEditingController(text: DateFormat('hh:mm a').format(widget.task.endTime));
    _dateController = TextEditingController(text: widget.task.dueDate);

    // Add listeners to text controllers
    _titleController.addListener(updateSaveButtonState);
    _startDateController.addListener(updateSaveButtonState);
    _endDateController.addListener(updateSaveButtonState);
    _descriptionController.addListener(updateSaveButtonState);
    _dateController.addListener(updateSaveButtonState);
  }


  void updateSaveButtonState() {
    // Enable the "Save" button only when all text fields have values
    setState(() {
      isSaveButtonEnabled =
          _titleController.text.isNotEmpty &&
              _startDateController.text.isNotEmpty &&
              _endDateController.text.isNotEmpty &&
              _descriptionController.text.isNotEmpty &&
              _dateController.text.isNotEmpty;
    });
  }

  Future<void> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      _dateController.text = pickedDate.toLocal().toString().split(' ')[0];
    }
  }
  DateTime parseDateTime(String timeString, String dateString) {
    try {
      // Use the intl package for parsing time
      final parsedTime = DateFormat('yyyy-MM-dd hh:mm a').parse('$dateString $timeString');
      return parsedTime;
    } catch (e) {
      print('Error parsing date time: $dateString $timeString');
      print('Exception: $e');
      throw e; // Rethrow the exception after printing details
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'تعديل المهمة',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedTextField(
                controller: _titleController,
                maxHeight: screenSize.height * 0.2,
                minHeight: screenSize.height * 0.05,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 16.0),

              CustomDateTextField(
                controller: _dateController,
                labelText: 'Date',
                onTap: () {
                  pickDate();
                },
              ),
              const SizedBox(height: 16.0),

              CustomTimeRangeField(
                startController: _startDateController,
                endController: _endDateController,
                labelText: 'Time Rang',
              ),
              const SizedBox(height: 32.0),
              AnimatedTextField(
                controller: _descriptionController,
                maxHeight: screenSize.height * 0.4,
                minHeight: screenSize.height * 0.25,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppElevatedButton(
                    onPressed: isSaveButtonEnabled
                        ? () {
                      DateTime startTime = parseDateTime(_startDateController.text, _dateController.text);
                      DateTime endTime = parseDateTime(_endDateController.text, _dateController.text);

                      if (startTime.isAfter(endTime)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('الوقت غير صالح , تاريخ النهاية يجب ان يكون بعد تاريخ البداية'),
                          ),
                        );
                        return;
                      }
                      // Update the task using the provider
                      Task updatedTask = Task(
                        id: widget.task.id,
                        title: _titleController.text,
                        dueDate: _dateController.text,
                        startTime:startTime,
                        endTime: endTime,
                        description: _descriptionController.text,
                      );
                      taskProvider.editTask(updatedTask);
                      // Close the edit page
                      Navigator.pop(context);
                    }
                        :  () {},
                    label: 'حفظ',

                  ),
                  AppElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    label:'الغاء',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
