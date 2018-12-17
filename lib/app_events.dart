///
/// Let me WICHTEL that for you!
/// An application by nehegeb.
///
/// This file contains everything needed for the events listing.
///

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_lmwtfy/app_participants.dart';
import 'package:flutter_lmwtfy/commons.dart';
import 'package:flutter_lmwtfy/storage.dart';

class EventsListing extends StatefulWidget {
  // Setting up the storage.
  final LmwtfyStorage storage;
  EventsListing({Key key, @required this.storage}) : super(key: key);

  @override
  _EventsListingState createState() => _EventsListingState();
}

class _EventsListingState extends State<EventsListing> {
  String _testString;
  Map<String,dynamic> _lmwtfyDb;

  ///
  /// INITIALIZATION
  ///

  @override
  void initState() {
    super.initState();

    _lmwtfyDb = LmwtfyData.newLmwtfy();

    widget.storage.loadJson().then((String value) {
      setState(() {
        _testString = value;
      });
    });
  }

  ///
  /// FUNCTIONS | Add new event.
  ///

  void _addEvent() {
    // Get data for a new event entry.
    Map<String, dynamic> _newEvent = EventData.newEvent();

    // Open a dialog for user entry.
    showDialog(
      context: context,
      builder: (context) => _eventSettingsDialog(context, _newEvent),
    );
  }

  Future<File> _saveEvent(Map<String, dynamic> event) async {

    // Make sure, LMWTFY database already exists.
    if (_lmwtfyDb == null) {
      _lmwtfyDb = LmwtfyData.newLmwtfy();
    }

    // Update the display with the new event.
    setState(() {
      _testString = event['title'];
      // Add the new event to LMWTFY database.
      event['eventId'] = _nextEventId();
      _lmwtfyDb['events'].add(event);
    });

    // Save the LMWTFY database to the storage file.
    //return widget.storage.saveJson(LmwtfyData.toJson(_lmwtfyData));
    return widget.storage.saveJson(_testString);
  }

  int _nextEventId() {
    int _highestId = -1;

    // Check all used event IDs and return the highest one +1.
    for (var event in _lmwtfyDb['events']) {
      _highestId = _highestId > event['eventId'] ? _highestId : event['eventId'];
    }
    return ++_highestId;
  }

  ///
  /// FUNCTIONS | Delete event.
  ///

  Map<String,dynamic> _deletedEventBackup;

  void _deleteEvent(int index) {
    // Back up the event for _deleteEventUndo().
    _deletedEventBackup = _lmwtfyDb['events'][index];

    // Afterwards delete the event.
    _lmwtfyDb['events'].removeAt(index);
  }

  void _deleteEventUndo() {
    // Undo the deletion of the last event.
    // This is only possible for the last event, and only if it has been deleted during the current app session.
      _deletedEventBackup['eventId'] = _nextEventId();
      _lmwtfyDb['events'].add(_deletedEventBackup);
  }

  ///
  /// FUNCTIONS | Open event.
  ///

  void _openEvent() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            ParticipantsListing(storage: LmwtfyStorage())));
  }

  ///
  /// LAYOUT
  ///

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_lmwtfyDb['events'].length} WICHTEL events'),
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
      //padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: (_lmwtfyDb['events'].length * 2) - 1,
      itemBuilder: (context, i) {
        // Add a devider after each entry...
        if (i.isOdd) return Divider();
        // ...nonetheless make sure, all entrys are being used.
        final index = i ~/ 2;

        final Map<String, dynamic> event = _lmwtfyDb['events'][index];

        // For editing maybe: https://stackoverflow.com/questions/52478469/flutter-disable-dismiss-direction-on-dismissable-widget
        // A dismissible removes an entry from the list by swiping.
        return Dismissible(
          key: Key(event['eventId'].toString()),
          // Swipe to the left to delete the entry.
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            // Delete the swiped event.
            setState(() {
              // Remove the event from the lsting.
              event.remove(event['eventId'].toString());
              // Remove the event from the LMWTFY database.
              _deleteEvent(index);
            });
            // Afterwards display a snackbar for visual feedback.
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('${event['title']} deleted'),
              action: SnackBarAction(
                label: 'UNDO',
                onPressed: () {
                  setState(() {
                    _deleteEventUndo();
                  });
                },
              ),
            ));
          },
          background: dismissibleBackgroundForDelete(),
          child: _buildListingEntry(event),
        );
      },
    );
  }

  Widget _buildListingEntry(Map<String, dynamic> event) {
    return ListTile(
      title: Text('${event['title']} (${event['eventId']})'),
      onTap: () {
        _openEvent();
      },
    );
  }

  Widget _eventSettingsDialog(BuildContext context, Map event) {
    final _titleController = TextEditingController();
    final _dateController = TextEditingController();

    _titleController.text = event['title'];
    _dateController.text = event['date'];

    /*
    @override dispose() {
      _titleController.dispose();
      _dateController.dispose();
      super.dispose();
    }
    */

    const double _padding = 20.0;

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Card(
          margin: EdgeInsets.symmetric(horizontal: _padding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Settings above.
              Container(
                padding: EdgeInsets.fromLTRB(_padding, _padding, _padding, 0.0),
                child: Column(
                  children: <Widget>[
                    // Title of the Dialog.
                    Text('Add new event'),
                    // Event title.
                    TextField(
                      controller: _titleController,
                      //autofocus: true,
                      decoration: InputDecoration(
                        labelText: 'Event title',
                      ),
                      onEditingComplete: () {
                        // Save the new title for the event.
                        event['title'] = _titleController.text;
                      },
                    ),
                    // Event date.
                    TextField(
                      controller: _dateController,
                      decoration: InputDecoration(
                        labelText: 'Date of the event',
                      ),
                      onEditingComplete: () {
                        // Save the new date for the event.
                        event['data'] = _dateController.text;
                      },
                    ),
                  ],
                ),
              ),

              // Buttons below.
              ButtonTheme.bar(
                child: ButtonBar(
                  alignment: MainAxisAlignment.end,
                  children: <Widget>[
                    // Cancel button.
                    FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('CANCEL'),
                    ),
                    // Accept button.
                    RaisedButton(
                      onPressed: () {
                        _saveEvent(event);
                        Navigator.pop(context);
                      },
                      child: Text('ADD'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}
