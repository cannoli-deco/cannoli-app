import 'package:cannoli_app/inputs/car_input.dart';
import 'package:cannoli_app/inputs/home_input.dart';
import 'package:cannoli_app/widgets/textboxes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../color_scheme.dart';
import '../database.dart';

String getType(int id) {
  if (id == 383) {
    return 'Transport';
  } else {
    return 'Home Energy';
  }
}

int getSourceID(String source) {
  if (source == 'Transport') {
    return 383;
  } else {
    return 1;
  }
}

bool getSourceBool(String source) {
  if (source == 'Transport') {
    return true;
  }
  return false;
}

String getTimeStamp(DateTime time) {
  DateTime justNow = DateTime.now().subtract(Duration(minutes: 1));
  if (!time.difference(justNow).isNegative) {
    return 'Just now';
  }
  DateTime today = DateTime.now().subtract(Duration(days: 1));
  if (!time.difference(today).isNegative) {
    return 'Today, ' + DateFormat.jm().format(time);
  }
  return 'More than a day ago';
}

Widget getLogDivider() {
  return Container(
    height: 50.0,
    width: 10.0,
  );
}

Widget getLogTextBody(String source, int consumption, DateTime time) {
  return Container(
    height: 50.0,
    width: 300.0,
    child: Padding(
      padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            source,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
          Container(
            height: 3.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                consumption.toString() + ' CO\u2082 footprint',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[500],
                ),
              ),
              Text(
                getTimeStamp(time),
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class AllLogSheet extends StatefulWidget {
  @override
  _AllLogSheetState createState() => _AllLogSheetState();
}

class _AllLogSheetState extends State<AllLogSheet> {
  //AnimationController _controller;
  List<Widget> _allWidgetEntries = [Text('Test')];
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

  String dropdownValue = "Medium";
  CarFormInput newCarInput = new CarFormInput();

  showDeleteConfirmation(BuildContext context, int id) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: Colors.grey[600]),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        "Delete",
        style: TextStyle(color: Colors.red[500]),
      ),
      onPressed: () {
        deleteEntry(id);
        Navigator.pop(context);
        setState(() {
          _loadAllEntries();
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text("Are you sure you want to permanently delete this item?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showEditConfirmation(
      BuildContext context, int id, String source, DateTime time) {
    if (source == 'Transport') {
      showTransportEditConfirmation(context, id, time);
    } else if (source == 'Home Energy') {
      showHomeEditConfirmation(context, id, time);
    }
  }

  showTransportEditConfirmation(BuildContext context, int id, DateTime time) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Edit Entry"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text('Source'),
              ),
              Text(
                'Transport',
                style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Form(
            /// Form
            key: _formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
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
                    icon: Icon(Icons.directions_car), labelText: "Type of car"),
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
                        deleteEntry(id);
                        addEntry(calculatedEmission, time, 'Transport');
                        setState(() {
                          _loadAllEntries();
                        });
                        Navigator.pop(context);
                      },
                      child: Text('Save Changes',
                          style: TextStyle(
                              color: CustomMaterialColor.buttonColorWhite)),
                    ),
                    Container(height: 20.0)
                  ]),
            ]),
          ),
        ],
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showHomeEditConfirmation(BuildContext context, int id, DateTime time) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Edit Entry"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text('Source'),
              ),
              Expanded(
                child: Text(
                  'Home Energy',
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
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
                          deleteEntry(id);
                          addEntry(calculatedEmission, time, 'Home Energy');
                          setState(() {
                            _loadAllEntries();
                          });
                          Navigator.pop(context);
                        },
                        child: Text('Save Changes',
                            style: TextStyle(
                                color: CustomMaterialColor.buttonColorWhite)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _loadAllEntries() async {
    List<Widget> widgets = [];
    var currentEntries = await allEntries();
    for (int i = 0; i < currentEntries.length; i++) {
      widgets.add(getLogWidget(
          currentEntries[i].id,
          getType(currentEntries[i].source_id),
          currentEntries[i].consumption,
          currentEntries[i].entry_date));
    }
    setState(() {
      _allWidgetEntries = widgets;
    });
  }

  Widget getLogWidget(int id, String source, int consumption, DateTime time) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300],
            width: 0.5,
          ),
        ),
      ),
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.home,
              color: Colors.grey[800],
            ),
          ),
          getLogDivider(),
          getLogTextBody(source, consumption, time),
          getLogDivider(),
          Container(
            width: 20.0,
            alignment: Alignment.center,
            child: PopupMenuButton(
              itemBuilder: (context) {
                var list = List<PopupMenuEntry<Object>>();
                list.add(
                  PopupMenuItem(
                    child: Container(
                      width: 70.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.create,
                            size: 18,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Edit',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    value: 1,
                  ),
                );
                list.add(
                  PopupMenuItem(
                    child: Container(
                      width: 70.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.delete,
                            size: 18,
                            color: Colors.red[500],
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Delete',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                    value: 2,
                  ),
                );
                return list;
              },
              onSelected: (value) {
                if (value == 1) {
                  showEditConfirmation(context, id, source, time);
                } else {
                  showDeleteConfirmation(context, id);
                }
              },
              icon: Container(
                width: 4.0,
                child: Icon(
                  Icons.more_vert,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
          /*
        Icon(
          Icons.more_vert,
          color: Colors.grey[800],
        ),
        */
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAllEntries();
    });
    //_controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    //_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.30,
        minChildSize: 0.30,
        builder: (context, scrollController) {
          return Container(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: ListView(
                padding: EdgeInsets.all(20.0),
                controller: scrollController,
                children: _allWidgetEntries,
              ),
            ),
          );
        });
  }
}

class TransportLogSheet extends StatefulWidget {
  @override
  _TransportLogSheetState createState() => _TransportLogSheetState();
}

class _TransportLogSheetState extends State<TransportLogSheet> {
  //AnimationController _controller;
  List<Widget> _transportWidgetEntries = [Text('Test')];

  final _formKey = GlobalKey<FormState>();

  String dropdownValue = "Medium";
  CarFormInput newCarInput = new CarFormInput();

  showDeleteConfirmation(BuildContext context, int id) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: Colors.grey[600]),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        "Delete",
        style: TextStyle(color: Colors.red[500]),
      ),
      onPressed: () {
        deleteEntry(id);
        Navigator.pop(context);
        setState(() {
          _loadTransportEntries();
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text("Are you sure you want to permanently delete this item?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showTransportEditConfirmation(BuildContext context, int id, DateTime time) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Edit Entry"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text('Source'),
              ),
              Text(
                'Transport',
                style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Form(
            /// Form
            key: _formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
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
                    icon: Icon(Icons.directions_car), labelText: "Type of car"),
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
                        deleteEntry(id);
                        addEntry(calculatedEmission, time, 'Transport');
                        setState(() {
                          _loadTransportEntries();
                        });
                        Navigator.pop(context);
                      },
                      child: Text('Save Changes',
                          style: TextStyle(
                              color: CustomMaterialColor.buttonColorWhite)),
                    ),
                    Container(height: 20.0)
                  ]),
            ]),
          ),
        ],
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _loadTransportEntries() async {
    List<Widget> widgets = [];
    var currentEntries = await allEntries();
    for (int i = 0; i < currentEntries.length; i++) {
      if (getType(currentEntries[i].source_id) == 'Transport') {
        widgets.add(getLogWidget(
            currentEntries[i].id,
            getType(currentEntries[i].source_id),
            currentEntries[i].consumption,
            currentEntries[i].entry_date));
      }
    }
    setState(() {
      _transportWidgetEntries = widgets;
    });
  }

  Widget getLogWidget(int id, String source, int consumption, DateTime time) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300],
            width: 0.5,
          ),
        ),
      ),
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.home,
              color: Colors.grey[800],
            ),
          ),
          getLogDivider(),
          getLogTextBody(source, consumption, time),
          getLogDivider(),
          Container(
            width: 20.0,
            alignment: Alignment.center,
            child: PopupMenuButton(
              itemBuilder: (context) {
                var list = List<PopupMenuEntry<Object>>();
                list.add(
                  PopupMenuItem(
                    child: Container(
                      width: 70.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.create,
                            size: 18,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Edit',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    value: 1,
                  ),
                );
                list.add(
                  PopupMenuItem(
                    child: Container(
                      width: 70.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.delete,
                            size: 18,
                            color: Colors.red[500],
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Delete',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                    value: 2,
                  ),
                );
                return list;
              },
              onSelected: (value) {
                if (value == 1) {
                  showTransportEditConfirmation(context, id, time);
                } else {
                  showDeleteConfirmation(context, id);
                }
              },
              icon: Container(
                width: 4.0,
                child: Icon(
                  Icons.more_vert,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
          /*
        Icon(
          Icons.more_vert,
          color: Colors.grey[800],
        ),
        */
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTransportEntries();
    });
    //_controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    //_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.30,
        minChildSize: 0.30,
        builder: (context, scrollController) {
          return Container(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: ListView(
                padding: EdgeInsets.all(20.0),
                controller: scrollController,
                children: _transportWidgetEntries,
              ),
            ),
          );
        });
  }
}

class HomeLogSheet extends StatefulWidget {
  @override
  _HomeLogSheetState createState() => _HomeLogSheetState();
}

class _HomeLogSheetState extends State<HomeLogSheet> {
  //AnimationController _controller;
  List<Widget> _homeWidgetEntries = [Text('Test')];

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

  String dropdownValue = "Medium";
  CarFormInput newCarInput = new CarFormInput();

  showDeleteConfirmation(BuildContext context, int id) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: Colors.grey[600]),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        "Delete",
        style: TextStyle(color: Colors.red[500]),
      ),
      onPressed: () {
        deleteEntry(id);
        Navigator.pop(context);
        setState(() {
          _loadHomeEntries();
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text("Are you sure you want to permanently delete this item?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showHomeEditConfirmation(BuildContext context, int id, DateTime time) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Edit Entry"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text('Source'),
              ),
              Expanded(
                child: Text(
                  'Home Energy',
                  style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
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
                          deleteEntry(id);
                          addEntry(calculatedEmission, time, 'Home Energy');
                          setState(() {
                            _loadHomeEntries();
                          });
                          Navigator.pop(context);
                        },
                        child: Text('Save Changes',
                            style: TextStyle(
                                color: CustomMaterialColor.buttonColorWhite)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _loadHomeEntries() async {
    List<Widget> widgets = [];
    var currentEntries = await allEntries();
    for (int i = 0; i < currentEntries.length; i++) {
      if (getType(currentEntries[i].source_id) == 'Home Energy') {
        widgets.add(getLogWidget(
            currentEntries[i].id,
            getType(currentEntries[i].source_id),
            currentEntries[i].consumption,
            currentEntries[i].entry_date));
      }
    }
    setState(() {
      _homeWidgetEntries = widgets;
    });
  }

  Widget getLogWidget(int id, String source, int consumption, DateTime time) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300],
            width: 0.5,
          ),
        ),
      ),
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.home,
              color: Colors.grey[800],
            ),
          ),
          getLogDivider(),
          getLogTextBody(source, consumption, time),
          getLogDivider(),
          Container(
            width: 20.0,
            alignment: Alignment.center,
            child: PopupMenuButton(
              itemBuilder: (context) {
                var list = List<PopupMenuEntry<Object>>();
                list.add(
                  PopupMenuItem(
                    child: Container(
                      width: 70.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.create,
                            size: 18,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Edit',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    value: 1,
                  ),
                );
                list.add(
                  PopupMenuItem(
                    child: Container(
                      width: 70.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.delete,
                            size: 18,
                            color: Colors.red[500],
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Delete',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                    value: 2,
                  ),
                );
                return list;
              },
              onSelected: (value) {
                if (value == 1) {
                  showHomeEditConfirmation(context, id, time);
                } else {
                  showDeleteConfirmation(context, id);
                }
              },
              icon: Container(
                width: 4.0,
                child: Icon(
                  Icons.more_vert,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
          /*
        Icon(
          Icons.more_vert,
          color: Colors.grey[800],
        ),
        */
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadHomeEntries();
    });
    //_controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    //_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.30,
        minChildSize: 0.30,
        builder: (context, scrollController) {
          return Container(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: ListView(
                padding: EdgeInsets.all(20.0),
                controller: scrollController,
                children: _homeWidgetEntries,
              ),
            ),
          );
        });
  }
}
