import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {
  NavigationBar({Key key}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Placeholder', style: optionStyle),
    Text(
      'Placeholder',
      style: optionStyle,
    ),
    Text(
      'Placeholder',
      style: optionStyle,
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// Import and add your components here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart),
              title: Text('Placeholder'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart),
              title: Text('Placeholder'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).accentColor,
          onTap: _onItemTapped),
    );
  }
}
