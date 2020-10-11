import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cannoli_app/color_scheme.dart';

List<Widget> posts = new List<Widget>();

class CommunityCard extends StatefulWidget {
  CommunityCard({Key key, this.postData}) : super(key: key);
  final List<DocumentSnapshot> postData;

  @override
  _CommunityCardState createState() => _CommunityCardState();
}

class _CommunityCardState extends State<CommunityCard> {
  @override
  Widget build(BuildContext context) {
    loadPost(widget.postData);
    int postLength = posts.length;
    return SizedBox(
        width: 300,
        height: MediaQuery.of(context).size.height,
        child: postLength >= 1
            ? new ListView.builder(
                padding: EdgeInsets.only(bottom: 100),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return posts[index];
                },
              )
            : Center(
                child: Text("Nothing to show..."),
              ));
  }
}

Widget feedPost(String name, String content, DateTime date) {
  return Container(
      child: IntrinsicHeight(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
        Card(
            elevation: 1,
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.account_circle,
                            color: CustomMaterialColor.subColorBlack[50],
                            size: 40),
                        Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(date.toLocal().toString().split(' ')[0],
                                      style: TextStyle(
                                          color: CustomMaterialColor
                                              .subColorBlack[50],
                                          fontSize: 10))
                                ]))
                      ],
                    ),
                    Divider(),
                    Padding(padding: EdgeInsets.symmetric(vertical: 2.5)),
                    Row(children: [Text(content)]),
                  ],
                ))),
      ])));
}

void loadPost(List<DocumentSnapshot> postData) {
  posts.clear();
  for (int i = 0; i < postData.length; i++) {
    // TODO: Date needs to be change
    posts.add(feedPost(postData[i].data()["owner_name"], postData[i].data()["content"], DateTime.now()));
  }
}