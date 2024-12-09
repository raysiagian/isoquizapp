import 'package:flutter/material.dart';
import 'package:quiz_iso_app/styles/localColors.dart';

class TotalScoreandRanksWidget extends StatefulWidget {
  const TotalScoreandRanksWidget({super.key});

  @override
  State<TotalScoreandRanksWidget> createState() => _TotalScoreandRanksWidgetState();
}

class _TotalScoreandRanksWidgetState extends State<TotalScoreandRanksWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: LocalColorsStyle.primaryColor.withOpacity(0.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Image
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('100'),
                    Text('Score'),
                  ],
                ),
              ],
            ),
          ),
        ),
        Spacer(),
        Container(
          width: 150,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: LocalColorsStyle.primaryColor.withOpacity(0.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Image
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '10',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text('Rank'),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}