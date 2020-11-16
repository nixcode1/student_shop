// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
class Counter with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Counter(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Example'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('You have pushed the button this many times:'),

              /// Extracted as a separate widget for performance optimization.
              /// As a separate widget, it will rebuild independently from [MyHomePage].
              ///
              /// This is totally optional (and rarely needed).
              /// Similarly, we could also use [Consumer] or [Selector].
              const Count(),
              const Button()
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          /// Calls `context.read` instead of `context.watch` so that it does not rebuild
          /// when [Counter] changes.
          onPressed: () => context.read<Counter>().increment(),
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Count extends StatelessWidget {
  const Count({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(

        /// Calls `context.watch` to make [MyHomePage] rebuild when [Counter] changes.
        '${context.watch<Counter>().count}',
        style: Theme.of(context).textTheme.headline4);
  }
}

class Button extends StatelessWidget {
  const Button({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => context.read<Counter>().increment(),
    );
  }
}
