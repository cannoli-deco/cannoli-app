import 'package:cannoli_app/color_scheme.dart';
import 'package:cannoli_app/database.dart';
// import 'package:cannoli_app/data_models.dart';
import 'package:flutter/material.dart';
import 'package:cannoli_app/widgets/textboxes.dart';

class EditEntryForm {
  String source;
  String type;
  double emissions;
  double distance;
  DateTime time;

  EditEntryForm({
    this.source,
    this.type,
    this.emissions,
    this.distance,
    this.time,
  });
}

int calculateTransportEmission(String type, double distance) {
  switch (type) {
    case "Medium":
      return (0.297 * distance * 1000)
          .floor(); // emissions (kg/km) * distance * 1000 (gram conversion)
    case "Small":
      return (0.228 * distance * 1000).floor();
    case "Large":
      return (0.411 * distance * 1000).floor();
    case "Diesel":
      return (0.401 * distance * 1000).floor();
    default:
      return 0;
  }
}

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

class EditEntry extends StatefulWidget {
  @override
  _EditEntryState createState() => _EditEntryState();
}

class _EditEntryState extends State<EditEntry> {
  final _formKey = GlobalKey<FormState>();
  EditEntryForm editEntryForm = new EditEntryForm();
  String dropdownTransportValue = "Medium";

  void showEditDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext) {
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
                    Row(mainAxisSize: MainAxisSize.max, children: <Widget>[]),

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
                            },
                            child: Text('Submit',
                                style: TextStyle(
                                    color:
                                        CustomMaterialColor.buttonColorWhite)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {}
}
