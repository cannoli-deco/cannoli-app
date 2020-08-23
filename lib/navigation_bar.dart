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

  /// Import and add your components here
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Placeholder', style: optionStyle),
    Text(
      'Placeholder',
      style: optionStyle,
    ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      floatingActionButton: new FloatingActionButton(
          elevation: 5.0,
          child: new Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/input');
          }),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(
                icon: Icon(Icons.show_chart), title: Text('Detail')),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              title: Text('Community'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('User'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).accentColor,
//          backgroundColor: Colors.green,
          onTap: _onItemTapped),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
