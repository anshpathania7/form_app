import 'package:flutter/material.dart';

import '../../../enums/session_status.dart';

class SessionStatusChip extends StatelessWidget {
  final SessionStatus status;
  const SessionStatusChip({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.symmetric(horizontal: 24),
      label: Text(
        () {
          if (status == SessionStatus.completed) {
            return 'Completed';
          } else if (status == SessionStatus.performed) {
            return 'Performed';
          } else {
            return "";
          }
        }(),
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: () {
        if (status == SessionStatus.completed) {
          return Colors.blue;
        } else if (status == SessionStatus.performed) {
          return Colors.yellow[700];
        } else {
          return Colors.white;
        }
      }(),
    );
  }
}
