import 'package:cannoli_app/database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(right: 22.0, bottom: 20),
          child: SizedBox(
            width: 300,
            height: 200,
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
                      Colors.lightBlueAccent,
                      Colors.blue,
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
                              radius: 6, color: Colors.blue.withOpacity(0.5)),
                    ),
                  ),
                ],
                axisTitleData: FlAxisTitleData(
                  leftTitle: AxisTitle(
                    showTitle: true,
                    titleText: "Emission in kg",
                  )
                ),
                titlesData: FlTitlesData(
                  leftTitles: SideTitles(
                    getTitles: (value) {
                      return (value / 1000).toString();
                    },
                    showTitles: true,
                    interval: 2000,
                    textStyle: const TextStyle(
                        color: Colors.green,
                        fontSize: 18),
                    margin: 16,
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
                      }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
