import 'package:flutter/material.dart';
import 'package:cannoli_app/color_scheme.dart';

List<Widget> posts = new List<Widget>();

class CommunityCard extends StatefulWidget {
  CommunityCard({Key key, this.content, this.userName}) : super(key: key);
  final String content;
  final String userName;

  @override
  _CommunityCardState createState() => _CommunityCardState();
}

class _CommunityCardState extends State<CommunityCard> {
  @override
  Widget build(BuildContext context) {
    int postLength = posts.length;
    return SizedBox(
        width: 300,
        height: MediaQuery.of(context).size.height,
        child: postLength >= 1
            ? new ListView.builder(
                padding: EdgeInsets.only(bottom: 300),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return posts[index];
                },
              )
            : Center(
                child: RaisedButton(
                child: Text("Nothing to show..."),
                onPressed: () => addFeedPost("Ivan Leong", "Testing 123 Hello :)", new DateTime.now()),
              )));
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

void addFeedPost(String name, String content, DateTime date) {
  posts.add(feedPost(name, content, date));
  print(posts.length);
}
