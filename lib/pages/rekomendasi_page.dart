import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


class RekomendasiPage extends StatefulWidget {
  final String username;
  const RekomendasiPage({super.key, required this.username});

  @override
  State<RekomendasiPage> createState() => _RekomendasiPageState();
}

class _RekomendasiPageState extends State<RekomendasiPage> {
  // Data untuk tabel dengan status favorit
  final List<Map<String, dynamic>> websites = [
    {'name': 'Google', 'url': 'https://www.google.co.id/?hl=id', 'logo': 'google.jpg', 'isFavorite': false},
    {'name': 'YouTube', 'url': 'https://www.youtube.com', 'logo': 'youtube.jpg', 'isFavorite': false},
    {'name': 'Facebook', 'url': 'https://www.facebook.com', 'logo': 'facebook.png', 'isFavorite': false},
    {'name': 'Twitter', 'url': 'https://www.twitter.com', 'logo': 'twitter.jpg', 'isFavorite': false},
  ];

  // Fungsi untuk memuat status favorit dari SharedPreferences
  Future<void> loadFavorites(String username) async {
  final prefs = await SharedPreferences.getInstance();
  for (int i = 0; i < websites.length; i++) {
    String key = '${username}_${websites[i]['name']}'; // Kunci unik berdasarkan username
    websites[i]['isFavorite'] = prefs.getBool(key) ?? false;
  }
  setState(() {});
}

  // Fungsi untuk menyimpan status favorit ke SharedPreferences
  Future<void> saveFavorite(String username, int index) async {
  final prefs = await SharedPreferences.getInstance();
  String key = '${username}_${websites[index]['name']}'; // Kunci unik berdasarkan username
  bool isFavorite = websites[index]['isFavorite'];
  await prefs.setBool(key, isFavorite);
}

  // Fungsi untuk mengubah status favorit
  void toggleFavorite(String username, int index) {
    setState(() {
      websites[index]['isFavorite'] = !websites[index]['isFavorite'];
    });
    saveFavorite(username, index); // Simpan status favorit dengan username
  }

  @override
  void initState() {
    super.initState();
    loadFavorites(widget.username); // Memuat status favorit saat pertama kali halaman dimuat
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
                    child: InkWell(
                      onTap: () async {
                        final url = websites[index]['url'];
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Tidak dapat membuka URL: $url')),
                          );
                        }
                      },
                                            child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        leading: Image.asset(
                          'assets/images/${websites[index]['logo']}',
                          width: 40.0,
                          height: 80.0,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          websites[index]['name']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          websites[index]['url']!, // Tampilkan URL di bawah nama
                          style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            websites[index]['isFavorite']
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: websites[index]['isFavorite'] ? Colors.red : null,
                          ),
                          onPressed: () => toggleFavorite(widget.username, index),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}