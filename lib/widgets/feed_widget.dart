import 'package:flutter/material.dart';
import 'package:cannoli_app/color_scheme.dart';

List<Widget> posts = new List<Widget>();

Widget feedPost() {
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
                                    color:
                                        CustomMaterialColor.subColorBlack[50],
                                    size: 40),
                                Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: 
                                    Column ( 
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: 
                                      [Text("Ivan Leong", style: TextStyle(fontWeight: FontWeight.bold),),
                                      Text("10/10/2020", style: TextStyle(color: CustomMaterialColor.subColorBlack[50], fontSize: 10))
                                      ]))
                              ],
                            ),
                            Divider(),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.5)),
                            Row(children: [Text("hello")]),
                          ],
                        ))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "10",
                          style: TextStyle(color: CustomMaterialColor.subColorBlack[50]),
                        ),
                        IconButton(
                          icon: Icon (Icons.tag_faces, size: 20, color: CustomMaterialColor.subColorBlack[50]),
                          onPressed: () {
                            addFeedPost();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10,)
              ])));
}

void addFeedPost() {
  posts.add(feedPost());
  print(posts.length);
}