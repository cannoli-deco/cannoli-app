import 'package:cannoli_app/color_scheme.dart';
import 'package:cannoli_app/database.dart';
// import 'package:cannoli_app/data_models.dart';
import 'package:cannoli_app/widgets/details_widgets.dart';
import 'package:cannoli_app/widgets/graph_view_widgets.dart';
import 'package:cannoli_app/widgets/log_view_widgets.dart';
import 'package:flutter/material.dart';

final List<Tab> tabLabels = <Tab>[
  Tab(
    text: 'All',
  ),
  Tab(
    text: 'Transport',
  ),
  Tab(
    text: 'Home Energy',
  )
];

enum WidgetList {
  allGraph,
  allLog,
  transportGraph,
  transportLog,
  homeGraph,
  homeLog,
}

class NewDetailsPage extends StatefulWidget {
  @override
  _NewDetailsPageState createState() => _NewDetailsPageState();
}

class _NewDetailsPageState extends State<NewDetailsPage>
    with SingleTickerProviderStateMixin {
  WidgetList widgetSelection = WidgetList.allGraph;
  // AnimationController _controller;
  TabController _detailsTabController;

  String getType(int id) {
    if (id == 3) {
      return 'Transport';
    } else {
      return 'Home Energy';
    }
  }

  @override
  void initState() {
    super.initState();
    _detailsTabController = new TabController(length: 3, vsync: this);
    // _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _detailsTabController.dispose();
    // _controller.dispose();
  }

  Widget tabPageAll() {
    return Expanded(
      child: Center(
        child: Stack(
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 400,
                    //padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                    child: AllCharts(),
                  ),
                  Container(
                    //height: 35.0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Swipe up for more',
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey[500],
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_up,
                            color: Colors.grey[500],
                            size: 15.0,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Center(
              child: AllLogSheet(),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabPageTransport() {
    return Stack(
      children: <Widget>[
        Column(
          children: [
            Container(
              height: 400,
              //padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: TransportCharts(),
            ),
            Container(
              //height: 35.0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Swipe up for more',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey[500],
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_up,
                      color: Colors.grey[500],
                      size: 15.0,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        TransportLogSheet(),
      ],
    );
  }

  Widget tabPageHome() {
    return Stack(
      children: <Widget>[
        Center(
          child: Column(
            children: [
              Container(
                height: 400,
                //padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                child: HomeEnergyCharts(),
              ),
              Container(
                //height: 35.0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Swipe up for more',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey[500],
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.grey[500],
                        size: 15.0,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        HomeLogSheet(),
      ],
    );
  }

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Material(
          color: Colors.white,
          child: TabBar(
            controller: _detailsTabController,
            labelColor: CustomMaterialColor.emphasisColor,
            indicatorColor: CustomMaterialColor.emphasisColor,
            unselectedLabelColor: CustomMaterialColor.subColorBlack[50],
            tabs: tabLabels,
          ),
        ),
        Container(
          height: 628.0,
          color: Colors.grey[200],
          child: TabBarView(
            controller: _detailsTabController,
            children: [
              tabPageAll(),
              tabPageTransport(),
              tabPageHome(),
            ],
          ),
        ),
      ],
    );
  }
}
