import 'package:flutter/material.dart';

class LogWidgets extends StatefulWidget {
  @override
  _LogWidgets createState() => _LogWidgets();
}

class _LogWidgets extends State<LogWidgets> {
  // TODO: implement live db data
  // TODO: Add log widgets here
  List<Widget> widgetList = [
    buildLogWidget(['Car', '436', getTimeFormat("2020-09-25 10:18:04Z")]),
    buildLogWidget(
        ['Electricity Bill', '5698', getTimeFormat("2020-09-24 21:04:46Z")]),
    buildLogWidget(
        ['Water Bill', '2354', getTimeFormat("2020-09-24 18:46:56Z")]),
    buildLogWidget(['Gas Bill', '1043', getTimeFormat("2020-09-24 09:19:26Z")]),
    buildLogWidget(['Car', '203', getTimeFormat("2020-09-23 17:41:02Z")]),
    buildLogWidget(['Car', '274', getTimeFormat("2020-09-23 08:37:51Z")]),
    buildLogWidget(
        ['Miscellaneous', '140', getTimeFormat("2020-09-22 10:18:04Z")])
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widgetList.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return ListTile(
          leading: Icon(Icons.home),
          title: Text('Log Widget: ' + index.toString()),
          subtitle: Text('CO2\nDate/Time'),
          trailing: Icon(Icons.more_vert),
        );
      },
    );
  }
}

String getTimeFormat(String time) {
  var timeParse = DateTime.parse(time);
  var rString =
      "${timeParse.weekday}, ${timeParse.hour}:${timeParse.minute} hrs";
  return rString;
}

bool getType(String type) {
  if (type == 'Car') {
    return true;
  }
  return false;
}

Widget buildLogWidget(List<String> list) {
  return ListTile(
    leading: getType(list[0]) ? Icon(Icons.home) : Icon(Icons.drive_eta),
    title: Text(list[0]),
    subtitle: Text(list[1] + ' CO2\n' + list[2]),
    trailing: Icon(Icons.more_vert),
  );
}
