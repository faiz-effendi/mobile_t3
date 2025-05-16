import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For input formatters

class JenisBilanganPage extends StatefulWidget {
  const JenisBilanganPage({super.key});

  @override
  _JenisBilanganPageState createState() => _JenisBilanganPageState();
}

class _JenisBilanganPageState extends State<JenisBilanganPage> {
  final TextEditingController _numberController = TextEditingController();
  String _result = "";

  // Fungsi mengecek angka prima
  bool isPrima(int number) {
    if (number <= 1) return false;
    for (int i = 2; i <= number ~/ 2; i++) {
      if (number % i == 0) return false;
    }
    return true;
  }

  bool isPositive(double number) => number > 0;
  bool isNegative(double number) => number < 0;
  bool isZero(double number) => number == 0;
  bool isBulat(double number) => number == number.toInt();
  bool isCacah(double number) => number >= 0 && number == number.toInt();
  double? parseNumber(String input) {
    String processedInput = input.replaceAll(',', '.');
    final validNumberRegExp = RegExp(r'^-?\d+(\.\d+)?$');
    if (!validNumberRegExp.hasMatch(processedInput)) return null;
    return double.tryParse(processedInput);
  }

  // Menentukan jenis bilangan berdasarkan input
  void _checkNumberType() {
    String rawInput = _numberController.text.trim();
    if (rawInput.isEmpty) {
      setState(() {
        _result = "Masukkan sebuah angka";
      });
      return;
    }

    double? inputNumber = parseNumber(rawInput);
    if (inputNumber == null) {
      setState(() {
        _result = "Input tidak valid. Masukkan angka yang benar (contoh: -5, 3.14, 0)";
      });
      return;
    }

    String signType = '';
    if (isPositive(inputNumber)) {
      signType = 'Positif';
    } else if (isNegative(inputNumber)) {
      signType = 'Negatif';
    } else {
      signType = 'Nol';
    }

    String result = '';
    if (isBulat(inputNumber)) {
      int intNumber = inputNumber.toInt();
      result = 'Angka ini adalah Bulat $signType: $intNumber';
      if (isPrima(intNumber) && intNumber > 0) {
        result += "\nAngka ini adalah Bilangan Prima!";
      }
      if (isCacah(inputNumber)) {
        result += "\nAngka ini juga termasuk Cacah!";
      }
    } else {
      result = 'Angka ini adalah Desimal $signType: $inputNumber';
    }

    setState(() {
      _result = result.trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menampilkan Jenis Bilangan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Masukkan sebuah angka untuk mengetahui jenisnya:",
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: const InputDecoration(
                labelText: "Angka",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkNumberType,
              child: const Text("Cek Jenis Bilangan"),
            ),
            const SizedBox(height: 20),
            if (_result.isNotEmpty) ...[
              const Text(
                "Hasil Jenis Bilangan:",
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
