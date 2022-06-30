import 'package:flutter/material.dart';
import 'package:form_app/enums/session_status.dart';
import 'package:form_app/screen/home/widgets/session_status_chip.dart';

import '../../../../models/session_model.dart';

class SessionCard extends StatelessWidget {
  final SessionModel session;
  final int colorMode;
  SessionCard({Key? key, required this.session, this.colorMode = 0})
      : super(key: key);

  @override
  final _colors = [Colors.red, Colors.purple, Colors.teal];

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(
          color: Colors.grey,
          width: 1.2,
        ),
      ),
      child: Container(
        foregroundDecoration: BoxDecoration(
          color: session.status != SessionStatus.completed
              ? Colors.transparent
              : Colors.white70.withOpacity(0.6),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    Text(
                      session.title,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                    ),
                    if (session.status != SessionStatus.notStarted) ...[
                      SessionStatusChip(
                        status: session.status,
                      ),
                      Text(
                        () {
                          if (session.status == SessionStatus.completed) {
                            return "Performed At \n${session.getTimeString}";
                          } else {
                            return "Enter Pain Score";
                          }
                        }(),
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                    if (session.status != SessionStatus.completed) ...[
                      Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                session.status == SessionStatus.notStarted
                                    ? Icons.play_arrow
                                    : Icons.restart_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Chip(
                            label: Text(
                                session.status == SessionStatus.notStarted
                                    ? 'Play'
                                    : 'Restart'),
                            labelPadding:
                                const EdgeInsets.symmetric(horizontal: 18),
                          ),
                        ],
                      ),
                    ]
                  ],
                ),
              ),
              //const Spacer(flex: 1),
              Container(
                height: 120,
                width: 120,
                color: _colors[colorMode],
              )
            ],
          ),
        ),
      ),
    );
  }
}
