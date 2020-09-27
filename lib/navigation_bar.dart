import 'package:cannoli_app/color_scheme.dart';
import 'package:cannoli_app/comparison_graph.dart';
import 'package:cannoli_app/inputs/home_input.dart';
import 'package:cannoli_app/inputs/car_input.dart';
import 'package:cannoli_app/login/login.dart';
import 'package:cannoli_app/scenes/community_page.dart';
import 'package:cannoli_app/scenes/details_new_page.dart';
import 'package:flutter/material.dart';
import 'package:cannoli_app/scenes/home_page.dart';

import 'package:cannoli_app/scenes/details_page.dart';
import 'package:flutter/rendering.dart';

class NavigationBar extends StatefulWidget {
  NavigationBar({Key key}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  // Global variables for state change
  bool _addActive = false;

  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  PageController _pageController = PageController();

  // Import and add your components here
  List<Widget> _screens = <Widget>[
    // Add home page here
    Homepage(),

    /// Add detail page here

    NewDetailsPage(),
    Text(
      'Placeholder',
      style: optionStyle,
    ),
    CommunityPage(),
    // Add login page here
    LoginPage()
  ];

  void _onPageChanged(int index) {
    setState(() {
      if (index != 2) {
        _selectedIndex = index;
      }
    });
  }

  void _onItemTapped(int index) {
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
      floatingActionButton: Stack(
          children: _addActive
              ? <Widget>[
                  Align(
                    alignment: Alignment(0, 0.92),
                    child: new FloatingActionButton(
                        elevation: 1.0,
                        backgroundColor: CustomMaterialColor.bannerColor,
                        child: new Icon(Icons.add,
                            color: CustomMaterialColor.buttonColorWhite),
                        onPressed: () {
                          //Navigator.pushNamed(context, '/input');
                          setState(() {
                            _addActive = !_addActive;
                          });
                        }),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _addActive = !_addActive;
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black.withAlpha(100),
                    ),
                  ),
                  Align(
                    /// left child button
                    alignment: Alignment(-0.3, 0.7),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 5),
                        width: 50,
                        height: 50,
                        child: FloatingActionButton(
                            elevation: 1.0,
                            backgroundColor:
                                CustomMaterialColor.buttonColorWhite,
                            child: new Icon(Icons.drive_eta,
                                color: CustomMaterialColor.bannerColor),
                            onPressed: () {
                              //Navigator.pushNamed(context, '/input');
                              CarInputFormState().showCarInputForm(context);

                              setState(() {});
                            }),
                      ),
                      Text('Transport',
                          style: TextStyle(
                              color: CustomMaterialColor.buttonColorWhite)),
                    ]),
                  ),
                  Align(
                    /// right child button
                    alignment: Alignment(0.3, 0.7),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 5),
                        width: 50,
                        height: 50,
                        child: FloatingActionButton(
                            elevation: 1.0,
                            backgroundColor:
                                CustomMaterialColor.buttonColorWhite,
                            child: new Icon(Icons.home,
                                color: CustomMaterialColor.bannerColor),
                            onPressed: () {
                              HomeInputFormState().showHomeInputForm(context);

                              setState(() {});
                            }),
                      ),
                      Text('Home Energy',
                          style: TextStyle(
                              color: CustomMaterialColor.buttonColorWhite)),
                    ]),
                  ),
                ]
              : <Widget>[
                  Align(
                    alignment: Alignment(0, 0.92),
                    child: FloatingActionButton(
                        elevation: 1.0,
                        backgroundColor: CustomMaterialColor.bannerColor,
                        child: new Icon(Icons.add,
                            color: CustomMaterialColor.buttonColorWhite),
                        onPressed: () {
                          //Navigator.pushNamed(context, '/input');
                          setState(() {
                            _addActive = !_addActive;
                          });
                        }),
                  ),
                ]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart), title: Text('Detail')),
          new BottomNavigationBarItem(
              icon: Icon(Icons.favorite, size: 0), title: Text('')),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            title: Text('Community'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('User'),
          ),
        ],
        selectedItemColor: CustomMaterialColor.bannerColor,
//          backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
