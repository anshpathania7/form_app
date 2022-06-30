import 'package:firebase_database/firebase_database.dart';

import '../enums/session_status.dart';

class SessionModel {
  String? id;
  final String title;
  final SessionStatus status;
  final DateTime performedAt;

  SessionModel({
    required this.id,
    required this.title,
    required this.status,
    required this.performedAt,
  });

  String get getTimeString {
    final amOrPm = performedAt.hour > 12 ? 'p.m' : 'a.m';
    final hr = performedAt.hour > 12
        ? (performedAt.hour - 12).toString().padLeft(2, '0')
        : performedAt.hour.toString().padLeft(2, '0');
    final mm = performedAt.minute.toString().padLeft(2, '0');
    return "$hr:$mm $amOrPm";
  }

  String get getDateString => performedAt.toLocal().toString().substring(0, 11);

  factory SessionModel.fromJson(DataSnapshot snap) {
    final data = snap.value as dynamic;

    return SessionModel(
      id: snap.key,
      title: data['title'],
      status: SessionStatus.values[data['status']],
      performedAt: DateTime.parse(data['performedAt']),
    );
  }

  Map<String, dynamic> convertToJson() => {
        'id': id,
        'title': title,
        'status': status.index,
        'performedAt': performedAt.toUtc().toIso8601String(),
      };
}
