import 'package:flutter/material.dart';
import 'package:tugas3_tpm/components/button_menu.dart';
import 'package:tugas3_tpm/pages/anggota_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, required this.username});
  final String username;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${widget.username}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false);
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Pilih Menu Operasi',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 106, 40, 160),
                  ),
                  textAlign: TextAlign.center),
              const SizedBox(height: 40),
              MenuButton(
                  label: 'Team', targetPage: AnggotaPage(), icon: Icons.people),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ));
  }
}
