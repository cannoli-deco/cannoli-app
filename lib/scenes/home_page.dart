import 'package:cannoli_app/color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:cannoli_app/home_pie_chart.dart';



class Homepage extends StatefulWidget{
  Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}


class _HomepageState extends State<Homepage>{
  String _emissionGoal = 'Set emission goal';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30.0),
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
                padding: EdgeInsets.only(top: 4.0),
                child: HomePieChart(),
            ),
            ),

          Container(
            padding: EdgeInsets.only(top: 4.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _emissionGoal,
                    style:
                    TextStyle(
                      fontSize: 26.0,
                      fontFamily: "Arial",
                      fontWeight: FontWeight.bold,
                      //decoration: TextDecoration.underline,
                      decorationColor: CustomMaterialColor.buttonColorBlue,
                      foreground: Paint()..color = CustomMaterialColor.buttonColorBlue,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.alarm_on),
                    color: CustomMaterialColor.subColorRed,
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return new AlertDialog(
                              content: Container(
                                height: 100,
                                width: 250,
                                child: Column(
                                  children: <Widget>[
                                    TextField(
                                      decoration: InputDecoration(
                                          hintText: "Please enter your emission goal"
                                      ),
                                      onChanged: (String value){
                                        setState(() {
                                            _emissionGoal = "$value KG CO\u2082";
                                        });
                                      },
                                    ),

                                    RaisedButton(
                                      color: CustomMaterialColor.subColorRed,
                                      child: Text('Save',
                                          style: TextStyle(
                                              color: CustomMaterialColor.buttonColorWhite)),
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                      );
                    },
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