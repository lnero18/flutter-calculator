import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator by [Your Name]',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Simple Calculator by [Your Name]'),
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
  final TextEditingController _controller = TextEditingController();
  String _expression = '';

  void _onPressed(String text) {
    setState(() {
      if (text == 'C') {
        _expression = '';
      } else if (text == '=') {
        try {
          final expression = Expression.parse(_expression);
          final evaluator = const ExpressionEvaluator();
          final result = evaluator.eval(expression, {});
          _expression = result.toString();
        } catch (e) {
          _expression = 'Error';
        }
      } else {
        _expression += text;
      }
      _controller.text = _expression;
    });
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => _onPressed(text),
        child: Text(text, style: const TextStyle(fontSize: 24)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _controller,
            readOnly: true,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 48),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: ['7', '8', '9', '/'].map(_buildButton).toList(),
                ),
                Row(
                  children: ['4', '5', '6', '*'].map(_buildButton).toList(),
                ),
                Row(
                  children: ['1', '2', '3', '-'].map(_buildButton).toList(),
                ),
                Row(
                  children: ['0', 'C', '=', '+'].map(_buildButton).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
