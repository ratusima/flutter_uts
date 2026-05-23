// lib/main.dart
//
// ENTRY POINT — titik masuk aplikasi Flutter.
// Fungsi main() adalah fungsi pertama yang dipanggil saat aplikasi dijalankan.
//
// WIDGET TREE APLIKASI (dari atas ke bawah):
//
//   main()
//     └── runApp(MyApp)
//           └── AppStateManager          ← InheritedWidget: state global
//                 └── MaterialApp        ← konfigurasi tema & routing
//                       └── routes:
//                             /login     → LoginScreen
//                             /forgot-password → ForgotPasswordScreen
//                             /dashboard → DashboardScreen

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/login_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/dashboard_screen.dart';
import 'utils/app_state.dart';

// main(): fungsi entry point — WAJIB ada dan WAJIB memanggil runApp()
void main() {
  runApp(const MyApp());
}

// MyApp adalah StatelessWidget (tidak punya state sendiri).
// Tugasnya hanya mengkonfigurasi MaterialApp dan routing.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // AppStateManager: membungkus seluruh aplikasi dengan InheritedWidget
    // Ini memungkinkan data user diakses dari halaman mana saja
    return AppStateManager(
      child: MaterialApp(
        title: 'Flutter UTS App',
        debugShowCheckedModeBanner: false, // sembunyikan banner DEBUG di pojok kanan atas

        // ── TEMA APLIKASI ──────────────────────────────────────────────
        // ThemeData.from(colorScheme): cara modern membuat tema di Flutter 3+
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF5C6BC0), // warna utama: indigo
            brightness: Brightness.light,
          ),
          // Google Fonts: package untuk menggunakan font kustom
          textTheme: GoogleFonts.plusJakartaSansTextTheme(),
          useMaterial3: true, // aktifkan Material Design 3
        ),

        // Dark theme (opsional tapi nilai tambah)
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF5C6BC0),
            brightness: Brightness.dark,
          ),
          textTheme: GoogleFonts.plusJakartaSansTextTheme(
            ThemeData(brightness: Brightness.dark).textTheme,
          ),
          useMaterial3: true,
        ),

        // ── NAMED ROUTES ───────────────────────────────────────────────
        // Named routes: mendaftarkan halaman dengan nama string.
        // Keuntungan named routes:
        //   1. Navigasi lebih mudah: Navigator.pushNamed(context, '/dashboard')
        //   2. Kode lebih rapi — tidak perlu import class halaman di setiap file
        //   3. Mudah diubah — ganti class di satu tempat saja
        initialRoute: '/login', // halaman pertama yang ditampilkan
        routes: {
          '/login': (context) => const LoginScreen(),
          '/forgot-password': (context) => const ForgotPasswordScreen(),
          '/dashboard': (context) => const DashboardScreen(),
        },
      ),
    );
  }
}
