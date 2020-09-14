import 'package:cannoli_app/database.dart';
import 'package:flutter/material.dart';
import 'package:cannoli_app/widgets/textboxes.dart';

final _title = 'Home Energy Input';

class HomeFormInput {
  String type;
  String billingCycle;
  double kwh;
  String jurisdiction;
}

// Converts electrical consumption (kWh) to kg of C02
double conversion(double val, double mul, String jurisdiction) {
  switch (jurisdiction) {
    case "NSW":
      // consumption * conversion to annual consumption * state emissions factor
      return (val * mul * 0.81);
    case "ACT":
      return (val * mul * 0.81);
    case "VIC":
      return (val * mul * 1.02);
    case "QLD":
      return (val * mul * 0.81);
    case "SA":
      return (val * mul * 0.44);
    case "WA":
      return (val * mul * 0.64); // average of EF for SWIS and NWIS
    case "TAS":
      return (val * mul * 0.15);
    case "NT":
      return (val * mul * 0.63);
    default:
      return 0;
  }
}

int calculateEmission(String billingCycle, double kwh, String jurisdiction) {
  switch (billingCycle) {
    case "Monthly":
      return (conversion(kwh, 12.0, jurisdiction)).floor();
    case "Quarterly":
      return (conversion(kwh, 4.0, jurisdiction)).floor();
    case "Half-Yearly":
      return (conversion(kwh, 2.0, jurisdiction)).floor();
    case "Yearly":
      return (conversion(kwh, 1.0, jurisdiction)).floor();
    default:
      return 0;
  }
}

class HomeInput extends StatelessWidget {
  //final _formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Home Energy Input',
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(_title),
          ),
          body: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
            child: HomeInputForm(),
          ),
        ));
  }
}

class HomeInputForm extends StatefulWidget {
  @override
  _HomeInputForm createState() {
    return _HomeInputForm();
  }
}

class _HomeInputForm extends State<HomeInputForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  void _showDialog(int emission) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Text("Your annual electrical consumption emission is "
              "$emission kg of CO2"),
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

  List<String> rowTitles = [
    'Home Energy Type',
    'Billing Cycle',
    'Consumption',
    'State or Territory'
  ];

  @override
  Widget build(BuildContext context) {
    String dropDownType = "Electricity Bill";
    String dropDownBilling = "Monthly";
    String dropDownJurisdiction = "QLD";
    HomeFormInput newHomeInput = new HomeFormInput();
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          // Each Row() contains a prompt and input.
          // Home Energy Type
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Prompt
              Column(
                children: <Widget>[
                  // Text Box of 200W x 40H Pixel Dimensions for prompt text
                  formTextBoxWidget(context, rowTitles[0]),
                ],
              ),
              // Input
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 120.0,
                    height: 40.0,
                    child: DropdownButtonFormField(
                      style: TextStyle(color: Theme.of(context).accentColor),
                      value: dropDownType,
                      onChanged: (String newValue) {
                        setState(() {
                          dropDownType = newValue;
                        });
                      },
                      items: <String>[
                        'Electricity Bill',
                        'Water Bill',
                        'Miscellaneous'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onSaved: (String selection) {
                        newHomeInput.type = selection;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Billing Cycle
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Prompt
              Column(
                children: <Widget>[
                  // Text Box of 200W x 40H Pixel Dimensions for prompt text
                  formTextBoxWidget(context, rowTitles[1]),
                ],
              ),
              // Input
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 120.0,
                    height: 40.0,
                    child: DropdownButtonFormField(
                      style: TextStyle(color: Theme.of(context).accentColor),
                      value: dropDownBilling,
                      onChanged: (String newValue) {
                        setState(() {
                          dropDownBilling = newValue;
                        });
                      },
                      items: <String>[
                        'Monthly',
                        'Quarterly',
                        'Half-Yearly',
                        'Yearly'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onSaved: (String selection) {
                        newHomeInput.billingCycle = selection;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Consumption
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Prompt
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  formTextBoxWidget(context, rowTitles[2]),
                ],
              ),
              // Input
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 120.0,
                    height: 40.0,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'kWh',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter number';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      onSaved: (String value) =>
                          {newHomeInput.kwh = double.parse(value)},
                    ),
                  ),
                ],
              ),
            ],
          ),
          // State or Territory
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Prompt
              Column(
                children: <Widget>[
                  // Text Box of 200W x 40H Pixel Dimensions for prompt text
                  formTextBoxWidget(context, rowTitles[3]),
                ],
              ),
              // Input
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 120.0,
                    height: 40.0,
                    child: DropdownButtonFormField(
                      style: TextStyle(color: Theme.of(context).accentColor),
                      value: dropDownJurisdiction,
                      onChanged: (String newValue) {
                        setState(() {
                          dropDownJurisdiction = newValue;
                        });
                      },
                      items: <String>[
                        'NSW',
                        'ACT',
                        'VIC',
                        'QLD',
                        'SA',
                        'WA',
                        'TAS',
                        'NT'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onSaved: (String selection) {
                        newHomeInput.jurisdiction = selection;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Submit Button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
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
                      int calculatedEmission = calculateEmission(
                          newHomeInput.billingCycle,
                          newHomeInput.kwh,
                          newHomeInput.jurisdiction);
                      // Add lines below after DB implementation for Fields used
                      // -------------------------------------------------------
                      //addEntry(
                      //    calculatedEmission, DateTime.now(), 'Home Energy');
                      // -------------------------------------------------------
                      _showDialog(calculatedEmission);
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
