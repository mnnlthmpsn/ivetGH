import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:vetgh/config.dart';

class BarGraph extends StatelessWidget {
  final List<ResultsSeries> data;

  const BarGraph({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ResultsSeries, String>> series = [
      charts.Series(
          colorFn: (ResultsSeries series, _) => charts.ColorUtil.fromDartColor(KColors.kPrimaryColor),
          id: 'nominees',
          data: data,
          domainFn: (ResultsSeries series, _) => series.name.substring(0, 3) + '...',
          measureFn: (ResultsSeries series, _) => series.count),
    ];

    return charts.BarChart(series, animate: true, vertical: true);
  }
}

class ResultsSeries {
  final String name;
  final double count;
  ResultsSeries({required this.name, required this.count});
}
