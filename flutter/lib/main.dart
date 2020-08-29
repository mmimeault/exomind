import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc/home/home.dart';
import 'UI/config/config.dart';
import 'UI/pages/pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => FlutterBlocLocalizations.of(context).appTitle,
      theme: MainTheme.light,
      darkTheme: MainTheme.dark,
      localizationsDelegates: [
        FlutterBlocLocalizationsDelegate(),
      ],
      routes: {
        Routes.landing.name: (context) {
          return LandingPage();
        },
        Routes.home.name: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<CounterBloc>(
                create: (context) => CounterBloc(),
              ),
            ],
            child: MultiProvider(
              providers: [
                Provider<Assets>(
                  create: (context) => Assets(context),
                ),
              ],
              child: HomePage(),
            ),
          );
        },
      },
    );
  }
}
