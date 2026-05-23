// lib/widgets/custom_widgets.dart
//
// REUSABLE WIDGETS: widget-widget kecil yang dipakai di banyak halaman.
// Dengan memisahkan ke sini, kita tidak perlu menulis ulang kode yang sama
// di setiap screen. Ini prinsip DRY (Don't Repeat Yourself).

import 'package:flutter/material.dart';

// ─── 1. CustomTextField ────────────────────────────────────────────────────
//
// StatelessWidget: tidak punya state sendiri.
// Widget ini hanya menampilkan TextFormField dengan styling konsisten.
// Semua data yang dibutuhkan diterima melalui constructor (parameter).
class CustomTextField extends StatelessWidget {
  // PARAMETER CONSTRUCTOR — semua data dikirim dari luar
  final String label;
  final String hint;
  final TextEditingController controller; // mengontrol & membaca isi field
  final String? Function(String?) validator; // fungsi validasi dari parent
  final bool obscureText;           // true = karakter disembunyikan (password)
  final Widget? suffixIcon;         // ikon di kanan field (misal: mata untuk password)
  final TextInputType keyboardType; // jenis keyboard (email, number, text)
  final TextInputAction textInputAction; // tombol di keyboard (next, done)

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label di atas field
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 6), // jarak vertikal antar widget
        // TextFormField: field input yang terintegrasi dengan Form & validator
        TextFormField(
          controller: controller,
          validator: validator,       // fungsi yang dipanggil saat form di-validate
          obscureText: obscureText,   // sembunyikan karakter atau tidak
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          style: TextStyle(color: colorScheme.onSurface),
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.5)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.error, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}

// ─── 2. PrimaryButton ──────────────────────────────────────────────────────
//
// Tombol utama yang menampilkan loading indicator saat isLoading == true.
// Ini adalah contoh penerapan STATE: tampilan tombol berubah tergantung state.
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed; // null = tombol disabled otomatis
  final bool isLoading;          // STATE: apakah sedang loading?

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // tombol selebar parent
      height: 50,
      child: ElevatedButton(
        // Jika isLoading = true, onPressed = null → tombol tidak bisa ditekan
        // Ini mencegah user menekan tombol dua kali saat sedang proses
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
        child: isLoading
            // Jika loading: tampilkan spinner (CircularProgressIndicator)
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            // Jika tidak loading: tampilkan label teks biasa
            : Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

// ─── 3. AvatarCircle ───────────────────────────────────────────────────────
//
// Widget sederhana untuk menampilkan inisial nama dalam lingkaran berwarna.
class AvatarCircle extends StatelessWidget {
  final String initials;
  final double size;

  const AvatarCircle({super.key, required this.initials, this.size = 48});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            fontSize: size * 0.35,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ),
    );
  }
}
