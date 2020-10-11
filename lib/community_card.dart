import 'package:cannoli_app/widgets/feed_widget.dart';
import 'package:flutter/material.dart';

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
        child: postLength >= 1 ? 
        new ListView.builder (
          itemCount: posts.length,
          itemBuilder: (context, index) {
          return posts[index];
        },) 
        : Center( child: RaisedButton( child: Text("Nothing to show..."), onPressed: () => addFeedPost(),))
    );
  }
}
