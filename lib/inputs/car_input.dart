import 'package:cannoli_app/color_scheme.dart';
import 'package:cannoli_app/database.dart';
import 'package:flutter/material.dart';

final title = "Car input";

class CarFormInput {
  String type;
  double emissions;
  double distance;
}

int calculateEmission(String type, double distance) {
  switch (type) {
    case "Medium":
      return (0.297 * distance).floor() * 1000; // emissions (kg/km) * distance * 1000 (gram conversion)
    case "Small":
      return (0.228 * distance).floor() * 1000;
    case "Large":
      return (0.411 * distance).floor() * 1000;
    case "Diesel":
      return (0.401 * distance).floor() * 1000;
    default:
      return 0;
  }
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
        body: CarInputForm(),
      ),
    );
  }
}

class CarInputForm extends StatefulWidget {
  @override
  CarInputForm({Key key}) : super(key: key);

  CarInputFormState createState() => CarInputFormState();
}

class CarInputFormState extends State<CarInputForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.

  final _formKey = GlobalKey<FormState>();
  String dropdownValue = "Medium";
  CarFormInput newCarInput = new CarFormInput();

  void showCalculatedDialog(BuildContext context, int emission) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content:
              new Text("Your annual car emissions is $emission g of CO\u2082"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                // go back to home
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void showCarInputForm(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              /// Child of Alert Dialog
              Form(
                /// Form
                key: _formKey,
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Row(children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            icon: Icon(Icons.directions),
                            labelText: "Distance",
                            hintText: "km"),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        onSaved: (String value) =>
                            {newCarInput.distance = double.parse(value)},
                      ),
                    )
                  ]),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.directions_car),
                        labelText: "Type of car"),
                    style: TextStyle(color: Theme.of(context).accentColor),
                    value: dropdownValue,
                    iconSize: 24,
                    elevation: 16,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>['Medium', 'Small', 'Large', 'Diesel']
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
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RaisedButton(
                          color: CustomMaterialColor.emphasisColor,
                          onPressed: () {
                            // Validate returns true if the form is valid, or false
                            // otherwise.
                            if (_formKey.currentState.validate()) {
                              // If the form is valid, display a Snackbar.
                            }
                            FormState form = _formKey.currentState;
                            form.save();
                            int calculatedEmission = calculateEmission(
                                newCarInput.type, newCarInput.distance);
                            addEntry(calculatedEmission, DateTime.now(), 'Car');
                            Navigator.pop(context);
                            showCalculatedDialog(context, calculatedEmission);
                          },
                          child: Text('Submit',
                              style: TextStyle(
                                  color: CustomMaterialColor.buttonColorWhite)),
                        ),
                        Container(height: 20.0)
                      ]),
                ]),
              ),
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {}
}
