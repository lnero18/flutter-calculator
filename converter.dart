import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Currency Converter'),
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
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  String _sourceCurrency = 'USD';
  String _targetCurrency = 'EUR';

  final Map<String, double> _exchangeRates = {
    'USD': 1.0,
    'EUR': 0.85,
    'GBP': 0.75,
    'JPY': 110.0,
  };

  void _convertCurrency() {
    double inputAmount = double.tryParse(_inputController.text) ?? 0.0;
    double sourceRate = _exchangeRates[_sourceCurrency]!;
    double targetRate = _exchangeRates[_targetCurrency]!;
    double outputAmount = (inputAmount / sourceRate) * targetRate;
    _outputController.text = outputAmount.toStringAsFixed(2);
  }

  void _clearFields() {
    _inputController.clear();
    _outputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount to Convert',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _sourceCurrency,
                  onChanged: (String? newValue) {
                    setState(() {
                      _sourceCurrency = newValue!;
                    });
                  },
                  items: _exchangeRates.keys
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const Icon(Icons.arrow_forward),
                DropdownButton<String>(
                  value: _targetCurrency,
                  onChanged: (String? newValue) {
                    setState(() {
                      _targetCurrency = newValue!;
                    });
                  },
                  items: _exchangeRates.keys
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _outputController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Converted Amount',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _convertCurrency,
                  child: const Text('Convert'),
                ),
                ElevatedButton(
                  onPressed: _clearFields,
                  child: const Text('Clear'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}