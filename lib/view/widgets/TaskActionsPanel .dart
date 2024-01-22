import 'package:flutter/material.dart';

class TaskActionsPanel extends StatelessWidget {
  final Function() onEditPressed;
  final Function() onDeletePressed;
  final Function() onCompletePressed;

  const TaskActionsPanel({
    Key? key,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.onCompletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: onEditPressed,
            child: const Text('تعديل'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onDeletePressed,
            child: const Text('حذف'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onCompletePressed,
            child: const Text('اكمال المهمة'),
          ),
        ],
      ),
    );
  }
}
