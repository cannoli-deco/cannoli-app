import 'package:cannoli_app/articles.dart';
import 'package:cannoli_app/color_scheme.dart';
import 'package:cannoli_app/community_feed.dart';
import 'package:flutter/material.dart';

/// Community page containing rss and community feed showing them in a tabbar.
class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(48) ,//Size.fromHeight(kToolbarHeight),
              child: Container(
                  color: Colors.white,
                  child: SafeArea(
                      child: Column(
                    children: [
                      TabBar(
                        labelColor: CustomMaterialColor.emphasisColor,
                        indicatorColor: CustomMaterialColor.emphasisColor,
                        unselectedLabelColor: CustomMaterialColor.subColorBlack[50],
                        tabs: [
                          Tab(text: "Feed"),
                          Tab(text: "Articles"),
                        ],
                      )
                    ],
                  )))),
          body: TabBarView(
            children: [CommunityFeed(), Articles()],
          ),
        ));
  }
}
