/**
 * Let me WICHTEL that for you!
 * An application by nehegeb.
 */

import 'package:flutter/material.dart';

class EventsListing extends StatefulWidget {
  @override
  _EventsListingState createState() => _EventsListingState();
}

class _EventsListingState extends State<EventsListing> {
  int _counter = 0;

  // TODO: All the code below is still from the "new project" and has to change.

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Let me WICHTEL that for you!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}