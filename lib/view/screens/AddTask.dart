import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/view/components/CustomAppBar.dart';
import '../../core/models/task.dart';
import '../../core/providers/TaskProvider.dart';
import '../components/AnimatedTextField.dart';
import '../components/DateTextField.dart';
import '../components/CustomTimeRangeField.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  bool isSaveButtonEnabled = false;

  @override
  void initState() {
    super.initState();

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
    // Use the intl package for parsing time
    final parsedTime = DateFormat('yyyy-MM-dd hh:mm a').parse('$dateString $timeString');

    return parsedTime;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'اضافة مهمة',
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
                labelText: 'Time Range',
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
                  ElevatedButton(
                    onPressed: isSaveButtonEnabled
                        ? () {
                      // Validate the time range
                      DateTime startTime = parseDateTime(_startDateController.text, _dateController.text);
                      DateTime endTime = parseDateTime(_endDateController.text, _dateController.text);

                      if (startTime.isAfter(endTime)) {
                        // Show an error message for invalid time range
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Invalid time range. Start time should be before end time.'),
                          ),
                        );
                        return;
                      }

                      // Create a task object from the entered data
                      Task newTask = Task(
                        title: _titleController.text,
                        dueDate: _dateController.text,
                        startTime: startTime,
                        endTime: endTime,
                        description: _descriptionController.text,
                      );

                      // Add the task using the provider
                      taskProvider.addTask(newTask);

                      // Clear text fields
                      _titleController.clear();
                      _startDateController.clear();
                      _endDateController.clear();
                      _descriptionController.clear();
                      _dateController.clear();
                    }
                        : null,

                    child: const Text('حفظ'),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      // Implement cancel functionality
                      Navigator.pop(context);
                    },
                    child: const Text('إلغاء'),
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
