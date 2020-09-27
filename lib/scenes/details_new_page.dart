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
  ScrollController _scrollController;

  Widget getLogDivider() {
    return Container(
      height: 50.0,
      width: 10.0,
    );
  }

  Widget getLogTextBody() {
    return Container(
      height: 50.0,
      width: 290.0,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Home Energy',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '08:08 pm',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
            Container(
              height: 3.0,
            ),
            Text(
              'Car, 302 CO\u2082 footprint  ',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getLogWidget() {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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
            getLogTextBody(),
            getLogDivider(),
            Icon(
              Icons.more_vert,
              color: Colors.grey[800],
            ),
          ],
        ),
      ),
    );
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
    return Stack(
      children: <Widget>[
        Column(
          children: [
            Container(
              height: 400,
              child: Container(
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                child: AllCharts(),
              ),
            ),
          ],
        ),
        DraggableScrollableSheet(
            initialChildSize: 0.30,
            minChildSize: 0.30,
            builder: (context, scrollController) {
              return Container(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: ListView(
                    padding: EdgeInsets.all(20.0),
                    controller: scrollController,
                    children: [
                      getLogWidget(),
                      getLogWidget(),
                      getLogWidget(),
                      getLogWidget(),
                      getLogWidget(),
                      getLogWidget(),
                      getLogWidget(),
                      getLogWidget(),
                      getLogWidget(),
                      getLogWidget(),
                      getLogWidget(),
                    ],
                  ),
                ),
              );
            }),
      ],
    );
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
          height: 628.0,
          color: Colors.grey[200],
          child: TabBarView(
            controller: _detailsTabController,
            children: [
              tabPageAll(),
              tabPage(),
              tabPage(),
            ],
          ),
        ),
      ],
    );
  }
}
