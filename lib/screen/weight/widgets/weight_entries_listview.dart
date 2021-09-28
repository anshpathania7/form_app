import 'package:flutter/material.dart';
import 'package:form_app/models/weight_model.dart';
import 'package:form_app/provider/weight_provider.dart';
import 'package:form_app/screen/weight/widgets/update_delete_dialog.dart';

class WeightEntriesListview extends StatelessWidget {
  final List<WeightModel> weights;
  final WeightProvider provider;
  const WeightEntriesListview(
      {Key? key, required this.weights, required this.provider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: weights.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, i) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: InkWell(
          onTap: () async {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => UpdateDeleteDialog(
                provider: provider,
                weightModel: weights[i],
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${i + 1}. ${weights[i].weight} Kg",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        weights[i].formatDate,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        weights[i].formatTime,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
