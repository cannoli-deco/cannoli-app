import 'package:cannoli_app/color_scheme.dart';
import 'package:cannoli_app/database.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class Homepage extends StatefulWidget{
  Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}


class _HomepageState extends State<Homepage>{
  List<charts.Series<Entry, String>> _seriesPieData;

  _generateData() async{

    List<Entry> entrysData = await entryFromDate(DateTime.now());

    final blue = charts.MaterialPalette.blue.makeShades(2);
    final red = charts.MaterialPalette.red.makeShades(2);
    final green = charts.MaterialPalette.green.makeShades(2);

    var pieData=[
      new Task('Car', 75.0, Color(0xFF04645A)),
      new Task('Electricity', 100.0, Color(0xFF9DD4D1)),
      new Task('Gas', 75.0, Color(0xFF93AB4B)),
    ];

    _seriesPieData.add(
      charts.Series(
        data:entrysData,
        domainFn: (Entry entry,_) => entry.source_id.toString(),
        measureFn: (Entry entry,_) => entry.consumption,
        colorFn: (Entry entry,_) => charts.MaterialPalette.blue.shadeDefault
          // ignore: missing_return
          // switch(entry.source_id){
          //   case 1:
          //     {
          //       return blue[1];
          //     }
          //   case 2:
          //     {
          //       return red[1];
          //     }
          //   case 3:
          //     {
          //       return green[1];
          //     }

      )
    );
  }

  @override
  void initState(){
    super.initState();
    _seriesPieData = List<charts.Series<Entry, String>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30.0),
            child:Center(
              child: Row(
                children: <Widget>[
                  Expanded(
                    //alignment: Alignment.centerLeft,
                    child: MaterialButton(
                        child: Icon(FontAwesomeIcons.angleLeft, color: CustomMaterialColor.buttonColorBlue, size: 30.0),
                        onPressed: (){}
                    ),
                  ),

                  Center(

                    child: Text(
                    "Today",
                      style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold,
                      color: CustomMaterialColor.emphasisColor),
                    ),
                  ),

                  Expanded(
                    //alignment: Alignment.centerRight,
                    child: MaterialButton(
                        child: Icon(FontAwesomeIcons.angleRight, color: CustomMaterialColor.buttonColorBlue, size: 30.0),
                        onPressed: (){}
                    ),
                  ),

                ],
              ),
            )
          ),


          Container(
            height: 350,
            width: 350,
            child: Center(
                child:
                charts.PieChart(
                  _seriesPieData,
                  animate: true,
                  animationDuration: Duration(milliseconds: 500),
                  defaultRenderer: new charts.ArcRendererConfig(
                    arcRendererDecorators: [charts.ArcLabelDecorator()]
                  //     arcWidth:100,
                  //     arcRendererDecorators: [
                  //       new charts.ArcLabelDecorator(
                  //           labelPosition: charts.ArcLabelPosition.inside
                  //       )
                  //     ]
                  ),
                )
            ),
          ),

          Container(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
              "1000 kg of CO\u2082",
              style: TextStyle(fontSize: 26.0),
            ),
          )
        ],
      ),
    );
  }
}


/// Test data container
class Task{
  String task;
  double taskvalue;
  Color colorval;
    Task(this.task, this.taskvalue, this.colorval);
}