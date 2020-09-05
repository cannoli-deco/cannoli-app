import 'package:cannoli_app/database.dart';
import 'package:flutter/material.dart';

final title = "Gas Input";

class GasFormInput {
  double quantity; // in megajoules
}

int calculateEmission(double quantity) {
  return (quantity * 51.4).floor();
}

class GasInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gas",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(title),
        ),
        body: gasInputForm(),
      ),
    );
  }
}

class gasInputForm extends StatefulWidget {
  @override
  gasInputForm({Key key}) : super(key: key);

  _gasInputFormState createState() => _gasInputFormState();
}

class _gasInputFormState extends State<gasInputForm> {
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
          content: new Text("Your annual gas emissions is $emission kg of CO2"),
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
    String dropdownValue = "Medium";
    GasFormInput newGasInput = new GasFormInput();

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
                      labelText: "Quantity",
                      hintText: "MJ"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  onSaved: (String value) =>
                      {newGasInput.quantity = double.parse(value)},
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
                          int calculatedEmission =
                              calculateEmission(newGasInput.quantity);
                          addEntry(calculatedEmission, DateTime.now(), 'Gas');
                          _showDialog(calculatedEmission);
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
