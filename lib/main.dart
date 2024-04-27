import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'compound interest calculation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _start = 0;
  int _counter = 0;
  double _simpleinterest = 100;
  double _result = 100.0;
  String _disp = '100.0';

  void _incrementCounter() {
    setState(() {
      _counter++;
      _simpleinterest = _simpleinterest + 5.0;
      _result = _result * 1.05;
      _disp = _result.toStringAsFixed(1);
    });
  }

  void _pickerInput(selectedItem) {
    setState(() {
      _start = selectedItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'amount at start :',
            ),
            Text(
              '$_start',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text(
              'nunber of count :',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text(
              'simple interest 5% :',
            ),
            Text(
              '\$ $_simpleinterest',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text(
              'result of compound interest calculation 5%:',
            ),
            Text(
              '\$ $_disp',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              child: const Text('Pickerを表示！'),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        child: CupertinoPicker(
                          onSelectedItemChanged: (int selectedItem) {
                            debugPrint('selected debugPrint $selectedItem');
                            _pickerInput(selectedItem);
                          },
                          itemExtent: 30,
                          children: const [
                            Text('0'),
                            Text('100'),
                            Text('200'),
                            Text('300')
                          ],
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
