import 'package:flutter/material.dart';

import '../../../../models/session_model.dart';

class RehabSessionCard extends StatelessWidget {
  final SessionModel session;
  const RehabSessionCard({Key? key, required this.session}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.timer,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    session.getTimeString,
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    session.getDateString,
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          const Text(
            "View Results",
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
