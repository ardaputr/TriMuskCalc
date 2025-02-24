import 'package:flutter/material.dart';

class SumNumberPage extends StatefulWidget {
  const SumNumberPage({super.key});

  @override
  _SumNumberPageState createState() => _SumNumberPageState();
}

class _SumNumberPageState extends State<SumNumberPage> {
  final TextEditingController _inputController = TextEditingController();
  double _sum = 0.0;
  bool _hasResult = false;

  void _calculateSum() {
    String inputText = _inputController.text;

    if (inputText.isEmpty) {
      setState(() {
        _sum = 0.0;
        _hasResult = false;
      });
      return;
    }

    try {
      List<double> numbers = inputText
          .split(RegExp(r'[\s,]+'))
          .where((element) => element.isNotEmpty)
          .map((num) => double.parse(num))
          .toList();

      setState(() {
        _sum = numbers.fold(0.0, (prev, num) => prev + num);
        _hasResult = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Harap masukkan angka yang valid")),
      );
    }
  }

  String _formatSum() {
    if (_sum % 1 == 0) {
      return _sum.toInt().toString();
    } else {
      return _sum.toString();
    }
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text("Sum Number"),
        ),
        backgroundColor: Colors.white,
        elevation: 5,
      ),
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Input Number",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildInputField(
                    controller: _inputController,
                    label: "Example: 10,20,30",
                    icon: Icons.numbers,
                  ),
                  const SizedBox(height: 20),
                  _buildGradientButton(
                    text: "Total",
                    icon: Icons.calculate,
                    color1: Colors.blueAccent,
                    color2: Colors.blue,
                    onPressed: _calculateSum,
                  ),
                  const SizedBox(height: 20),
                  if (_hasResult)
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: _hasResult ? 1.0 : 0.0,
                      child: Text(
                        "Total: ${_formatSum()}",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 34, 179, 111),
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
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blue),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.purple.shade50,
      ),
    );
  }

  Widget _buildGradientButton({
    required String text,
    required IconData icon,
    required Color color1,
    required Color color2,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
