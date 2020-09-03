import 'package:cannoli_app/dividers.dart';
import 'package:flutter/material.dart';

class InputList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Choose input';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(title),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
                leading: Icon(Icons.directions_car),
                title: Text('Car'),
                onTap: () {
                  Navigator.pushNamed(context, '/input/car');
                }),
            listDivider,
            ListTile(
                leading: Icon(Icons.flash_on),
                title: Text('Electricity'),
                onTap: () {
                  Navigator.pushNamed(context, '/input/electricity');
                }),
            listDivider,
            ListTile(
              leading: Icon(Icons.theaters),
              title: Text('Gas'),
            ),
            listDivider
          ],
        ),
      ),
    );
  }
}
