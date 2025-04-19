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

  // Function to check if the number is prime (only for integers)
  bool isPrime(int number) {
    if (number <= 1) {
      return false;
    }
    for (int i = 2; i <= number / 2; i++) {
      if (number % i == 0) {
        return false;
      }
    }
    return true;
  }

  // Function to check if the number is positive or negative
  String positiveOrNegative(double number) {
    if (number > 0) {
      return 'Bulat Positif';
    } else if (number < 0) {
      return 'Bulat Negatif';
    } else {
      return 'Nol (Bukan Positif atau Negatif)';
    }
  }

  // Function to check if the number is an integer
  bool isInteger(double number) {
    return number == number.toInt();
  }

  // Function to check if the number is a whole number (Cacah)
  bool isCacah(double number) {
    return number >= 0 && number == number.toInt();
  }

  // Function to handle comma input (replace comma with dot for decimals)
  double parseNumber(String input) {
    String processedInput = input.replaceAll(',', '.');
    return double.tryParse(processedInput) ?? 0;
  }

  // Determine the type of number based on user input
  void _checkNumberType() {
    double inputNumber = parseNumber(_numberController.text);

    setState(() {
      if (_numberController.text.isEmpty) {
        _result = "Masukkan sebuah angka";
        return;
      }

      if (isInteger(inputNumber)) {
        int intNumber = inputNumber.toInt();
        if (intNumber <= 0) {
          _result = "Angka ini adalah ${positiveOrNegative(inputNumber)}";
        } else if (intNumber == 0) {
          _result = "Angka ini adalah Cacah (0)";
        } else {
          _result = "Angka ini adalah Bulat Positif: $intNumber";
          if (isPrime(intNumber)) {
            _result += "\nAngka ini adalah Bilangan Prima!";
          }
        }
      } else {
        _result = "Angka ini adalah Decimal: $inputNumber";
      }

      if (isCacah(inputNumber)) {
        _result += "\nAngka ini juga termasuk Cacah!";
      }
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
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(12),  // Limits input length to 12 characters
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
