import 'package:cannoli_app/widgets/emission_chart.dart';
import 'package:cannoli_app/widgets/textboxes.dart';
import 'package:flutter/material.dart';

Widget getTransportGraphWidgets() {
  return Container(
    padding: EdgeInsets.only(top: 8.0),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Page Layout Title Text Box
            pageLayoutTextBoxWidget('Transport Emissions', 18.0),
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 8.0),
          child: mychart1Items("Transport Emissions", "Weekly", "300kg CO2"),
        ),
        // Add Widgets Here
      ],
    ),
  );
}

Widget getHomeGraphWidgets() {
  return Container(
    padding: EdgeInsets.only(top: 8.0),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Page Layout Title Text Box
            pageLayoutTextBoxWidget('Home Energy Emissions', 18.0),
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 8.0),
          child:
              mychart1Items("Home energy Consumption", "Weekly", "300kg CO2"),
        ),
        // Add Widgets Here
      ],
    ),
  );
}

Widget getAllGraphWidgets() {
  return Container(
    padding: EdgeInsets.only(top: 8.0),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Page Layout Title Text Box
            pageLayoutTextBoxWidget('All Emissions: Overview', 18.0),
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 8.0),
          child: myCircularItems("Today's Total Consumption", "250kg CO2"),
        ),
        Container(
          padding: EdgeInsets.only(top: 8.0),
          child:
              mychart1Items("Home energy Consumption", "Weekly", "300kg CO2"),
        ),
        Container(
          padding: EdgeInsets.only(top: 8.0),
          child: comparisonCard("Comparison with ideal emission", "Weekly"),
        ),
        // Add Widgets Here
      ],
    ),
  );
}
