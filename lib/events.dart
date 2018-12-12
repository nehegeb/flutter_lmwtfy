///
/// Let me WICHTEL that for you!
/// An application by nehegeb.
///
/// This file contains everything needed for the events listing.
///

import 'dart:io';

import 'package:flutter/material.dart';

import 'commons.dart';
import 'participants.dart';
import 'storage.dart';

class EventsListing extends StatefulWidget {
  // Setting up the storage.
  final LmwtfyStorage storage;
  EventsListing({Key key, @required this.storage}) : super(key: key);

  @override
  _EventsListingState createState() => _EventsListingState();
}

class _EventsListingState extends State<EventsListing> {
  String _testString;

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

  Future<File> _addEvent() async {
    setState(() {
      _testString = 'New event';
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
}
