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
  ScrollController _scrollController;
  List<Widget> _allWidgetEntries = [Text('Test')];
  List<Widget> _transportWidgetEntries = [Text('Test')];
  List<Widget> _homeWidgetEntries = [Text('Test')];

  Widget getLogDivider() {
    return Container(
      height: 50.0,
      width: 10.0,
    );
  }

  Widget getLogTextBody(String source, int consumption) {
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
                  '08:08 pm',
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

  Widget getLogWidget(String source, int consumption) {
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
          getLogTextBody(source, consumption),
          getLogDivider(),
          Icon(
            Icons.more_vert,
            color: Colors.grey[800],
          ),
        ],
      ),
    );
  }

  String getType(int id) {
    if (id == 383) {
      return 'Transport';
    } else {
      return 'Home Energy';
    }
  }

  @override
  void initState() {
    super.initState();
    _detailsTabController = new TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAllEntries();
      _loadTransportEntries();
      _loadHomeEntries();
    });
    // _controller = AnimationController(vsync: this);
  }

  void _loadAllEntries() async {
    List<Widget> widgets = [];
    var currentEntries = await allEntries();
    for (int i = 0; i < currentEntries.length; i++) {
      widgets.add(getLogWidget(
          getType(currentEntries[i].source_id), currentEntries[i].consumption));
    }
    setState(() {
      _allWidgetEntries = widgets;
    });
  }

  void _loadTransportEntries() async {
    List<Widget> widgets = [];
    var currentEntries = await allEntries();
    for (int i = 0; i < currentEntries.length; i++) {
      if (getType(currentEntries[i].source_id) == 'Transport') {
        widgets.add(getLogWidget(getType(currentEntries[i].source_id),
            currentEntries[i].consumption));
      }
    }
    setState(() {
      _transportWidgetEntries = widgets;
    });
  }

  void _loadHomeEntries() async {
    List<Widget> widgets = [];
    var currentEntries = await allEntries();
    for (int i = 0; i < currentEntries.length; i++) {
      if (getType(currentEntries[i].source_id) == 'Home Energy') {
        widgets.add(getLogWidget(getType(currentEntries[i].source_id),
            currentEntries[i].consumption));
      }
    }
    setState(() {
      _homeWidgetEntries = widgets;
    });
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
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: AllCharts(),
            ),
            Container(
              height: 35.0,
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
        DraggableScrollableSheet(
            initialChildSize: 0.30,
            minChildSize: 0.30,
            builder: (context, scrollController) {
              return Container(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: ListView(
                    padding: EdgeInsets.all(20.0),
                    controller: scrollController,
                    children: _allWidgetEntries,
                  ),
                ),
              );
            }),
      ],
    );
  }

  Widget tabPageTransport() {
    return Stack(
      children: <Widget>[
        Column(
          children: [
            Container(
              height: 400,
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: TransportCharts(),
            ),
            Container(
              height: 35.0,
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
        DraggableScrollableSheet(
            initialChildSize: 0.30,
            minChildSize: 0.30,
            builder: (context, scrollController) {
              return Container(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: ListView(
                    padding: EdgeInsets.all(20.0),
                    controller: scrollController,
                    children: _transportWidgetEntries,
                  ),
                ),
              );
            }),
      ],
    );
  }

  Widget tabPageHome() {
    return Stack(
      children: <Widget>[
        Column(
          children: [
            Container(
              height: 400,
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: HomeEnergyCharts(),
            ),
            Container(
              height: 35.0,
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
        DraggableScrollableSheet(
            initialChildSize: 0.30,
            minChildSize: 0.30,
            builder: (context, scrollController) {
              return Container(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: ListView(
                    padding: EdgeInsets.all(20.0),
                    controller: scrollController,
                    children: _homeWidgetEntries,
                  ),
                ),
              );
            }),
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
              tabPageTransport(),
              tabPageHome(),
            ],
          ),
        ),
      ],
    );
  }
}
