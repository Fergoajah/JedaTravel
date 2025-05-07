import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Root aplikasi
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false; // Variabel untuk menyimpan mode tema

  // Fungsi untuk mengganti tema
  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan label debug
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(), // Ganti tema
      home: HomePage(toggleTheme: _toggleTheme, isDarkMode: _isDarkMode),
    );
  }
}

// Halaman utama dengan dua tab: Home & Profile
class HomePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const HomePage({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final TextEditingController _searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: const Text(
          "JedaTravel",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          // Tombol toggle dark/light mode
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: Colors.white,
            ),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),

      // Konten bergantung pada bottom navigation index
      body: _currentIndex == 0 ? _buildHomeContent() : _buildProfileContent(),

      // Navigasi bawah untuk berpindah antara home dan profile
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: widget.isDarkMode ? Colors.amber : Colors.black,
        unselectedItemColor:
            widget.isDarkMode ? Colors.grey[400] : Colors.grey[700],
        backgroundColor: widget.isDarkMode ? Colors.grey[900] : Colors.white,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  // Konten untuk halaman Home
  Widget _buildHomeContent() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Search bar
        SearchBar(
          controller: _searchcontroller,
          padding: const WidgetStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 16.0),
          ),
          onTap: () {},
          leading: const Icon(Icons.search),
          hintText: 'Cari tujuan Kamu',
          elevation: const WidgetStatePropertyAll(3),
          backgroundColor: WidgetStateProperty.all(Colors.white),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: Colors.grey),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Carousel foto destinasi
        CarouselSlider(
          items: [
            _buildImageCard("images/lake.jpg"),
            _buildImageCard("images/francis.jpg"),
            _buildImageCard("images/fumotoppara.jpg"),
            _buildImageCard("images/Hottarakashi.jpg"),
            _buildImageCard("images/oeschinen1.jpg"),
          ],
          options: CarouselOptions(
            height: 250.0,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
        ),

        const SizedBox(height: 20),

        // Widget rekomendasi tempat camping
        const RecomendationPlace(),
      ],
    );
  }

  // Card untuk carousel image
  Widget _buildImageCard(String assetPath) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(image: AssetImage(assetPath), fit: BoxFit.cover),
      ),
    );
  }

  // Konten untuk halaman Profile
  Widget _buildProfileContent() {
    return const Center(
      child: Text(
        'Profile Page',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Widget rekomendasi tempat yang dapat diklik
class RecomendationPlace extends StatelessWidget {
  const RecomendationPlace({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Map<String, String>> morePlaces = [
      {
        'image': 'images/fumotoppara.jpg',
        'title': 'Fumotoppara Campground',
        'description':
            'Fumotoppara Campground adalah salah satu tempat berkemah paling ikonik di Jepang, terletak di Asagiri Kogen, Kota Fujinomiya, Prefektur Shizuoka. Dikenal karena pemandangan Gunung Fuji yang menakjubkan tanpa halangan, area ini menawarkan padang rumput luas seluas sekitar 30 hektar, memungkinkan pengunjung untuk mendirikan tenda di mana saja sesuai keinginan. Kebebasan ini memberikan pengalaman berkemah yang fleksibel dan pribadi, menjadikannya favorit di kalangan keluarga, pemula, maupun penggemar alam yang mencari ketenangan dan keindahan alam.\n\n'
            'Fasilitas di Fumotoppara sangat lengkap, termasuk toilet modern dengan kursi berpemanas, area memasak, toko perlengkapan, dan restoran Kanayama Terrace yang menyajikan hidangan lokal seperti daging rusa (gibier). Pengunjung juga dapat menikmati pemandangan Gunung Fuji yang berubah-ubah tergantung waktu dan cuaca, serta langit malam yang dipenuhi bintang karena minimnya polusi cahaya. Dengan biaya berkemah yang terjangkau dan suasana yang damai, Fumotoppara menjadi destinasi ideal bagi mereka yang ingin merasakan kedekatan dengan alam sambil menikmati kenyamanan fasilitas modern.',
      },
      {
        'image': 'images/lake.jpg',
        'title': 'Oeschinen Lake',
        'description':
            'Oeschinen Lake Campground terletak di dekat Danau Oeschinen (Oeschinensee), sebuah danau pegunungan yang memukau di wilayah Kandersteg, Swiss. Terletak di jantung Pegunungan Alpen Bernese, tempat ini menawarkan pemandangan alam yang spektakuler dengan air danau berwarna biru kehijauan yang jernih, dikelilingi oleh tebing dan puncak gunung yang menjulang tinggi.\n\n'
            'Area perkemahan ini cocok bagi pecinta alam yang ingin merasakan kedamaian dan keindahan lanskap pegunungan sambil bermalam di alam terbuka.Campground ini menjadi titik awal yang ideal untuk berbagai aktivitas luar ruangan seperti hiking, berenang di danau (pada musim panas), atau sekadar bersantai menikmati panorama. Dengan fasilitas dasar yang cukup dan akses yang mudah dari Kandersteg—baik dengan kereta gantung maupun jalur pendakian—Oeschinen Lake Campground adalah pilihan populer bagi wisatawan dan pendaki yang ingin menikmati pengalaman berkemah autentik di tengah keindahan alam Swiss.',
      },
      {
        'image': 'images/francis.jpg',
        'title': 'Francis Beach Campground',
        'description':
            'Francis Beach Campground terletak di Half Moon Bay State Beach, California, dan menawarkan pengalaman berkemah yang menenangkan di tepi Samudra Pasifik. Dengan 52 lokasi perkemahan yang tersedia sepanjang tahun, tempat ini cocok untuk tenda maupun RV hingga panjang 40 kaki. Beberapa lokasi menyediakan sambungan listrik, sementara fasilitas lainnya mencakup meja piknik, ring api unggun, toilet flush, dan shower berbayar. Meskipun tidak ada sambungan air atau saluran pembuangan langsung, tersedia stasiun pengisian air dan pembuangan limbah di dekat pintu masuk.\n\n'
            'Terletak di atas tebing dengan akses mudah ke pantai, pengunjung dapat menikmati suara ombak yang menenangkan dan pemandangan matahari terbenam yang memukau. Jalur Coastside Trail yang beraspal membentang sepanjang garis pantai, ideal untuk berjalan kaki atau bersepeda. Meskipun anjing diperbolehkan di area perkemahan dan jalur dengan tali, mereka tidak diizinkan di pantai. Reservasi dapat dilakukan hingga enam bulan sebelumnya melalui ReserveCalifornia.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rekomendasi Tempat Buat Kamu nih!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Align(
          alignment: Alignment.centerLeft, // bisa diatur ke kiri, kanan, dll.
          child: SizedBox(
            width: 300, // atur panjang garis manual
            child: const Divider(color: Colors.black, thickness: 1),
          ),
        ),

        const SizedBox(height: 8),
        ListView.builder(
          itemCount: morePlaces.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final place = morePlaces[index];
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          place['image']!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
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
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 141, 141, 141),
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
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
    );
  }
}
