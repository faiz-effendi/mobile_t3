import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RekomendasiPage extends StatefulWidget {
  const RekomendasiPage({super.key});

  @override
  State<RekomendasiPage> createState() => _RekomendasiPageState();
}

class _RekomendasiPageState extends State<RekomendasiPage> {
  // Data untuk tabel dengan status favorit
  final List<Map<String, dynamic>> websites = [
    {'name': 'Google', 'url': 'https://www.google.com', 'logo': 'google.png', 'isFavorite': false},
    {'name': 'YouTube', 'url': 'https://www.youtube.com', 'logo': 'youtube.png', 'isFavorite': false},
    {'name': 'Facebook', 'url': 'https://www.facebook.com', 'logo': 'facebook.png', 'isFavorite': false},
    {'name': 'Twitter', 'url': 'https://www.twitter.com', 'logo': 'twitter.jpg', 'isFavorite': false},
  ];

  // Fungsi untuk memuat status favorit dari SharedPreferences
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < websites.length; i++) {
      String key = websites[i]['name']!;
      websites[i]['isFavorite'] = prefs.getBool(key) ?? false;
    }
    setState(() {});
  }

  // Fungsi untuk menyimpan status favorit ke SharedPreferences
  Future<void> saveFavorite(int index) async {
    final prefs = await SharedPreferences.getInstance();
    String key = websites[index]['name']!;
    bool isFavorite = websites[index]['isFavorite'];
    await prefs.setBool(key, isFavorite);
  }

  // Fungsi untuk mengubah status favorit
  void toggleFavorite(int index) {
    setState(() {
      websites[index]['isFavorite'] = !websites[index]['isFavorite'];
    });
    saveFavorite(index); // Simpan status favorit setelah diubah
  }

  @override
  void initState() {
    super.initState();
    loadFavorites(); // Memuat status favorit saat pertama kali halaman dimuat
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Situs Rekomendasi',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 106, 40, 160),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Menggunakan ListView untuk menampilkan Card untuk tiap situs
            Expanded(
              child: ListView.builder(
                itemCount: websites.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 4,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/${websites[index]['logo']}'),
                      ),
                      title: Text(
                        websites[index]['name']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          websites[index]['isFavorite']
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: websites[index]['isFavorite']
                              ? Colors.red
                              : null,
                        ),
                        onPressed: () => toggleFavorite(index),
                      ),
                      subtitle: Text(websites[index]['url']!),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
