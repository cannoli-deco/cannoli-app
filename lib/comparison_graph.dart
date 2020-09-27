import 'package:cannoli_app/color_scheme.dart';
import 'package:cannoli_app/database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

final Color subTextColor = Colors.grey[600];

class ComparisonGraph extends StatefulWidget {
  ComparisonGraph({Key key}) : super(key: key);

  @override
  _ComparisonGraphState createState() => _ComparisonGraphState();
}

class _ComparisonGraphState extends State<ComparisonGraph> {
  List<FlSpot> _entries;

  @override
  Future<void> initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadEntries();
    });
  }

  void _loadEntries() async {
    DateTime today = DateTime.now();
    var firstDayOfTheweek = today.subtract(new Duration(days: today.weekday));
    List<FlSpot> entries = [];

    for (var i = 0; i < 7; i++) {
      var currentEntries =
          await entryFromDate(firstDayOfTheweek.add(Duration(days: i)));
      print(currentEntries);

      // Add sum of the days as FlSpots.
      entries.add(FlSpot(
          i.toDouble(),
          currentEntries
              .fold(0, (i, entry) => i + entry.consumption)
              .toDouble()));
    }
    setState(() {
      _entries = entries;
    });
  }

  final idealEmmission = [
    FlSpot(0, 5571),
    FlSpot(6, 5571),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              dotData: FlDotData(
                show: false,
              ),
              colors: [
                Colors.greenAccent,
                Colors.orangeAccent,
              ],
              spots: idealEmmission,
              isCurved: true,
              isStrokeCapRound: true,
              barWidth: 2,
              belowBarData: BarAreaData(
                show: true,
                colors: [Colors.green.withOpacity(0.1)],
              ),
            ),
            LineChartBarData(
              colors: [
                CustomMaterialColor.bannerColor[50],
                CustomMaterialColor.bannerColor,
              ],
              spots: _entries,
              isCurved: false,
              isStrokeCapRound: true,
              barWidth: 3,
              belowBarData: BarAreaData(
                show: false,
              ),
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                        radius: 3, color: CustomMaterialColor.emphasisColor),
              ),
            ),
          ],
          lineTouchData: LineTouchData(enabled: false),
          axisTitleData: FlAxisTitleData(
            leftTitle: AxisTitle(
              showTitle: true,
              titleText: "Emission in kg",
              textStyle: TextStyle(
                color: subTextColor,
              ),
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: SideTitles(
              getTitles: (value) {
                return (value / 1000).toString();
              },
              showTitles: true,
              interval: 2000,
              margin: 16,
              textStyle: TextStyle(
                color: subTextColor,
                fontSize: 12.0,
              ),
            ),
            bottomTitles: SideTitles(
              showTitles: true,
              getTitles: (double value) {
                switch (value.toInt()) {
                  case 0:
                    return 'Sun';
                  case 1:
                    return 'Mon';
                  case 2:
                    return 'Tue';
                  case 3:
                    return 'Wed';
                  case 4:
                    return 'Thu';
                  case 5:
                    return 'Fri';
                  case 6:
                    return 'Sat';
                  default:
                    return '';
                }
              },
              textStyle: TextStyle(
                color: subTextColor,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
