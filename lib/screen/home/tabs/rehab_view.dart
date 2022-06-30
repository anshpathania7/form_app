import 'package:flutter/material.dart';
import 'package:form_app/screen/home/widgets/cards/rehab_card.dart';
import 'package:form_app/screen/home/widgets/cards/rehab_history_card.dart';
import 'package:form_app/screen/home/widgets/cards/rehab_session_card.dart';
import 'package:get/get.dart';

import '../../../controllers/home_controller.dart';

class RehabView extends StatelessWidget {
  const RehabView({Key? key}) : super(key: key);
  static HomeController controller = Get.find<HomeController>(tag: 'home');

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        global: true,
        init: controller,
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                "Rehab Programme",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              const RehabProgrammeCard(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "History",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    Icons.sort,
                    size: 32,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 12.0, bottom: 6),
                child: RehabHistoryCard(),
              ),
              Flexible(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.sessions.length,
                  shrinkWrap: true,
                  itemBuilder: (context, i) =>
                      RehabSessionCard(session: controller.sessions[i]),
                ),
              )
            ],
          );
        });
  }
}
