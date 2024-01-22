import 'dart:async';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
//
// class CustomCountdownTimer extends StatefulWidget {
//   final String startTime;
//   final String endTime;
//
//   const CustomCountdownTimer({
//     required this.startTime,
//     required this.endTime,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   _CustomCountdownTimerState createState() => _CustomCountdownTimerState();
// }
//
// class _CustomCountdownTimerState extends State<CustomCountdownTimer> {
//   late Timer _timer;
//   Duration _timeLeft = Duration();
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Calculate the initial time left
//     _calculateTimeLeft();
//
//     // Update the timer every second
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       _calculateTimeLeft();
//     });
//   }
//
//   void _calculateTimeLeft() {
//     final now = DateTime.now();
//     final startTime = DateTime.parse(widget.startTime);
//     final endTime = DateTime.parse(widget.endTime);
//
//     if (now.isAfter(endTime)) {
//       // Timer has expired
//       _timer.cancel();
//       setState(() {
//         _timeLeft = Duration();
//       });
//     } else if (now.isBefore(startTime)) {
//       // Task has not started yet
//       setState(() {
//         _timeLeft = startTime.difference(now);
//       });
//     } else {
//       // Task is in progress
//       setState(() {
//         _timeLeft = endTime.difference(now);
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final hours = _timeLeft.inHours;
//     final minutes = (_timeLeft.inMinutes % 60);
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           'Time Left: $hours:${minutes.toString().padLeft(2, '0')}',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//       ],
//     );
//   }
// }
