import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();
  String _result = '';

  void _calculate(bool isAddition) {
    try {
      final RegExp validNumberRegExp = RegExp(r'^-?\d*\.?\d+\$');

      if (!validNumberRegExp.hasMatch(_num1Controller.text) &&
          _num1Controller.text.isNotEmpty) {
        setState(() {
          _result = 'Invalid input for Number 1';
        });
        return;
      }

      if (!validNumberRegExp.hasMatch(_num2Controller.text) &&
          _num2Controller.text.isNotEmpty) {
        setState(() {
          _result = 'Invalid input for Number 2';
        });
        return;
      }

      double num1 = double.tryParse(_num1Controller.text) ?? 0;
      double num2 = double.tryParse(_num2Controller.text) ?? 0;

      double result = isAddition ? (num1 + num2) : (num1 - num2);

      setState(() {
        _result = 'Result: ${result.toStringAsPrecision(10)}';
      });
    } catch (e) {
      setState(() {
        _result = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Precision Calculator')),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.blue.shade800],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "High Precision Calculator",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildInputField(
                    controller: _num1Controller,
                    label: 'Number 1',
                    icon: Icons.confirmation_num,
                  ),
                  const SizedBox(height: 15),
                  _buildInputField(
                    controller: _num2Controller,
                    label: 'Number 2',
                    icon: Icons.confirmation_num_outlined,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildIconButton(
                        icon: Icons.add,
                        color1: Colors.green.shade400,
                        color2: Colors.green.shade700,
                        onPressed: () => _calculate(true),
                      ),
                      const SizedBox(width: 20),
                      _buildIconButton(
                        icon: Icons.remove,
                        color1: Colors.red.shade400,
                        color2: Colors.red.shade700,
                        onPressed: () => _calculate(false),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (_result.isNotEmpty)
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: _result.isNotEmpty ? 1.0 : 0.0,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: Colors.blue.shade200, width: 1),
                        ),
                        width: double.infinity,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            _result,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      keyboardType:
          TextInputType.numberWithOptions(decimal: true, signed: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[-0-9.]')),
      ],
      style: const TextStyle(fontSize: 16),
      maxLines: 1,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blue),
        labelText: label,
        hintText: 'Enter a number',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.blue.shade50,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required Color color1,
    required Color color2,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [color1, color2]),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color1.withOpacity(0.5),
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 30),
      ),
    );
  }
}
