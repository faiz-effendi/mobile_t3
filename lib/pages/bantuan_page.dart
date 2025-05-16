import 'package:flutter/material.dart';

class BantuanPage extends StatelessWidget {
  const BantuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bantuan'),
        backgroundColor: const Color.fromARGB(255, 106, 40, 160),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Panduan Penggunaan Aplikasi',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Text(
              '1. Login:\nMasukkan username dan password sesuai akun yang tersedia. Jika tidak punya akun, gunakan fitur Login as Guest.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              '2. Konversi Waktu:\nMasukkan jumlah tahun, lalu tekan tombol Konversi untuk melihat hasil dalam detik, menit, dan jam.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              '3. Jenis Bilangan:\nMasukkan angka (bulat atau desimal) untuk mengetahui jenis bilangan (positif, negatif, nol, prima, cacah, dll).',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              '4. Stopwatch:\nTekan lingkaran untuk mulai/berhenti. Gunakan tombol Reset untuk mengulang, dan Flag untuk menandai waktu.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              '5. Situs Rekomendasi:\nKlik pada card situs untuk membuka website. Tekan ikon hati untuk menandai favorit.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              '6. Anggota:\nLihat daftar anggota kelompok beserta foto dan nama.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Text(
              'Jika mengalami kendala, silakan hubungi pengembang melalui menu kontak di halaman anggota.',
              style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
