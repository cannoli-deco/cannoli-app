import 'package:cannoli_app/widgets/details_widgets.dart';
import 'package:cannoli_app/widgets/graph_view_widgets.dart';
import 'package:cannoli_app/widgets/log_view_widgets.dart';
import 'package:flutter/material.dart';

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
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget getWidgetStack() {
    return Stack(
      children: <Widget>[
        Column(
          children: [
            Container(
              height: 400,
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
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text('Log Widget: 1'),
                subtitle: Text('CO2\nDate/Time'),
                trailing: Icon(Icons.more_vert),
              ),
            );
          },
        ),
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
    return Scaffold(
      body: getWidgetStack(),
    );
  }
}
