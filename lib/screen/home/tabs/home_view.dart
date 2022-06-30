import 'package:flutter/material.dart';
import 'package:form_app/controllers/home_controller.dart';
import 'package:form_app/screen/home/widgets/cards/session_card.dart';
import 'package:form_app/screen/home/widgets/greeting_textview.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';

import '../../../enums/session_status.dart';
import '../widgets/cards/progress_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  static HomeController controller = Get.find<HomeController>(tag: 'home');

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        //init: HomeController()..init(),
        global: true,
        init: controller,
        builder: (controller) {
          return controller.isLoadingData.value
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const GreetingText(name: 'Jane'),
                    const SizedBox(height: 10),
                    ProgressCard(
                      inProgress: controller.inProgress.value,
                      totalSessions: controller.totalSessions.value,
                    ),
                    Flexible(
                      child: Timeline.tileBuilder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        builder: TimelineTileBuilder.connected(
                          connectionDirection: ConnectionDirection.after,
                          indicatorBuilder: (context, index) {
                            return DotIndicator(
                              border: controller.sessions[index].status ==
                                      SessionStatus.notStarted
                                  ? Border.all(
                                      color: Colors.grey,
                                      width: 2,
                                    )
                                  : Border.all(
                                      width: 2,
                                      color: const Color(0xff193fcc),
                                    ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              ),
                              color: controller.sessions[index].status !=
                                      SessionStatus.notStarted
                                  ? const Color(0xff193fcc)
                                  : Colors.white,
                            );
                          },
                          connectorBuilder: (_, index, connectorType) {
                            Color color = Colors.white;
                            color = controller.sessions[index].status ==
                                    SessionStatus.completed
                                ? const Color(0xff193fcc)
                                : Colors.grey;
                            return DashedLineConnector(
                              indent: connectorType == ConnectorType.start
                                  ? 0
                                  : 2.0,
                              dash: 12,
                              gap: 6,
                              endIndent:
                                  connectorType == ConnectorType.end ? 0 : 2.0,
                              color: color,
                            );
                          },
                          contentsBuilder: (context, i) => SessionCard(
                            session: controller.sessions[i],
                            colorMode: i % 3,
                          ),
                          itemCount: controller.sessions.length,
                          nodePositionBuilder: (ctx, i) => 0,
                        ),
                      ),
                    ),
                  ],
                );
        });
  }
}
