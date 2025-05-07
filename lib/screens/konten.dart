// Import paket Flutter untuk membuat UI
import 'package:flutter/material.dart';

// Halaman detail konten
class KontenPage extends StatefulWidget {
  final String title; // Judul konten
  final String image; // Gambar utama
  final String description; // Deskripsi konten
  final bool isDarkMode; // Mode tema saat ini (gelap atau terang)
  final VoidCallback toggleTheme; // Fungsi untuk mengubah tema

  const KontenPage({
    super.key,
    required this.title,
    required this.image,
    required this.description,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  State<KontenPage> createState() => _KontenPageState();
}

class _KontenPageState extends State<KontenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bagian atas dari layar seperti top navbar
      appBar: AppBar(
        leading: IconButton(
          // Button Back
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        title: Text(widget.title), // Menampilkan judul konten
        actions: [
          IconButton(
            // Button toggle tema mode
            icon: Icon(widget.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: widget.toggleTheme, // Memanggil fungsi tema
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Scrollable page
        child: Column(
          children: [
            ImageSection(image: widget.image), // Gambar utama konten
            TitleSection(name: widget.title), // Judul konten
            IconButtonSection(), // Bagian tombol ikon
            TextSection(description: widget.description), // Deskripsi konten
            MorePlacesSection(), // Rekomendasi tempat lainnya
          ],
        ),
      ),
    );
  }
}

// Bagian tombol ikon seperti bagikan, favorit, komentar
class IconButtonSection extends StatelessWidget {
  const IconButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 32.0),
      child: IconTheme(
        data: IconThemeData(
          size: 36,
          color: isDarkMode ? Colors.white54 : Colors.black54,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.share),
              tooltip: 'Bagikan',
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.bookmark),
              tooltip: 'Favorit',
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.comment),
              tooltip: 'Komentar',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

// Bagian judul konten
class TitleSection extends StatelessWidget {
  const TitleSection({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Bagian teks deskripsi konten
class TextSection extends StatelessWidget {
  const TextSection({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Text(description, softWrap: true,  textAlign: TextAlign.justify,
style: const TextStyle(fontSize: 18),
      ),
    );
  }
}

// Bagian gambar utama
class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      fit: BoxFit.cover,
    ); // Menyesuaikan gambar ke lebar container
  }
}

// Bagian rekomendasi tempat lainnya
class MorePlacesSection extends StatelessWidget {
  const MorePlacesSection({super.key});

  // Daftar tempat lainnya
  final List<Map<String, String>> morePlaces = const [
    {
      'image': 'assets/images/fumotoppara.jpg',
      'title': 'Fumotoppara Campground',
      'description':
          'Fumotoppara Campground is a renowned camping destination located in Fujinomiya City, Shizuoka Prefecture, Japan. ',
    },
    {
      'image': 'assets/images/Hottarakashi.jpg',
      'title': 'Hottarakashi Camping Ground',
      'description':
          'Hottarakashi Camping Ground is a scenic campsite located in Yamanashi Prefecture, Japan, at an altitude of approximately 700 meters.',
    },
    {
      'image': 'assets/images/francis.jpg',
      'title': 'Francis Beach Campground',
      'description':
          'Francis Beach Campground is a coastal camping destination located within Half Moon Bay State Beach in California. It offers 52 campsites suitable for tents, trailers, and RVs up to 40 feet in length.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'More Places to Visit',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(), // Menonaktifkan scroll listview
            itemCount: morePlaces.length,
            itemBuilder: (context, index) {
              final place = morePlaces[index];
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // Navigasi ke halaman KontenPage dengan detail baru
                    Navigator.pushNamed(
                      context,
                      '/konten',
                      arguments: {
                        'title': place['title']!,
                        'image': place['image']!,
                        'description': place['description']!,
                      },
                    );
                  },
                  splashColor: Colors.blue.withAlpha(51),
                  highlightColor: Colors.grey.withAlpha(25),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Image.asset(
                          place['image']!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 12),
                        // Informasi judul dan deskripsi singkat
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  place['title']!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  place['description']!,
                                  style: TextStyle(color: Colors.grey[700],),
                                  maxLines: 3,
                                  overflow:
                                      TextOverflow
                                          .ellipsis, // potong teks descriptioin di homepage
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
