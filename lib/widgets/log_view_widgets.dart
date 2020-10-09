import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getTimeStamp(DateTime time) {
  print(time);
  print(DateTime.now());
  DateTime justNow = DateTime.now().subtract(Duration(minutes: 1));
  if (!time.difference(justNow).isNegative) {
    return 'Just now';
  }
  DateTime today = DateTime.now().subtract(Duration(days: 1));
  if (!time.difference(today).isNegative) {
    return 'Today, ' + DateFormat.jm().format(time);
  }
  return 'More than a day ago';
}

Widget getLogDivider() {
  return Container(
    height: 50.0,
    width: 10.0,
  );
}

Widget getLogTextBody(String source, int consumption, DateTime time) {
  return Container(
    height: 50.0,
    width: 300.0,
    child: Padding(
      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            source,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
          Container(
            height: 3.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                consumption.toString() + ' CO\u2082 footprint',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[500],
                ),
              ),
              Text(
                getTimeStamp(time),
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget getLogWidget(String source, int consumption, DateTime time) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.grey[300],
          width: 0.5,
        ),
      ),
    ),
    padding: EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.home,
            color: Colors.grey[800],
          ),
        ),
        getLogDivider(),
        getLogTextBody(source, consumption, time),
        getLogDivider(),
        Icon(
          Icons.more_vert,
          color: Colors.grey[800],
        ),
      ],
    ),
  );
}
