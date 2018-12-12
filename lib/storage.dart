///
/// Let me WICHTEL that for you!
/// An application by nehegeb.
///
/// This file contains all data-storing stuff.
///

import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LmwtfyStorage {
  
  ///
  /// STORAGE | File path.
  ///

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/lmwtfy.txt');
  }

  ///
  /// STORAGE | Saving data.
  ///

  Future<File> saveJson(String json) async {
    final file = await _localFile;

    // Write the JOSN to the file.
    return file.writeAsString('$json');
  }

  ///
  /// STORAGE | Loading data.
  ///

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
