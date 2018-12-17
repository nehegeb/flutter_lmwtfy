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

// ***********************
// *** DATA MANAGEMENT ***
// ***********************

class LmwtfyData {
  // All LMWTFY data.
  final List events;

  LmwtfyData(this.events);

  // Encode data from JSON.
  LmwtfyData.fromJson(Map<String, dynamic> json) : events = json['events'];

  // Decode data back to JSON format.
  Map<String, dynamic> toJson() =>
    {
      'events': events,
    };

  // Create the basics from scratch.
  static Map<String, dynamic> newLmwtfy() =>
    {
      'events': []
    };

}

class EventData {

  // Create a new event from scratch.
  static Map<String, dynamic> newEvent() =>
    {
      'eventId': 0,
      'title': 'New event',
      'date': 'today',
      'isCalculated': false,
      'participants': []
    };

}

/*
class EventData {
  // Main data of one event.
  final int id;
  final String eventTitle;
  final String eventDate;
  final List participants;

  EventData(this.id, this.eventTitle, this.eventDate, this.participants);

  // Encode data from JSON.
  EventData.fromJson(Map<String, dynamic> json)
      : id = json['eventId'],
        eventTitle = json['title'],
        eventDate = json['date'],
        participants = json['participants'];

  // Decode data back to JSON format.
  Map<String, dynamic> toJson() => {
        'eventId': id,
        'title': eventTitle,
        'date': eventDate,
        'participants': []
      };

}
*/

class ParticipantData {
  // Main data of one participant.
  final int id;
  final String name;
  final String phone;
  final int willGift;
  final List wontGift;

  ParticipantData(this.id, this.name, this.phone, this.willGift, this.wontGift);

  // Encode data from JSON.
  ParticipantData.fromJson(Map<String, dynamic> json)
      : id = json['participantsId'],
        name = json['name'],
        phone = json['phone'],
        willGift = json['willGift'],
        wontGift = json['wontGift'];

  // Decode data back to JSON format.
  Map<String, dynamic> toJson() => {
        'participantsId': id,
        'name': name,
        'phone': phone,
        'willGift': willGift,
        'wontGift': []
      };
}

class ParticipantWontGiftData {
  // A list of participants, this one will not gift anything.
  final List participantIds;

  ParticipantWontGiftData(this.participantIds);

  // Encode data from JSON.
  ParticipantWontGiftData.fromJson(Map<String, dynamic> json)
      : participantIds = json['wontGift'];

  // Decode data back to JSON format.
  Map<String, dynamic> toJson() => {
        'wontGift': participantIds,
      };
}

/* Final JSON structure with types and comments.
    {
      'events': [{
        'eventId': int - ID of the event,
        'title': String - Name of the event,
        'date': String - Date of the event,
        'isCalculated': bool - The event has been calculated,
        'participants': [{
          'participantId': int - ID of the participant,
          'name': String - Name of the participant,
          'phone': String - The participants phone number for SMS or messengers,
          'willGift': int - The ID of the participant this one will gift something,
          'wontGift': ['participantId': int - All the IDs of other participants this one won't gift anything]
        }]
      }]
    }
*/
