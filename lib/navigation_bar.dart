import 'package:flutter/material.dart';
import 'package:cannoli_app/graphic_representation.dart';


class NavigationBar extends StatefulWidget {
  NavigationBar({Key key}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  PageController _pageController = PageController();

  /// Import and add your components here
  List<Widget> _screens = <Widget>[
    Text(
      'Placeholder',
      style: optionStyle,
    ),
    /// Add detail page here
    Dashboard(),
    Text(
      'Placeholder',
      style: optionStyle,
    ),
    Text(
      'Placeho',
      style: optionStyle,
    )
  ];

  void _onPageChanged(int index){
    setState(() {
      if (index != 2) {
        _selectedIndex = index;
      }
    });
  }

  void _onItemTapped(int index) {
    // print(index);
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      floatingActionButton: new FloatingActionButton(
          elevation: 5.0,
          child: new Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/input');
          }),
      bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(
                icon: Icon(Icons.show_chart), title: Text('Detail')),

            BottomNavigationBarItem(
              title: Text(''),
              icon: Icon(
                Icons.favorite,
                color: Colors.white,
                size: 1
              )
            ),
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
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
