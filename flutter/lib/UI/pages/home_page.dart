import 'package:exomind/UI/config/config.dart';
import 'package:exomind/UI/widgets/widgets.dart';
import 'package:exomind/bloc/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState();

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Home ${FlutterBlocLocalizations.of(context).appTitle}"),
      ),
      body: Stack(
        children: [
          _buildCounterSection(),
        ],
      ),
    );
  }

  void _handleRoute(RouteName routeName) {}

  Widget _buildCounterSection() {
    return BlocBuilder<CounterBloc, CounterState>(
      builder: (context, counterState) {
        if (counterState is CounterValue) {
          return _buildCounterValueSection(counterState);
        } else {
          return Text("Error");
        }
      },
    );
  }

  Widget _buildCounterValueSection(CounterValue counterValue) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${counterValue.value}',
                style: TextStyle(fontSize: 24.0),
              ),
            ],
          ),
        ),
        BigButton(() {
          BlocProvider.of<CounterBloc>(context).add(CounterIncrement(counterValue.value));
        }, FlutterBlocLocalizations.of(context).increment),
        BigButton(() {
          BlocProvider.of<CounterBloc>(context).add(CounterDecrement(counterValue.value));
        }, FlutterBlocLocalizations.of(context).decrement),
      ],
    );
  }
}
