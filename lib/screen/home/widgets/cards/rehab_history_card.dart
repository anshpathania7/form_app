import 'package:flutter/material.dart';

class RehabHistoryCard extends StatelessWidget {
  const RehabHistoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Text("Total Sessions"),
                Row(
                  children: const [
                    Icon(Icons.sports_gymnastics),
                    Text(
                      "16",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Container(
              height: 22,
              width: 2,
              color: Colors.grey,
            ),
            Column(
              children: [
                const Text("Total Time"),
                Row(
                  children: const [
                    Icon(Icons.timelapse),
                    Text(
                      "16",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
