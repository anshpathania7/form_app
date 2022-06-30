import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/session_model.dart';

class SessionRepository {
  SessionRepository._privateConstructor();

  final _db = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL:
        ' https://rootally-test-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  static final SessionRepository _instance =
      SessionRepository._privateConstructor();

  factory SessionRepository() {
    return _instance;
  }

  Stream<SessionModel> listenForNewSessions() {
    final todaysDate = DateTime.now().toString().substring(0, 11);

    final databaseStream =
        _db.ref('sessions').child(todaysDate).limitToLast(1).onChildAdded;
    final sessionModelStream = databaseStream
        .map((dbEvent) => SessionModel.fromJson(dbEvent.snapshot));
    return sessionModelStream;
  }

  Stream<SessionModel> listenForUpdateSessions() {
    final todaysDate = DateTime.now().toString().substring(0, 11);

    final databaseStream = _db.ref('sessions').child(todaysDate).onChildChanged;
    final sessionModelStream = databaseStream
        .map((dbEvent) => SessionModel.fromJson(dbEvent.snapshot));
    return sessionModelStream;
  }

  Future<List<SessionModel>> getAllSessions() async {
    final todaysDate = DateTime.now().toString().substring(0, 11);
    final snapshots = await _db.ref('sessions').child(todaysDate).get();
    final sessionsIterable = snapshots.children.map(
      (e) {
        final model = SessionModel.fromJson(e);
        model.id = e.key;
        return model;
      },
    );
    final sessionsList = List<SessionModel>.of(sessionsIterable);
    return sessionsList;
  }

  Future<void> markAsCompleted(SessionModel session) async {
    try {
      if (session.id == null) {
        return;
      }
      final String todaysDate = session.getDateString;
      await _db
          .ref('sessions')
          .child(todaysDate)
          .child(session.id!)
          .update({'status': 0});
    } catch (e) {
      //throw e.message ?? "Some error occurred";
    }
  }

  Future<void> createNewSession(SessionModel model) async {
    try {
      final todaysDate = DateTime.now().toString().substring(0, 11);
      final id = _db.ref('sessions').child(todaysDate).push();
      model.id = id.key;
      await id.set(model.convertToJson());
    } catch (e) {
      //throw e.message ?? "Some error occurred";
    }
  }
}
