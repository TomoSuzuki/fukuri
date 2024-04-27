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
  List<String> fruits = ['りんご', 'ぶどう', 'みかん'];

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

  final List<String> _fruitNames = [
    'Apple',
    'Mango',
    'Banana',
    'Orange',
    'Pineapple',
    'Strawberry',
  ];
  final double _kItemExtent = 32.0;

  int _selectedFruit = 0;

  // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoPicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
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
            CupertinoButton(
              padding: EdgeInsets.zero,
              // Display a CupertinoPicker with list of fruits.
              onPressed: () => _showDialog(
                CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: _kItemExtent,
                  // This sets the initial item.
                  scrollController: FixedExtentScrollController(
                    initialItem: _selectedFruit,
                  ),
                  // This is called when selected item is changed.
                  onSelectedItemChanged: (int selectedItem) {
                    setState(() {
                      _selectedFruit = selectedItem;
                    });
                  },
                  children:
                      List<Widget>.generate(_fruitNames.length, (int index) {
                    return Center(child: Text(_fruitNames[index]));
                  }),
                ),
              ),
              // This displays the selected fruit name.
              child: Text(
                _fruitNames[_selectedFruit],
                style: const TextStyle(
                  fontSize: 22.0,
                ),
              ),
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
