import 'package:cannoli_app/color_scheme.dart';
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
    return Stack(
      children: <Widget>[
        Column(
          children: [
            Container(
              height: 400,
              padding: EdgeInsets.all(20.0),
              child: AllCharts(),
            ),
          ],
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.15,
          minChildSize: 0.10,
          expand: true,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Container(
                child: ListView(
                  padding: EdgeInsets.all(10.0),
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text('Log Widget: 1'),
                      subtitle: Text('CO2\nDate/Time'),
                      trailing: Icon(Icons.more_vert),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
    ;
  }

  Widget tabPage() {
    return Container(
      height: 200.0,
      padding: EdgeInsets.all(20.0),
      child: Text('Page'),
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
          color: CustomMaterialColor.bannerColor,
          child: TabBar(
            controller: _detailsTabController,
            indicatorColor: CustomMaterialColor.emphasisColor,
            labelColor: CustomMaterialColor.emphasisColor,
            unselectedLabelColor: Colors.white,
            tabs: tabLabels,
          ),
        ),
        Container(
          height: 602.0,
          color: Colors.blue,
          child: TabBarView(
            controller: _detailsTabController,
            children: [
              tabPageAll(),
              tabPage(),
              tabPage(),
            ],
          ),
        ),
        Container(
          height: 26.0,
          color: Colors.amber,
        ),
      ],
    );
  }
}
