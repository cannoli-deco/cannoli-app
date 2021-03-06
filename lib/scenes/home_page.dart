import 'package:cannoli_app/color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cannoli_app/database.dart';
// import 'package:cannoli_app/data_models.dart';
import 'package:cannoli_app/home_pie_chart.dart';

class Homepage extends StatefulWidget {
  Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String _emissionGoal = '1000 KG/CO\u2082';
  int _totalEmission = 0;

  @override
  Future<void> initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadEntries();
    });
  }

  void _loadEntries() async {
    double totalConsumption = 0;

    DateTime today = DateTime.now();
    var allEntries = await entryFromDate(today);

    if (allEntries.length != 0) {
      for (int i = 0; i < allEntries.length; i++) {
        totalConsumption += allEntries[i].consumption;
      }
    }

    setState(() {
      _totalEmission = (totalConsumption / 1000).round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    "Today",
                    style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: CustomMaterialColor.bannerColor),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            //flex: 10,
            child: Container(
              //padding: EdgeInsets.only(top: 4.0),
              child: HomePieChart(),
            ),
          ),
          Container(
              //padding: EdgeInsets.only(top: 4.0),
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text(
                    "Total emission: $_totalEmission KG/CO\u2082",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "Arial",
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: CustomMaterialColor.buttonColorBlue,
                      foreground: Paint()
                        ..color = CustomMaterialColor.bannerColor,
                    ),
                  ),
                ),

                // Max emission text disabled
//                  Padding(
//                    padding: EdgeInsets.only(top:24.0),
//                    child: Text(
//                      _emissionGoal,
//                      style:
//                      TextStyle(
//                        fontSize: 30.0,
//                        fontFamily: "Arial",
//                        fontWeight: FontWeight.bold,
//                        //decoration: TextDecoration.underline,
//                        decorationColor: CustomMaterialColor.buttonColorBlue,
//                        foreground: Paint()..color = CustomMaterialColor.subColorBlack,
//                      ),
//                    ),
//                  )

                /// Add emission goal button is disabled for now
                // IconButton(
                //   icon: Icon(Icons.alarm_on),
                //   color: CustomMaterialColor.subColorRed,
                //   onPressed: (){
                //     showDialog(
                //         context: context,
                //         builder: (BuildContext context){
                //           return new AlertDialog(
                //             content: Container(
                //               height: 100,
                //               width: 250,
                //               child: Column(
                //                 children: <Widget>[
                //                   TextField(
                //                     decoration: InputDecoration(
                //                         hintText: "Please enter your emission goal"
                //                     ),
                //                     onChanged: (String value){
                //                       setState(() {
                //                           _emissionGoal = "$value KG CO\u2082";
                //                       });
                //                     },
                //                   ),
                //
                //                   RaisedButton(
                //                     color: CustomMaterialColor.subColorRed,
                //                     child: Text('Save',
                //                         style: TextStyle(
                //                             color: CustomMaterialColor.emphasisColor)),
                //                     onPressed: (){
                //                       Navigator.pop(context);
                //                     },
                //                   )
                //                 ],
                //               ),
                //             ),
                //           );
                //         }
                //     );
                //   },
                // ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
