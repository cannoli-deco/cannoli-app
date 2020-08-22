import 'package:flutter/material.dart';

class InputList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final title = 'Choose input';

    return MaterialApp(
        title: title,
        home: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.directions_car),
                title: Text('Car'),
                onTap: () { Navigator.pushNamed(context, '/input/car'); }
              ),
              ListTile(
                leading: Icon(Icons.flash_on),
                title: Text('Electricity'),
              ),
              ListTile(
                leading: Icon(Icons.theaters),
                title: Text('Gas'),
              ),
            ],
          ),
        ),
    );
  }
}
