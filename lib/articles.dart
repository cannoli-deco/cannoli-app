import 'package:cannoli_app/article_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

Future<RssFeed> fetchRSS() async {
  final response =
      await http.get('https://www.sciencedaily.com/rss/top/environment.xml');
  if (response.statusCode == 200) {
    return RssFeed.parse(response.body);
  } else {
    throw Exception('Failed to load RSS');
  }
}

class Articles extends StatefulWidget {
  @override
  _ArticlesState createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  Future<RssFeed> articles;

  @override
  void initState() {
    super.initState();
    articles = fetchRSS();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<RssFeed>(
          future: articles,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.items.length,
                itemBuilder: (context, index) {
                  RssItem item = snapshot.data.items[index];
                  return ArticleTile(
                    thumbnail: null != null ? Text(item.content.images.first) : Container(decoration: const BoxDecoration(color: Colors.pink)),
                    title: item.title,
                    subtitle: item.description,
                    author: item.author,
                    publishDate: item.pubDate.toString(),
                    url: item.link,
                  );
                },
              );
            }
            return Center(
                child: SizedBox(
                    width: 30, height: 30, child: CircularProgressIndicator()));
          }),
    );
  }
}
