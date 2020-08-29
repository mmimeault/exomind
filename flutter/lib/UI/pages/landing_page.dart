import 'package:exomind/UI/config/config.dart';
import 'package:exomind/UI/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  void _startApp(BuildContext context) async {
    Navigator.pushNamed(context, Routes.home.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Landing ${FlutterBlocLocalizations.of(context).appTitle}"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Try to hit that big button...',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            BigButton(() {
              _startApp(context);
            }, FlutterBlocLocalizations.of(context).launchApp),
          ],
        ),
      ),
    );
  }
}
