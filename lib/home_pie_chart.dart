import 'package:cannoli_app/color_scheme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cannoli_app/database.dart';
// import 'package:cannoli_app/data_models.dart';

class HomePieChart extends StatefulWidget {
  HomePieChart({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => HomePieState();
}

class HomePieState extends State<HomePieChart> {
  List<String> sources = ['Transport', 'Gas', 'Home\n Energy'];
  List<Color> sourceColors = [
    CustomMaterialColor.buttonColorBlue[200],
    CustomMaterialColor.emphasisColor[200],
    CustomMaterialColor.subColorGrass[200]
  ];
  List<double> _consumptions;
  int _totalEmission;

  int touchedIndex;

  @override
  Future<void> initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadEntries();
    });
  }

  void _loadEntries() async {
    double totalConsumption = 0;
    double transportConsumption = 0;
    double gasConsumption = 0;
    double homeConsumption = 0;
    List<double> temp = [];

    DateTime today = DateTime.now();
    var allEntries = await entryFromDate(today);
    print(allEntries);

    if (allEntries.length != 0) {
      for (int i = 0; i < allEntries.length; i++) {
        if (allEntries[i].source_id == 1) {
          homeConsumption += allEntries[i].consumption;
        } else if (allEntries[i].source_id == 2) {
          gasConsumption += allEntries[i].consumption;
        } else {
          transportConsumption += allEntries[i].consumption;
        }
        totalConsumption += allEntries[i].consumption;
      }
    }
    if (totalConsumption == 0) {
      temp.add(transportConsumption / 1);
      temp.add(gasConsumption / 1);
      temp.add(homeConsumption / 1);
    } else {
      temp.add(transportConsumption / totalConsumption);
      temp.add(gasConsumption / totalConsumption);
      temp.add(homeConsumption / totalConsumption);
    }

    print("Now:");
    print(temp);

    setState(() {
      _consumptions = temp;
      _totalEmission = (totalConsumption / 1000).round();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (_consumptions[0] == 0.0 &&
        _consumptions[1] == 0.0 &&
        _consumptions[2] == 0.0) {
      return Container(
        child: Row(
          children: <Widget>[
            // const SizedBox(
            //   height: 18,
            // ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          if (pieTouchResponse.touchInput is FlLongPressEnd ||
                              pieTouchResponse.touchInput is FlPanEnd) {
                            touchedIndex = -1;
                          } else {
                            touchedIndex = pieTouchResponse.touchedSectionIndex;
                          }
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 0,
                      sections: showingSections()),
                ),
              ),
            ),
          ],
        ),

        // Text(
        //   "Total emission: $_totalEmission KG/CO\u2082",
        //   style:
        //   TextStyle(
        //     fontSize: 28.0,
        //     fontFamily: "Arial",
        //     fontWeight: FontWeight.bold,
        //     decoration: TextDecoration.underline,
        //     decorationColor: CustomMaterialColor.buttonColorBlue,
        //     foreground: Paint()..color = CustomMaterialColor.subColorArmy,
        //   ),
        // )
      );
    } else {
      return Container(
        child: Row(
          children: <Widget>[
            // const SizedBox(
            //   height: 18,
            // ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          if (pieTouchResponse.touchInput is FlLongPressEnd ||
                              pieTouchResponse.touchInput is FlPanEnd) {
                            touchedIndex = -1;
                          } else {
                            touchedIndex = pieTouchResponse.touchedSectionIndex;
                          }
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 80,
                      sections: showingSections()),
                ),
              ),
            ),
          ],
        ),
        // Text(
        //   "Total emission: $_totalEmission KG/CO\u2082",
        //   style:
        //   TextStyle(
        //     fontSize: 28.0,
        //     fontFamily: "Arial",
        //     fontWeight: FontWeight.bold,
        //     decoration: TextDecoration.underline,
        //     decorationColor: CustomMaterialColor.buttonColorBlue,
        //     foreground: Paint()..color = CustomMaterialColor.subColorArmy,
        //   ),
        // ),
      );
    }
  }

  List<PieChartSectionData> allSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 28 : 18;
      final double radius = isTouched ? 115 : 95;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: sourceColors[0],
            value: _consumptions[0],
            title: sources[0],
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: sourceColors[1],
            value: _consumptions[1],
            title: sources[1],
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: sourceColors[2],
            value: _consumptions[2],
            title: sources[2],
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }

  List<PieChartSectionData> noSection() {
    return List.generate(1, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 34 : 30;
      final double radius = isTouched ? 115 : 115;
      switch (i) {
        case 0:
          return PieChartSectionData(
            titlePositionPercentageOffset: 0,
            color: CustomMaterialColor.buttonColorWhite,
            value: 1,
            title: "No emission",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: CustomMaterialColor.emphasisColor),
          );
        default:
          return null;
      }
    });
  }

  List<PieChartSectionData> oneSection(int index) {
    return List.generate(1, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 28 : 18;
      final double radius = isTouched ? 115 : 95;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: sourceColors[index],
            value: _consumptions[index],
            title: sources[index],
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }

  List<PieChartSectionData> twoSections(int index, int ind) {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 28 : 18;
      final double radius = isTouched ? 115 : 95;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: sourceColors[index],
            value: _consumptions[index],
            title: sources[index],
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: sourceColors[ind],
            value: _consumptions[ind],
            title: sources[ind],
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }

  List<PieChartSectionData> showingSections() {
    if (_consumptions[0] != 0.0 &&
        _consumptions[1] != 0.0 &&
        _consumptions[2] != 0.0) {
      return allSections();
    }

    if (_consumptions[0] != 0.0) {
      if (_consumptions[1] == 0.0 && _consumptions[2] == 0.0) {
        return oneSection(0);
      } else {
        if (_consumptions[1] == 0.0) {
          return twoSections(0, 2);
        } else {
          return twoSections(0, 1);
        }
      }
    }

    if (_consumptions[1] != 0.0) {
      if (_consumptions[0] == 0.0 && _consumptions[2] == 0.0) {
        return oneSection(1);
      } else {
        if (_consumptions[0] == 0.0) {
          return twoSections(1, 2);
        } else {
          return twoSections(1, 0);
        }
      }
    }

    if (_consumptions[2] != 0.0) {
      if (_consumptions[0] == 0.0 && _consumptions[1] == 0.0) {
        return oneSection(2);
      } else {
        if (_consumptions[0] == 0.0) {
          return twoSections(1, 2);
        } else {
          return twoSections(0, 2);
        }
      }
    }

    if (_consumptions[0] == 0.0 &&
        _consumptions[1] == 0.0 &&
        _consumptions[2] == 0.0) {
      return noSection();
    }
  }
}
