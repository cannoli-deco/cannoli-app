import 'package:cannoli_app/database.dart';
import 'package:flutter/material.dart';

final title = "Car input";

class CarFormInput {
  String type;
  double emissions;
  double distance;
}

class CarInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Car",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(title),
        ),
        body: carInputForm(),
      ),
    );
  }
}

class carInputForm extends StatefulWidget {
  @override
  carInputForm({Key key}) : super(key: key);

  _carInputFormState createState() => _carInputFormState();
}

class _carInputFormState extends State<carInputForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.

  final _formKey = GlobalKey<FormState>();

  void _showDialog(double emission) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Text("You emitted $emission"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                // go back to home
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = "Regular";
    CarFormInput newCarInput = new CarFormInput();

    return Form(
        autovalidate: true,
        key: _formKey,
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.directions),
                    labelText: "Distance",
                    hintText: "km"
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  onSaved: (String value) => {newCarInput.distance =  double.parse(value)},
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.directions_car),
                    labelText: "Type of car"
                  ),
                  style: TextStyle(color: Theme.of(context).accentColor),
                  value: dropdownValue,
                  iconSize: 24,
                  elevation: 16,
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['Regular', 'Two', 'Free', 'Four']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onSaved: (String selection) {
                    newCarInput.type = selection;
                  },
                ),
                SizedBox(height: 25),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RaisedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false
                          // otherwise.
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, display a Snackbar.
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Processing Data')));
                          }
                          FormState form = _formKey.currentState;
                          form.save();
                          int calculatedEmission = newCarInput.distance.floor();
                          addEntry(calculatedEmission, DateTime.now(), 'Car');
                          _showDialog(newCarInput.distance);
                        },
                        child: Text('Submit'),
                      ),
                      Container(height: 20.0)
                    ]),
              ],
            )
          ],
        ));
  }
}
