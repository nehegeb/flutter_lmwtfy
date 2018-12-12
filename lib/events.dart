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

  void _deleteEvent() {}

  // LAYOUT

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WICHTEL events'),
      ),
      body: _buildListing(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEvent,
        tooltip: 'Add new event',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildListing() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: (_testString.length * 2) - 1,
      itemBuilder: (context, i) {
        // Add a devider after each entry...
        if (i.isOdd) return Divider();
        // ...nonetheless make sure, all entrys are being used.
        final index = i ~/ 2;

        return _buildListingEntry(_testString[index]);
      },
    );
  }

  Widget _buildListingEntry(String value) {
    return ListTile(
      title: Text('$value'),
    );
  }
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

// ************
// *** DATA ***
// ************

class EventsData {
  // Events data.
  final int eventId;
  final String eventTitle;
  final String eventDate;

  // Participant data.
  final int participantId;
  final String participantName;

  EventsData(this.eventId, this.eventTitle, this.eventDate, this.participantId,
      this.participantName);

  // Encode data from JSON.
  EventsData.fromJson(Map<String, dynamic> json)
      : eventId = json['id'],
        eventTitle = json['title'],
        eventDate = json['date'],
        participantId = json['id'],
        participantName = json['name'];

  // Decode data back to JSON format.
  Map<String, dynamic> toJson() => {
        'events': [
          {
            'id': eventId,
            'title': eventTitle,
            'date': eventDate,
            'participants': [
              {
                'id': participantId,
                'name': participantName,
              }
            ]
          }
        ]
      };
}

/* Final JSON structure with types and comments.
    {
      'events': [{
        'id': int - ID of the event,
        'title': String - Name of the event,
        'date': String - Date of the event,
        'isCalculated': bool - The event has been calculated,
        'participants': [{
          'id': int - ID of the participant,
          'name': String - Name of the participant,
          'phone': String - The participants phone number for SMS or messengers,
          'willGift': int - The ID of the participant this one will gift something,
          'wontGift': ['id': int - All the IDs of other participants this one won't gift anything]
        }]
      }]
    }
*/
