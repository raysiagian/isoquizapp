import 'package:flutter/material.dart';
import 'package:quiz_iso_app/models/isoQuizScoreModel.dart';
import 'package:quiz_iso_app/styles/localColors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ScoreChartWidget extends StatefulWidget {
  const ScoreChartWidget({super.key});

  @override
  State<ScoreChartWidget> createState() => _ScoreChartWidgetState();
}

class _ScoreChartWidgetState extends State<ScoreChartWidget> {
  final List<IsoQuizScoreModel> quizScores = IsoQuizScoreModel.listIsoQuizScore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(text: 'Skor Quiz'),
        legend: Legend(isVisible: false),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries>[
          LineSeries<IsoQuizScoreModel, String>(
            dataSource: quizScores,
            xValueMapper: (IsoQuizScoreModel data, _) =>
                'Kategori ${data.id_quizCategory}',
            yValueMapper: (IsoQuizScoreModel data, _) => data.score_Quiz,
            name: 'Skor Quiz',
            color: LocalColorsStyle.primaryColor,
            dataLabelSettings: DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}
