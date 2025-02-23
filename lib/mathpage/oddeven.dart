import 'package:flutter/material.dart';

class OddEvenPage extends StatefulWidget {
  const OddEvenPage({super.key});

  @override
  _OddEvenPageState createState() => _OddEvenPageState();
}

class _OddEvenPageState extends State<OddEvenPage> {
  TextEditingController _numberController = TextEditingController();
  String _result = "";

  void _checkOddEven() {
    setState(() {
      int number = int.tryParse(_numberController.text) ?? 0;
      _result = (number % 2 == 0) ? "Even" : "Odd";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Odd or Even")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Enter a number"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkOddEven,
              child: const Text("Check"),
            ),
            const SizedBox(height: 20),
            Text(
              "Result: $_result",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
