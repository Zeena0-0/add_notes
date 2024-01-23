class Task {
  int? id;
  String title;
  String description;
  String dueDate;
  DateTime startTime;
  DateTime endTime;
  bool isCompleted;
  Task({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.startTime,
    required this.endTime,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'due_date': dueDate,
      'start_time': startTime.toIso8601String(), // Convert DateTime to String
      'end_time': endTime.toIso8601String(), // Convert DateTime to String
      'is_completed': isCompleted ? 1 : 0,

    };
  }


  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: map['due_date'],
      startTime: DateTime.parse(map['start_time']), // Parse String to DateTime
      endTime: DateTime.parse(map['end_time']), // Parse String to DateTime
      isCompleted: map['is_completed'] == 1,
    );
  }

}
