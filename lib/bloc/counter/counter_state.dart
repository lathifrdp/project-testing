part of 'counter_bloc.dart';

@immutable
abstract class CounterState {}

class CounterInitial extends CounterState {}

class Increment extends CounterState {}

class Decrement extends CounterState {}

class Dispose extends CounterState {}

class CounterError extends CounterState {}
