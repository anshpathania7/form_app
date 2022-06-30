import 'package:form_app/repository/sessions_repository.dart';
import 'package:get/get.dart';

import '../enums/session_status.dart';
import '../models/session_model.dart';

class HomeController extends GetxController {
  late RxList<SessionModel> sessions;
  late Stream<SessionModel> _newSessions;
  late Stream<SessionModel> _updateSessions;

  RxBool isLoadingData = true.obs;

  late RxInt inProgress;
  late RxInt totalSessions;

  void listenToSessionChanges() {
    _newSessions = SessionRepository().listenForNewSessions();
    _updateSessions = SessionRepository().listenForUpdateSessions();
    _newSessions.listen(
      (event) {
        if (event.id != sessions.last.id) {
          sessions.add(event);
          update();
        }
      },
    );
    _updateSessions.listen(
      (event) {
        final i = sessions.indexWhere((element) => element.id == event.id);
        sessions[i] = event;
        update();
      },
    );
  }

  Future<void> getData() async {
    isLoadingData.value = true;

    sessions = (await SessionRepository().getAllSessions()).obs;
    inProgress =
        sessions.where((s) => s.status != SessionStatus.notStarted).length.obs;
    totalSessions = sessions.length.obs;
    isLoadingData.value = false;
    update();
  }

  void insertFakeData() async {
    final i = (sessions.length + 1).toString();
    final model = SessionModel(
      id: i,
      title: 'Session ' + i,
      status: SessionStatus.notStarted,
      performedAt: DateTime.now(),
    );
    final lastModel = sessions.last;

    await SessionRepository().createNewSession(model);
    await SessionRepository().markAsCompleted(lastModel);
    totalSessions += 1;
    update();
  }

  Future<void> init() async {
    await getData();
    listenToSessionChanges();
  }
}
