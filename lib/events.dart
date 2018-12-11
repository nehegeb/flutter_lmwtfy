/**
 * Let me WICHTEL that for you!
 * An application by nehegeb.
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class EventsListing extends StatefulWidget {
  // Setting up the storage.
  final EventsStorage storage;
  EventsListing({Key key, @required this.storage}) : super(key: key);

  @override
  _EventsListingState createState() => _EventsListingState();
}

class _EventsListingState extends State<EventsListing> {
  String _testString;

  // INITIALIZATION

  @override
  void initState() {
    super.initState();
    widget.storage.loadJson().then((String value) {
      setState(() {
        _testString = value;
      });
    });
  }

  // FUNCTIONS

  Future<File> _addEvent() async {
    setState(() {
      _testString = 'New event';
    });

    return widget.storage.saveJson(_testString);
  }

  // LAYOUT

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WICHTEL events'),
      ),
      body: _testing(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEvent,
        tooltip: 'Add new event',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _testing() {
    return Column(children: <Widget>[
      Text('abcd'),
      Text('$_testString'),
    ]);
  }

/*
  Widget _buildListing() {
    return new ListView.builder(itemBuilder: (context, i) {
      if (i.isOdd) return new Divider(); 
      
      

    });
  }
*/

}

// ***************
// *** STORAGE ***
// ***************

class EventsStorage {

  // STORAGE | File path.

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/events.txt');
  }

  // STORAGE | Saving data.

  Future<File> saveJson(String json) async {
    final file = await _localFile;

    // Write the JOSN to the file.
    return file.writeAsString('$json');
  }

  // STORAGE | Loading data.
  
  Future<String> loadJson() async {
    try {
      final file = await _localFile;

      // Read the JSON from the file.
      String json = await file.readAsString();

      return json;
    } catch (e) {
      // An error occured.
      return 'ERROR';
    }
  }

}
