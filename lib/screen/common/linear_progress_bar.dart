import 'package:flutter/material.dart';

class LinearProgressBar extends StatefulWidget {
  final double totalQuestions;
  final double currentPostion;
  final double width;
  final Color primaryColor;
  final Color backgroundColor;

  const LinearProgressBar({
    Key? key,
    required this.totalQuestions,
    this.width = 2.0,
    this.currentPostion = 0,
    required this.primaryColor,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  _LinearProgressBarState createState() => _LinearProgressBarState();
}

class _LinearProgressBarState extends State<LinearProgressBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: widget.width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxW = constraints.maxWidth;
          return Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: widget.backgroundColor,
                ),
                width: maxW,
                height: widget.width - 16,
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                height: widget.width - 16,
                width: (widget.currentPostion == 0)
                    ? widget.width - 16
                    : (widget.currentPostion / widget.totalQuestions) * maxW,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: widget.primaryColor,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
