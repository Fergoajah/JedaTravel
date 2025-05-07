import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Halaman login menggunakan StatefulWidget untuk mengelola input email dan password
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controller untuk mengambil input dari TextField email dan password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   //kerangka dasar
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all( // Padding di sekitar isi dari searchbar seperti text dan icon
            24.0,
          ),
          // Agar bisa discroll jika keyboard muncul
          child: SingleChildScrollView(
            // wadah untuk input field
            child: Form(
              // menyusun widget secara vertikal
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Icon untuk login
                  const Icon(
                    Icons.mode_of_travel_outlined,
                    size: 48,
                    color: Colors.black,
                  ),

                  const SizedBox(height: 16), // Jarak vertikal

                  //Nama Aplikasi
                  Text(
                    "JedaTravel",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Slogan Jeda Travel
                  Text(
                    "Login dulu baru camping",
                    style: GoogleFonts.poppins(
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 28),

                  // Field input email
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Email',
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Field input password
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Password',
                    ),
                    obscureText: true, // Menyembunyikan karakter password
                  ),

                  const SizedBox(height: 12),

                  // Button lupa password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        //navigator lupa password masih belum ada
                      },
                      child: const Text(
                        "Lah ko Lupa Password?",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Button login
                  ElevatedButton(
                    onPressed: () {
                      // Navigasi ke halaman home setelah login
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(
                        double.infinity,
                        50,
                      ), // Tombol full width
                      backgroundColor: Colors.black, // Warna background tombol
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ), 
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Button register
                  TextButton(
                    onPressed: () {
                      // Navigasi ke halaman register
                    },
                    child: const Text(
                      "Lah Gapunya Akun? Register",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
