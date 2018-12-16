///
/// Let me WICHTEL that for you!
/// An application by nehegeb.
///
/// This file contains everything needed for the participants listing.
///

import 'package:flutter/material.dart';

import 'package:flutter_lmwtfy/commons.dart';
import 'package:flutter_lmwtfy/storage.dart';

class ParticipantsListing extends StatefulWidget {
  // Setting up the storage.
  final LmwtfyStorage storage;
  ParticipantsListing({Key key, @required this.storage}) : super(key: key);

  @override
  _ParticipantsListingState createState() => _ParticipantsListingState();
}

class _ParticipantsListingState extends State<ParticipantsListing> {
  
  ///
  /// LAYOUT
  ///

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WICHTEL'),
      ),
      body: Text('in development'),
    );
  }
}
