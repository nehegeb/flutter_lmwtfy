/**
 * Let me WICHTEL that for you!
 * An application by nehegeb.
 */

import 'package:flutter/material.dart';

// import 'package:flutter_lmwtfy/localization.dart';

class LmwtfyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LMWTFY',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SplashScreen(),
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
