///
/// Let me WICHTEL that for you!
/// An application by nehegeb.
///

import 'package:flutter/material.dart';

import 'events.dart';
// import 'localization.dart';
import 'storage.dart';

class LmwtfyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LMWTFY',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      //home: SplashScreen(),
      home: EventsListing(storage: LmwtfyStorage()),

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
            // Text(LmgtfyLocalization.of(context).test),
            RaisedButton(
              child: Text('WELCOME'),
              onPressed: () {
                // TODO: Go to EventsListing.
                print('Welcome has been pressed.');
              },
            ),
          ],
        ),
      ),
    );
  }
}
