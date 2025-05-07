import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Mengimpor file-file yang dibutuhkan untuk routing ke halaman login, homepage, dan konten
import 'screens/login_page.dart';
import 'screens/homepage.dart';
import 'screens/konten.dart';

// Fungsi utama untuk menjalankan aplikasi
void main() => runApp(const MyApp());

// Widget utama aplikasi
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Menyimpan status mode gelap atau terang
  bool _isDarkMode = false;

  // Fungsi untuk mengganti mode theme
  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JedaTravel',
      debugShowCheckedModeBanner: false, // Menyembunyikan banner debug


      // Menentukan tema berdasarkan status _isDarkMode
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              // Menggunakan font Comic Neue untuk tema gelap
              textTheme: GoogleFonts.comicNeueTextTheme(
                ThemeData.dark().textTheme,
              ),
            )
          : ThemeData.light().copyWith(
              // Menggunakan font Comic Neue untuk tema terang
              textTheme: GoogleFonts.comicNeueTextTheme(
                ThemeData.light().textTheme,
              ),
            ),


      initialRoute: '/login', // Halaman awal saat aplikasi dijalankan
      onGenerateRoute: (settings) {

        // Routing dinamis berdasarkan nama route
        switch (settings.name) {
          case '/login':
            // Routing ke halaman login
            return MaterialPageRoute(builder: (_) => const LoginPage());


          case '/home':
            // Routing ke homepage setelah login berhasil
            return MaterialPageRoute(
              builder: (_) => HomePage(
                toggleTheme: _toggleTheme, // Forward fungsi toggle tema
                isDarkMode: _isDarkMode,   // Forward status tema
              ),
            );

          case '/konten':
            // Routing ke halaman konten dan menerima argument
            final args = settings.arguments as Map<String, String>;
            return MaterialPageRoute(
              builder: (_) => KontenPage(
                title: args['title'] ?? '',           // Judul konten
                image: args['image'] ?? '',           // Gambar konten
                description: args['description'] ?? '', // Deskripsi konten
                isDarkMode: _isDarkMode,              // Status tema
                toggleTheme: _toggleTheme,            // Fungsi toggle tema
              ),
            );

          default:
            // return null jika tidak ada route yang cocok
            return null;
        }
      },
    );
  }
}
