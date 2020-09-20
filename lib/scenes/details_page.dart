import 'package:cannoli_app/widgets/details_widgets.dart';
import 'package:flutter/material.dart';
import 'package:cannoli_app/widgets/textboxes.dart';

import 'package:cannoli_app/color_scheme.dart';

enum WidgetList {
  allGraph,
  allLog,
  transportGraph,
  transportLog,
  homeGraph,
  homeLog,
}

class DetailsPage extends StatefulWidget {
  DetailsPage({Key key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  // List to toggle category buttons. [All, Transport, Home]
  List<bool> isCategorySelected = [true, false, false];
  // List to toggle view buttons. [Graph, Log]
  List<bool> isViewSelected = [true, false];
  WidgetList widgetSelection = WidgetList.allGraph;

  // Widget for details page layout
  Widget detailsPageLayout() {
    return Material(
      color: Color(0xffE5E5E5),
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Row for Page Title Text Box
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Page Layout Title Text Box
                pageLayoutTextBoxWidget('Emission Categories', 20.0),
              ],
            ),
            // Row for Toggle Button controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Emission Category Selection Button Group
                // All emissions
                FlatButton(
                  child: Text(
                    'All',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: isCategorySelected[0]
                          ? Colors.white
                          : Colors.grey[500],
                    ),
                  ),
                  color: isCategorySelected[0]
                      ? CustomMaterialColor.bannerColor
                      : Color(0xffE5E5E5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(
                      color: isCategorySelected[0]
                          ? CustomMaterialColor.bannerColor
                          : Colors.grey[500],
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      int flag = 0;
                      for (int index = 0;
                          index < isCategorySelected.length;
                          index++) {
                        if (index == 0) {
                          isCategorySelected[index] = true;
                          flag = index;
                        } else {
                          isCategorySelected[index] = false;
                        }
                      }
                      if (isViewSelected[0] == true) {
                        switch (flag) {
                          case 0:
                            widgetSelection = WidgetList.allGraph;
                            break;
                          case 1:
                            widgetSelection = WidgetList.transportGraph;
                            break;
                          case 2:
                            widgetSelection = WidgetList.homeGraph;
                            break;
                        }
                      } else {
                        switch (flag) {
                          case 0:
                            widgetSelection = WidgetList.allLog;
                            break;
                          case 1:
                            widgetSelection = WidgetList.transportLog;
                            break;
                          case 2:
                            widgetSelection = WidgetList.homeLog;
                            break;
                        }
                      }
                    });
                  },
                ),
                // Transport emissions
                FlatButton(
                  child: Text(
                    'Transport',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: isCategorySelected[1]
                          ? Colors.white
                          : Colors.grey[500],
                    ),
                  ),
                  color: isCategorySelected[1]
                      ? CustomMaterialColor.bannerColor
                      : Color(0xffE5E5E5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(
                      color: isCategorySelected[1]
                          ? CustomMaterialColor.bannerColor
                          : Colors.grey[500],
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      int flag = 0;
                      for (int index = 0;
                          index < isCategorySelected.length;
                          index++) {
                        if (index == 1) {
                          isCategorySelected[index] = true;
                          flag = index;
                        } else {
                          isCategorySelected[index] = false;
                        }
                      }
                      if (isViewSelected[0] == true) {
                        switch (flag) {
                          case 0:
                            widgetSelection = WidgetList.allGraph;
                            break;
                          case 1:
                            widgetSelection = WidgetList.transportGraph;
                            break;
                          case 2:
                            widgetSelection = WidgetList.homeGraph;
                            break;
                        }
                      } else {
                        switch (flag) {
                          case 0:
                            widgetSelection = WidgetList.allLog;
                            break;
                          case 1:
                            widgetSelection = WidgetList.transportLog;
                            break;
                          case 2:
                            widgetSelection = WidgetList.homeLog;
                            break;
                        }
                      }
                    });
                  },
                ),
                // Home emissions
                FlatButton(
                  child: Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: isCategorySelected[2]
                          ? Colors.white
                          : Colors.grey[500],
                    ),
                  ),
                  color: isCategorySelected[2]
                      ? CustomMaterialColor.bannerColor
                      : Color(0xffE5E5E5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(
                      color: isCategorySelected[2]
                          ? CustomMaterialColor.bannerColor
                          : Colors.grey[500],
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      int flag = 0;
                      for (int index = 0;
                          index < isCategorySelected.length;
                          index++) {
                        if (index == 2) {
                          isCategorySelected[index] = true;
                          flag = index;
                        } else {
                          isCategorySelected[index] = false;
                        }
                      }
                      if (isViewSelected[0] == true) {
                        switch (flag) {
                          case 0:
                            widgetSelection = WidgetList.allGraph;
                            break;
                          case 1:
                            widgetSelection = WidgetList.transportGraph;
                            break;
                          case 2:
                            widgetSelection = WidgetList.homeGraph;
                            break;
                        }
                      } else {
                        switch (flag) {
                          case 0:
                            widgetSelection = WidgetList.allLog;
                            break;
                          case 1:
                            widgetSelection = WidgetList.transportLog;
                            break;
                          case 2:
                            widgetSelection = WidgetList.homeLog;
                            break;
                        }
                      }
                    });
                  },
                ),
                // Page View Button Group
                // Graph View Button
                Ink(
                  decoration: ShapeDecoration(
                    color: isViewSelected[0]
                        ? CustomMaterialColor.bannerColor
                        : Color(0xffE5E5E5),
                    shape: CircleBorder(
                      side: BorderSide(
                        width: 1.0,
                        color: isViewSelected[0]
                            ? CustomMaterialColor.bannerColor
                            : Colors.grey[500],
                      ),
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.insert_chart,
                      color:
                          isViewSelected[0] ? Colors.white : Colors.grey[500],
                    ),
                    color: isViewSelected[0]
                        ? CustomMaterialColor.bannerColor
                        : Colors.grey[500],
                    onPressed: () {
                      setState(() {
                        isViewSelected[0] = true;
                        isViewSelected[1] = false;
                        for (int index = 0;
                            index < isCategorySelected.length;
                            index++) {
                          if (isCategorySelected[index] == true) {
                            if (index == 0) {
                              widgetSelection = WidgetList.allGraph;
                            } else if (index == 1) {
                              widgetSelection = WidgetList.transportGraph;
                            } else if (index == 2) {
                              widgetSelection = WidgetList.homeGraph;
                            }
                          }
                        }
                      });
                    },
                  ),
                ),
                // Log View Button
                Ink(
                  decoration: ShapeDecoration(
                    color: isViewSelected[1]
                        ? CustomMaterialColor.bannerColor
                        : Color(0xffE5E5E5),
                    shape: CircleBorder(
                      side: BorderSide(
                        width: 1.0,
                        color: isViewSelected[1]
                            ? CustomMaterialColor.bannerColor
                            : Colors.grey[500],
                      ),
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.list,
                      color:
                          isViewSelected[1] ? Colors.white : Colors.grey[500],
                    ),
                    color: isViewSelected[1]
                        ? CustomMaterialColor.bannerColor
                        : Color(0xffE5E5E5),
                    onPressed: () {
                      setState(() {
                        isViewSelected[1] = true;
                        isViewSelected[0] = false;
                        for (int index = 0;
                            index < isCategorySelected.length;
                            index++) {
                          if (isCategorySelected[index] == true) {
                            if (index == 0) {
                              widgetSelection = WidgetList.allLog;
                            } else if (index == 1) {
                              widgetSelection = WidgetList.transportLog;
                            } else if (index == 2) {
                              widgetSelection = WidgetList.homeLog;
                            }
                          }
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }

  // Function to swtich between widget category groups for Graph/Log View
  Widget getGraphWidgetGroup() {
    switch (widgetSelection) {
      case WidgetList.allGraph:
        return getAllGraphWidgets();
      case WidgetList.transportGraph:
        return getTransportGraphWidgets();
      case WidgetList.homeGraph:
        return getHomeGraphWidgets();
      case WidgetList.allLog:
        return getAllLogWidgets();
      case WidgetList.transportLog:
        return getTransportLogWidgets();
      case WidgetList.homeLog:
        return getHomeLogWidgets();
    }
    return getAllGraphWidgets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color(0xffE5E5E5),
      child: ListView(
        padding: EdgeInsets.only(right: 8.0, left: 8.0, bottom: 8.0),
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 8.0),
            child: detailsPageLayout(),
          ),
          getGraphWidgetGroup(),
        ],
      ),
    ));
  }
}
