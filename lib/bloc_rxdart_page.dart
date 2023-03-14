import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_testing/bloc/counter/counter_bloc.dart';

class BlocRxdartPage extends StatefulWidget {
  const BlocRxdartPage({super.key});

  @override
  State<BlocRxdartPage> createState() => _BlocRxdartPageState();
}

class _BlocRxdartPageState extends State<BlocRxdartPage> {
  CounterBloc counterBloc = CounterBloc();
  bool isStream = false;

  @override
  void initState() {
    setState(() {
      counterBloc.add(CounterRequest());
      super.initState();
    });
    super.initState();
  }

  @override
  void dispose() {
    counterBloc.add(CounterDisposeRequest());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bloc RxDart")),
      body: SafeArea(
        child: Center(
          child: StreamBuilder<int>(
              stream: counterBloc.counterObservable,
              builder: (context, snapshot) {
                return BlocBuilder(
                  bloc: counterBloc,
                  builder: (context, state) {
                    return Text(
                      "${snapshot.data ?? 0}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    );
                  },
                );
              }),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "increment",
            child: const Icon(Icons.add),
            onPressed: () {
              counterBloc.add(CounterIncrementRequest());
              if (isStream == false) {
                isStream = true;
                setState(() {});
              }
            },
          ),
          const SizedBox(
            height: 16.0,
          ),
          FloatingActionButton(
            heroTag: "decrement",
            child: const Icon(Icons.remove),
            onPressed: () {
              counterBloc.add(CounterDecrementRequest());
              if (isStream == false) {
                isStream = true;
                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }
}
