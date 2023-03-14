import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  int initialCount = 0;
  BehaviorSubject<int> _subjectCounter = BehaviorSubject<int>();

  Stream<int> get counterObservable {
    return _subjectCounter.stream;
  }

  CounterBloc() : super(CounterInitial()) {
    on<CounterRequest>(_init);
    on<CounterIncrementRequest>(_increment);
    on<CounterDecrementRequest>(_decrement);
    on<CounterDisposeRequest>(_dispose);
  }

  void _init(CounterRequest event, Emitter<CounterState> emit) {
    _subjectCounter = BehaviorSubject<int>.seeded(event.initialCount);
    //_subjectCounter.sink.add(initialCount);
  }

  void _increment(CounterIncrementRequest event, Emitter<CounterState> emit) {
    initialCount++;
    _subjectCounter.sink.add(initialCount);
    emit(Increment());
  }

  void _decrement(CounterDecrementRequest event, Emitter<CounterState> emit) {
    initialCount--;
    _subjectCounter.sink.add(initialCount);
    emit(Decrement());
  }

  void _dispose(CounterDisposeRequest event, Emitter<CounterState> emit) {
    _subjectCounter.close();
    emit(Dispose());
  }
}
