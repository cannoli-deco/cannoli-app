import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../database.dart';

class Options extends StatefulWidget {
  @override
  _OptionsState createState() => _OptionsState();
}

int _id;

class _OptionsState extends State<Options> {
  @override
  void initState() {
    super.initState();
  }

  void onSelection(int value) {
    if (value == 1) {
      // editEntry();
    } else {
      deleteEntry(_id);
      print(_id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.0,
      alignment: Alignment.center,
      child: PopupMenuButton(
        itemBuilder: (context) {
          var list = List<PopupMenuEntry<Object>>();
          list.add(
            PopupMenuItem(
              child: Container(
                width: 70.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.create,
                      size: 18,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Edit',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              value: 1,
            ),
          );
          list.add(
            PopupMenuItem(
              child: Container(
                width: 70.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.delete,
                      size: 18,
                      color: Colors.red[500],
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Delete',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red[500],
                      ),
                    ),
                  ],
                ),
              ),
              value: 2,
            ),
          );
          return list;
        },
        onSelected: (value) {},
        icon: Container(
          width: 4.0,
          child: Icon(
            Icons.more_vert,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}

Widget getLogWidget(int id, String source, int consumption, DateTime time) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.grey[300],
          width: 0.5,
        ),
      ),
    ),
    padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
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
        Options(),
        /*
        Icon(
          Icons.more_vert,
          color: Colors.grey[800],
        ),
        */
      ],
    ),
  );
}

String getTimeStamp(DateTime time) {
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
