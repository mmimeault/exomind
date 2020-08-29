import 'package:equatable/equatable.dart';

abstract class CounterState extends Equatable {
  const CounterState();

  @override
  List<Object> get props => [];
}

class CounterValue extends CounterState {
  final int value;

  const CounterValue(this.value);

  @override
  List<Object> get props => [value];

  @override
  String toString() => 'CounterValue { value: $value }';
}
