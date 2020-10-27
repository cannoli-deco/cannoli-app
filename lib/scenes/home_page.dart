import 'package:cannoli_app/color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cannoli_app/database.dart';
import 'package:cannoli_app/home_pie_chart.dart';

/// {@category Scene}
class Homepage extends StatefulWidget {
  Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>{
  int _totalEmission = 0;

  @override
  Future<void> initState() {

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadEntries();
    });
  }

  /// Load entries from database
  void _loadEntries() async {
    double totalConsumption = 0;

    DateTime today = DateTime.now();
    var allEntries = await entryFromDate(today);
    print(allEntries);

    if(allEntries.length != 0){
      for(int i=0; i < allEntries.length; i++){
        totalConsumption += allEntries[i].consumption;
      }
    }

    setState(() {
      _totalEmission = (totalConsumption/1000).round();
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
                children: <Widget>[
                  Expanded(
                    //alignment: Alignment.centerLeft,
                    child: MaterialButton(
                        child: Icon(FontAwesomeIcons.angleLeft, color: CustomMaterialColor.subColorBlack[100], size: 20.0),
                        onPressed: (){}
                    ),
                  ),

                  Center(
                    child: Text(
                    "Today",
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,
                      color: CustomMaterialColor.emphasisColor),
                    ),
                  ),

                  Expanded(
                    //alignment: Alignment.centerRight,
                    child: MaterialButton(
                        child: Icon(FontAwesomeIcons.angleRight, color: CustomMaterialColor.subColorBlack[100], size: 20.0),
                        onPressed: (){
                        }
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
                    padding: EdgeInsets.only(top:4.0),
                    child: Text(
                      "Total emission: $_totalEmission KG/CO\u2082",
                      style:
                      TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: CustomMaterialColor.bannerColor,
                        foreground: Paint()..color = CustomMaterialColor.bannerColor,
                      ),
                    ),
                  ),
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}

