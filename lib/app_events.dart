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
  Map _events;

  ///
  /// INITIALIZATION
  ///

  @override
  void initState() {
    super.initState();
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
    Map<String, dynamic> _newEvent = newEvent();

    // Open a dialog for user entry.
    showDialog(
      context: context,
      builder: (context) => _eventSettingsDialog(context, _newEvent),
    );
  }

  Future<File> _saveEvent(Map<String, dynamic> event) async {
    setState(() {
      _testString = event['title'];
    });

    return widget.storage.saveJson(_testString);
  }

  ///
  /// FUNCTIONS | Delete event.
  ///

  String _deletedEventBackup;

  void _deleteEvent(int index) {
    // Back up the event for _deleteEventUndo().
    _deletedEventBackup = _testString[index];

    // Afterwards delete the event.
    _testString.replaceRange(index, index + 1, '');
    //_testString.removeAt(index);
  }

  void _deleteEventUndo() {
    // Undo the deletion of the last event.
    // This is only possible for the last event, and only if it has been deleted during the current app session.
    _testString = '$_testString$_deletedEventBackup';
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
      //padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: (_testString.length * 2) - 1,
      itemBuilder: (context, i) {
        // Add a devider after each entry...
        if (i.isOdd) return Divider();
        // ...nonetheless make sure, all entrys are being used.
        final index = i ~/ 2;

        final event = _testString[index];

        // For editing maybe: https://stackoverflow.com/questions/52478469/flutter-disable-dismiss-direction-on-dismissable-widget
        // A dismissible removes an entry from the list by swiping.
        return Dismissible(
          key: Key(event),
          // Swipe to the left to delete the entry.
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            // Delete the swiped event.
            setState(() {
              _deleteEvent(index);
            });
            // Afterwards display a snackbar for visual feedback.
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('$event deleted'),
              action: SnackBarAction(
                label: 'UNDO',
                onPressed: _deleteEventUndo,
              ),
            ));
          },
          background: dismissibleBackgroundForDelete(),
          child: _buildListingEntry(event),
        );
      },
    );
  }

  Widget _buildListingEntry(String event) {
    return ListTile(
      title: Text('$event'),
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
