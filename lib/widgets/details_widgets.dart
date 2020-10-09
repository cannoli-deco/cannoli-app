import 'package:cannoli_app/widgets/emission_charts.dart';
import 'package:cannoli_app/widgets/textboxes.dart';
import 'package:flutter/material.dart';

// [START]Details Page: Graph View Widgets
// -------------------------------------------------------------------------------------------
// Widget: Details Page, Generates List of Transport Emission widgets needed for graph view
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

// Widget: Details Page, Generates List of Home Energy Emission widgets needed for graph view
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

// Widget: Details Page, Generates List of Important General Emission widgets needed for graph view
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
// -------------------------------------------------------------------------------------------
// [END]Details Page: Graph View Widgets

// [START]Details Page: Og View Widgets
// -------------------------------------------------------------------------------------------
// Widget: Details Page, Generates List of Transport Emission widgets needed for Log view
Widget getTransportLogWidgets() {
  return Container(
    padding: EdgeInsets.only(top: 8.0),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Page Layout Title Text Box
            pageLayoutTextBoxWidget('Transport Emissions Log', 18.0),
          ],
        ),
        // Add Widgets Here
      ],
    ),
  );
}

// Widget: Details Page, Generates List of Home Energy Emission widgets needed for Log view
Widget getHomeLogWidgets() {
  return Container(
    padding: EdgeInsets.only(top: 8.0),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Page Layout Title Text Box
            pageLayoutTextBoxWidget('Home Energy Emissions Log', 18.0),
          ],
        ),
        // Add Widgets Here
      ],
    ),
  );
}

// Widget: Details Page, Generates List of Important General Emission widgets needed for Log view
Widget getAllLogWidgets() {
  return Container(
    padding: EdgeInsets.only(top: 8.0),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Page Layout Title Text Box
            pageLayoutTextBoxWidget('All Emissions Log', 18.0),
          ],
        ),
        // Add Widgets Here
      ],
    ),
  );
}
// -------------------------------------------------------------------------------------------
// [END]Details Page: Log View Widgets