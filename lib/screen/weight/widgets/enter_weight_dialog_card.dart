import 'package:flutter/material.dart';
import 'package:form_app/models/weight_model.dart';
import 'package:form_app/provider/weight_provider.dart';

class EnterWeightDialogCard extends StatefulWidget {
  final WeightProvider provider;
  final bool isEdit;
  final WeightModel? weightModel;
  const EnterWeightDialogCard(
      {Key? key, required this.provider, this.isEdit = false, this.weightModel})
      : super(key: key);

  @override
  State<EnterWeightDialogCard> createState() => _EnterWeightDialogCardState();
}

class _EnterWeightDialogCardState extends State<EnterWeightDialogCard> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _controller,
                autofocus: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Weight",
                    suffixText: "KG",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  if (widget.isEdit && widget.weightModel != null) {
                    widget.provider.updateWeight(
                        id: widget.weightModel!.id, weight: _controller.text);
                  } else {
                    widget.provider.addWeight(weight: _controller.text);
                  }
                  _controller.clear();
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(2),
                      bottomRight: Radius.circular(2),
                    ),
                    side: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
