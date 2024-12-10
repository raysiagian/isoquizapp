import 'package:flutter/material.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
import 'package:quiz_iso_app/styles/localTextStyle.dart';

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
            border: Border.all(color: LocalColorsStyle.primaryColor),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Image
                Container(
                  height: 50,
                  width: 50,
                  child:  Image.asset(
                    'assets/images/scores.png',
                    height: 250,
                  ),
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '100',
                      style: LocalTextStyle.textTheme.titleLarge!.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Score',
                      style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
                        color: Colors.black,
                      ),
                    ),
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
            border: Border.all(color: LocalColorsStyle.primaryColor),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Image
                 Container(
                  height: 50,
                  width: 50,
                  child:  Image.asset(
                    'assets/images/ranks.png',
                    height: 250,
                  ),
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '10',
                      style: LocalTextStyle.textTheme.titleLarge!.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Rank',
                       style: LocalTextStyle.textTheme.bodyMedium!.copyWith(
                        color: Colors.black,
                      ),
                    ),
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