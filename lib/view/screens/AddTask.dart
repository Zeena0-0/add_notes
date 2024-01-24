import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/view/components/CustomAppBar.dart';
import 'package:task_manager/view/components/NvigationBarContent.dart';
import 'package:task_manager/view/screens/home.dart';
import '../../core/models/task.dart';
import '../../core/providers/TaskProvider.dart';
import '../components/AnimatedTextField.dart';
import '../components/AppElevatedButton.dart';
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
    _titleController.addListener(updateSaveButtonState);
    _startDateController.addListener(updateSaveButtonState);
    _endDateController.addListener(updateSaveButtonState);
    _descriptionController.addListener(updateSaveButtonState);
    _dateController.addListener(updateSaveButtonState);
  }

  void updateSaveButtonState() {
    setState(() {
      isSaveButtonEnabled = _titleController.text.isNotEmpty &&
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
    final parsedTime =
        DateFormat('yyyy-MM-dd hh:mm a').parse('$dateString $timeString');

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
                  AppElevatedButton(
                    onPressed: isSaveButtonEnabled
                        ? () {
                            DateTime startTime = parseDateTime(
                                _startDateController.text,
                                _dateController.text);
                            DateTime endTime = parseDateTime(
                                _endDateController.text, _dateController.text);

                            if (startTime.isAfter(endTime)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'الوقت غير صالح , تاريخ النهاية يجب ان يكون بعد تاريخ البداية'),
                                ),
                              );
                              return;
                            }
                            Task newTask = Task(
                              title: _titleController.text,
                              dueDate: _dateController.text,
                              startTime: startTime,
                              endTime: endTime,
                              description: _descriptionController.text,
                            );

                            taskProvider.addTask(newTask);

                            _titleController.clear();
                            _startDateController.clear();
                            _endDateController.clear();
                            _descriptionController.clear();
                            _dateController.clear();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          }
                        : () {},
                    label: 'حفظ',
                  ),
                  AppElevatedButton(
                    onPressed: () {
                      _titleController.clear();
                      _startDateController.clear();
                      _endDateController.clear();
                      _descriptionController.clear();
                      _dateController.clear();
                    },
                    label: 'إلغاء',
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
