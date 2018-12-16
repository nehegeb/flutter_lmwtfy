///
/// Let me WICHTEL that for you!
/// An application by nehegeb.
///
/// This file starts the app with an initial spash screen.
///

import 'package:flutter/material.dart';

import 'package:flutter_lmwtfy/app_events.dart';
// import 'package:flutter_lmwtfy/localization.dart';
import 'package:flutter_lmwtfy/storage.dart';

class LmwtfyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LMWTFY',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SplashScreen(),
      //home: EventsListing(storage: LmwtfyStorage()),

/*
      //onGenerateTitle: (BuildContext context) => LmgtfyLocalization.of(context).title,
      localizationsDelegates: [
        const LmgtfyLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('de', ''),
      ],
*/
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  ///
  /// FUNCTIONS
  ///

  void _startLmwtfy() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            EventsListing(storage: LmwtfyStorage())));
  }

  ///
  /// LAYOUT
  ///

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(LmgtfyLocalization.of(context).test),
            RaisedButton(
              child: Text('Let me WICHTEL that for you!'),
              onPressed: () {
                _startLmwtfy();
              },
            ),
          ],
        ),
      ),
    );
  }

}
