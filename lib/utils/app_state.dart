// lib/utils/app_state.dart
//
// STATE MANAGEMENT menggunakan InheritedWidget — pendekatan bawaan Flutter.
//
// MASALAH YANG DIPECAHKAN:
// Data user yang login harus bisa diakses dari halaman mana saja
// (Login → Dashboard → dan seterusnya). Kalau pakai setState() biasa,
// kita harus "oper" data itu lewat constructor tiap widget = PROP DRILLING.
//
// SOLUSI: InheritedWidget menaruh data di atas Widget Tree,
// sehingga widget anak mana saja bisa mengambil data itu langsung
// tanpa perlu dioper satu per satu.

import 'package:flutter/material.dart';
import '../models/user_model.dart';

// ─── 1. AppState: InheritedWidget yang menyimpan data global ───────────────
//
// InheritedWidget adalah widget khusus Flutter yang bisa "diwariskan"
// ke semua widget di bawahnya dalam Widget Tree.
class AppState extends InheritedWidget {
  // Data yang ingin dibagikan ke seluruh aplikasi:
  final UserModel? currentUser;    // user yang sedang login (null jika belum login)
  final Function(UserModel) login; // fungsi untuk mengubah currentUser saat login
  final Function() logout;         // fungsi untuk menghapus currentUser saat logout

  const AppState({
    super.key,
    required this.currentUser,
    required this.login,
    required this.logout,
    required super.child, // widget anak yang akan "dibungkus" oleh AppState
  });

  // METHOD WAJIB: menentukan apakah widget yang bergantung pada AppState
  // perlu di-rebuild ketika AppState berubah.
  // Kita bandingkan currentUser lama vs baru — kalau beda, rebuild.
  @override
  bool updateShouldNotify(AppState oldWidget) {
    return oldWidget.currentUser != currentUser;
  }

  // STATIC METHOD: cara widget anak mengambil data dari AppState.
  // Dipanggil dengan: AppState.of(context)
  // Flutter akan mencari AppState terdekat di atas dalam Widget Tree.
  static AppState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppState>();
  }
}

// ─── 2. AppStateManager: StatefulWidget yang mengelola state-nya AppState ──
//
// InheritedWidget sendiri bersifat immutable (tidak bisa berubah).
// Untuk membuatnya bisa berubah, kita bungkus dalam StatefulWidget.
// StatefulWidget inilah yang menyimpan currentUser dan bisa mengubahnya
// via setState() — lalu rebuilds AppState dengan nilai baru.
class AppStateManager extends StatefulWidget {
  final Widget child;
  const AppStateManager({super.key, required this.child});

  @override
  State<AppStateManager> createState() => _AppStateManagerState();
}

class _AppStateManagerState extends State<AppStateManager> {
  UserModel? _currentUser; // state: user yang sedang login

  // Dipanggil saat login berhasil. Menyimpan data user ke state.
  void _login(UserModel user) {
    setState(() {
      _currentUser = user;
    });
  }

  // Dipanggil saat logout. Menghapus data user dari state.
  void _logout() {
    setState(() {
      _currentUser = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Membungkus seluruh aplikasi dalam AppState,
    // sehingga semua halaman bisa akses _currentUser, _login, _logout.
    return AppState(
      currentUser: _currentUser,
      login: _login,
      logout: _logout,
      child: widget.child,
    );
  }
}
