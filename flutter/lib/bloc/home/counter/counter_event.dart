import 'package:equatable/equatable.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

class CounterIncrement extends CounterEvent {
  final int value;

  const CounterIncrement(this.value);

  @override
  List<Object> get props => [value];

  @override
  String toString() => 'CounterIncrement { value: $value }';
}

class CounterDecrement extends CounterEvent {
  final int value;

  const CounterDecrement(this.value);

  @override
  List<Object> get props => [value];

  @override
  String toString() => 'CounterDecrement { value: $value }';
}
