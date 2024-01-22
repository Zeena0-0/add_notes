class Task {
  int? id;
  String title;
  String description;
  String dueDate;
  bool isCompleted;
  DateTime startTime;
  DateTime endTime;
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
      'is_completed': isCompleted ? 1 : 0,
      'start_time': startTime.toIso8601String(), // Convert DateTime to String
      'end_time': endTime.toIso8601String(), // Convert DateTime to String
    };
  }


  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: map['due_date'],
      isCompleted: map['is_completed'] == 1,
      startTime: DateTime.parse(map['start_time']), // Parse String to DateTime
      endTime: DateTime.parse(map['end_time']), // Parse String to DateTime
    );
  }

}
