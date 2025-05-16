import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for input formatters

class TimeConversionPage extends StatefulWidget {
  const TimeConversionPage({super.key});

  @override
  _TimeConversionPageState createState() => _TimeConversionPageState();
}

class _TimeConversionPageState extends State<TimeConversionPage> {
  final TextEditingController _yearController = TextEditingController();
  String _result = "";

  void _convertTime() {
    // Get the value entered by the user and replace any commas with periods
    String inputText = _yearController.text.replaceAll(',', '.');
    double years = double.tryParse(inputText) ?? 0;

    // Convert years to seconds, minutes, and hours
    double seconds = years * 365.25 * 24 * 60 * 60;  // Approximate calculation
    double minutes = seconds / 60;
    double hours = minutes / 60;

    setState(() {
      _result = "Years: $years\n"
          "Seconds: ${seconds.toStringAsFixed(0)}\n"
          "Minutes: ${minutes.toStringAsFixed(0)}\n"
          "Hours: ${hours.toStringAsFixed(0)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Konversi Waktu"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Masukkan jumlah tahun untuk konversi:",
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: _yearController,
              keyboardType: TextInputType.number, 
              inputFormatters: [
                LengthLimitingTextInputFormatter(10), 
              ],
              decoration: const InputDecoration(
                labelText: "Tahun",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                if (value.contains(',')) {
                  _yearController.text = value.replaceAll(',', '.');
                  _yearController.selection = TextSelection.collapsed(offset: _yearController.text.length);
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String inputText = _yearController.text.replaceAll(',', '.');
                if (inputText.isEmpty || double.tryParse(inputText) == null) {
                  setState(() {
                    _result = "Input tidak valid. Masukkan angka yang benar.";
                  });
                  return;
                }
                _convertTime();
              },
              child: const Text("Konversi"),
            ),
            const SizedBox(height: 20),
            if (_result.isNotEmpty) ...[
              const Text(
                "Hasil Konversi:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                _result,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
