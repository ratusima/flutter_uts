// lib/models/user_model.dart
//
// MODEL = cetak biru / blueprint data.
// Class ini merepresentasikan data seorang user di aplikasi.
// Tidak ada logika bisnis di sini — hanya struktur data.

class UserModel {
  // PROPERTY / ATRIBUT: variabel yang melekat pada setiap objek User
  final String name;
  final String email;
  final String role;
  final String avatarInitials; // huruf pertama nama untuk ditampilkan di avatar

  // CONSTRUCTOR: cara membuat objek baru dari class ini.
  // Keyword 'required' → wajib diisi saat membuat objek, tidak boleh null.
  const UserModel({
    required this.name,
    required this.email,
    required this.role,
    required this.avatarInitials,
  });

  // STATIC METHOD: method yang bisa dipanggil tanpa membuat objek dulu.
  // Digunakan untuk mendapatkan daftar user yang valid (mock / hardcoded).
  // Di aplikasi nyata, ini akan diganti dengan panggilan ke API/database.
  static List<UserModel> get validUsers => [
    const UserModel(
      name: 'Admin',
      email: 'admin@test.com',
      role: 'Administrator',
      avatarInitials: 'AD',
    ),
    const UserModel(
      name: 'Ratu Sima',
      email: 'ratu@test.com',
      role: 'Mahasiswa',
      avatarInitials: 'RS',
    ),
  ];

  // METHOD: fungsi yang bisa dipanggil pada sebuah objek User.
  // Mengembalikan String yang cocok dengan password user ini.
  String get validPassword => email == 'admin@test.com' ? 'Admin123' : 'ratu1234';
}
