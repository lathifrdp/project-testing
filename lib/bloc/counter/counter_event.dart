part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent {}

class CounterRequest extends CounterEvent {
  final int initialCount;
  CounterRequest({this.initialCount = 0});
}

class CounterIncrementRequest extends CounterEvent {
  CounterIncrementRequest();
}

class CounterDecrementRequest extends CounterEvent {
  CounterDecrementRequest();
}

class CounterDisposeRequest extends CounterEvent {
  CounterDisposeRequest();
}
