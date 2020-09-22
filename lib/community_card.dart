import 'package:flutter/material.dart';

class CommunityCard extends StatefulWidget {
  CommunityCard({Key key, this.content, this.userName}) :super(key: key);
  final String content;
  final String userName;

  @override
  _CommunityCardState createState() => _CommunityCardState();
}

class _CommunityCardState extends State<CommunityCard> {

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
          width: 200,
          height: 300,
          child:
          Scaffold(
            body: Container(
        padding: EdgeInsets.fromLTRB(10,10,10,0),
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(7),
                  child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerRight,
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(left: 10, top: 5),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(left: 15.0),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Icon(
                                                  Icons.person,
                                                  color: Colors.amber,
                                                  size: 40,
                                                )),
                                          ),
                                         Text(
                                           widget.userName
                                         )
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        children: [
                                          Text(
                                            widget.content
                                          )
                                        ],
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),

                      ]),
                ),
              ),
            ),
          )
      );
  }
}
