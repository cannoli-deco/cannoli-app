import 'package:cannoli_app/color_scheme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cannoli_app/database.dart';

class HomePieChart extends StatefulWidget {
  HomePieChart({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => HomePieState();
}

class HomePieState extends State<HomePieChart>{
  List<double> _consumptions;
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

    if(allEntries.length != 0){
      for(int i=0; i < allEntries.length; i++){
        if(allEntries[i].source_id == 1){
          homeConsumption += allEntries[i].consumption;
        }else if(allEntries[i].source_id == 2){
          gasConsumption += allEntries[i].consumption;
        }else{
          transportConsumption += allEntries[i].consumption;
        }
        totalConsumption += allEntries[i].consumption;
      }
    }
    if(totalConsumption == 0){
      temp.add(transportConsumption/1);
      temp.add(gasConsumption/1);
      temp.add(homeConsumption/1);
    }
    else{
      temp.add(transportConsumption/totalConsumption);
      temp.add(gasConsumption/totalConsumption);
      temp.add(homeConsumption/totalConsumption);
    }

    print("Now:");
    print(temp);

    setState(() {
      _consumptions = temp;
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                    pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
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
    );
  }

  List<PieChartSectionData> showingSections(){

    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 28 : 18;
      final double radius = isTouched ? 115 : 95;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: _consumptions[0],
            title: 'Transport',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 2,
            title: 'Gas',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 2,
            title: 'Home\n Energy',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }

}