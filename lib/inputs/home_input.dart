import 'package:cannoli_app/color_scheme.dart';
import 'package:cannoli_app/database.dart';
// import 'package:cannoli_app/data_models.dart';
import 'package:flutter/material.dart';
import 'package:cannoli_app/widgets/textboxes.dart';

// final _title = 'Home Energy Input';

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

int calculateHomeEmission(
    String billingCycle, double kwh, String jurisdiction) {
  switch (billingCycle) {
    case "Monthly":
      return (conversion(kwh, 12.0, jurisdiction) * 1000).floor();
    case "Quarterly":
      return (conversion(kwh, 4.0, jurisdiction) * 1000).floor();
    case "Half-Yearly":
      return (conversion(kwh, 2.0, jurisdiction) * 1000).floor();
    case "Yearly":
      return (conversion(kwh, 1.0, jurisdiction) * 1000).floor();
    default:
      return 0;
  }
}

class HomeInput extends StatelessWidget {
  //final _formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
          child: HomeInputForm(),
        ),
      ),
    );
  }
}

class HomeInputForm extends StatefulWidget {
  @override
  HomeInputFormState createState() {
    return HomeInputFormState();
  }
}

class HomeInputFormState extends State<HomeInputForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  List<String> rowTitles = [
    'Energy Type',
    'Billing Cycle',
    'Consumption',
    'State or Territory'
  ];

  String dropDownType = "Electricity Bill";
  String dropDownBilling = "Monthly";
  String dropDownJurisdiction = "QLD";
  HomeFormInput newHomeInput = new HomeFormInput();

  void showCalculatedDialog(BuildContext context, int emission) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Text("Your annual electrical consumption emission is "
              "$emission g of CO\u2082"),
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

  void showHomeInputForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            child:

                /// Child of Alert Dialog
                Form(
              /// Form
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /// Children of Form
                  Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                    Expanded(
                      child: formTextBoxWidget(context, rowTitles[0]),
                    ),
                    Expanded(
                      child: Container(
                        child: DropdownButtonFormField(
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
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
                    )
                  ]),
                  Row(
                    /// Usage Frequency
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(child: formTextBoxWidget(context, rowTitles[1])),
                      Expanded(
                        child: Container(
                          child: DropdownButtonFormField(
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
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
                      ),
                    ],
                  ),

                  Row(
                    /// Consumption
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(child: formTextBoxWidget(context, rowTitles[2])),
                      Expanded(
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
                  // Input

                  Row(
                    /// State or Territory
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      // Text Box of 200W x 40H Pixel Dimensions for prompt text
                      Expanded(child: formTextBoxWidget(context, rowTitles[3])),
                      Expanded(
                        child: DropdownButtonFormField(
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
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
                  // Input

                  Row(
                    /// Submit button
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 12),
                        child: RaisedButton(
                          color: CustomMaterialColor.emphasisColor,
                          onPressed: () {
                            // Validate returns true if the form is valid, or false
                            // otherwise.

                            if (_formKey.currentState.validate()) {
                              // If the form is valid, display a Snackbar.
                            }
                            FormState form = _formKey.currentState;
                            form.save();

                            int calculatedEmission = calculateHomeEmission(
                                newHomeInput.billingCycle,
                                newHomeInput.kwh,
                                newHomeInput.jurisdiction);
                            // Add lines below after DB implementation for Fields used
                            // -------------------------------------------------------
                            addEntry(calculatedEmission, DateTime.now(),
                                'Home Energy');
                            // -------------------------------------------------------

                            Navigator.pop(context);
                            showCalculatedDialog(context, calculatedEmission);
                          },
                          child: Text('Submit',
                              style: TextStyle(
                                  color: CustomMaterialColor.buttonColorWhite)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {}
}
