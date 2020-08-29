import 'dart:async';
import 'package:bloc/bloc.dart';
import 'counter.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  @override
  CounterState get initialState => CounterValue(0);

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is CounterDecrement) {
      yield CounterValue(event.value - 1);
    } else if (event is CounterIncrement) {
      yield CounterValue(event.value + 1);
    }
  }
}
