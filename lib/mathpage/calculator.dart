import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();
  String _result = "";
  String? _errorText;

  void _calculate(String operation) {
    setState(() {
      String input1 = _num1Controller.text.trim();
      String input2 = _num2Controller.text.trim();

      if (input1.isEmpty || input2.isEmpty) {
        _errorText = "Please enter both numbers";
        _result = "";
        return;
      }

      double? num1 = double.tryParse(input1);
      double? num2 = double.tryParse(input2);

      if (num1 == null || num2 == null) {
        _errorText = "Invalid number";
        _result = "";
        return;
      }

      _errorText = null;

      if (operation == "+") {
        _result = "Result: ${num1 + num2}";
      } else if (operation == "-") {
        _result = "Result: ${num1 - num2}";
      }
    });
  }

  void _reset() {
    setState(() {
      _num1Controller.clear();
      _num2Controller.clear();
      _result = "";
      _errorText = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _num1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter first number",
                errorText: _errorText,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _num2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter second number",
                errorText: _errorText,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () => _calculate("+"), child: const Text("+")),
                ElevatedButton(
                    onPressed: () => _calculate("-"), child: const Text("-")),
                ElevatedButton(
                  onPressed: _reset,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Reset"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
