// lib/utils/validators.dart
//
// UTILITY FILE: kumpulan fungsi-fungsi helper yang bisa dipakai ulang
// di seluruh aplikasi. Dengan memisahkan logika validasi ke sini,
// kode di screen menjadi lebih bersih dan validasi mudah diubah di satu tempat.

class Validators {
  // Constructor private → class ini tidak boleh di-instantiate.
  // Semua method bersifat static, dipanggil langsung: Validators.email(value)
  Validators._();

  // VALIDASI EMAIL
  // Parameter: value → teks yang diketik user
  // Return: String (pesan error) jika tidak valid, null jika valid.
  // Flutter's Form widget otomatis menampilkan String error di bawah field.
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email tidak boleh kosong';
    }
    // RegExp = Regular Expression: pola teks untuk mencocokkan format tertentu.
    // Pola ini memeriksa format email: ada karakter, @, domain, dan .ekstensi
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Format email tidak valid (contoh: nama@domain.com)';
    }
    return null; // null = valid, tidak ada error
  }

  // VALIDASI PASSWORD (untuk login)
  // Syarat: tidak kosong, minimal 8 karakter, mengandung huruf dan angka
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 8) {
      return 'Password minimal 8 karakter';
    }
    // hasMatch: memeriksa apakah ada angka dalam string
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password harus mengandung setidaknya 1 angka';
    }
    // memeriksa apakah ada huruf dalam string
    if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
      return 'Password harus mengandung setidaknya 1 huruf';
    }
    return null;
  }

  // VALIDASI EMAIL (untuk Lupa Password — syarat sama, nama berbeda untuk kejelasan)
  static String? resetEmail(String? value) => email(value);
}
