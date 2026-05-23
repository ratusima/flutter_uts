// lib/screens/dashboard_screen.dart
//
// HALAMAN 3 — DASHBOARD SCREEN (bobot 35% nilai praktikum)
//
// Fitur wajib:
// - AppBar dengan tombol logout
// - Tampilan data user yang login (dari AppState)
// - ListView.builder dengan minimal 10 item dummy
// - Minimal 1 Card dengan styling
// - Logout dengan Navigator.pushAndRemoveUntil

import 'package:flutter/material.dart';
import '../utils/app_state.dart';
import '../widgets/custom_widgets.dart';

// Data dummy untuk ListView — simulasi data dari API/database
// Di aplikasi nyata, ini akan diambil dari server menggunakan HTTP request
const List<Map<String, dynamic>> _dummyItems = [
  {'title': 'Flutter Fundamentals', 'subtitle': 'Pertemuan 1 — Pengantar', 'icon': Icons.flutter_dash, 'color': Color(0xFF0175C2)},
  {'title': 'Dart Programming', 'subtitle': 'Pertemuan 2 — Bahasa Dart', 'icon': Icons.code_rounded, 'color': Color(0xFF00B4AB)},
  {'title': 'Widget Fundamentals', 'subtitle': 'Pertemuan 3 — Widget Dasar', 'icon': Icons.widgets_rounded, 'color': Color(0xFF7B61FF)},
  {'title': 'Advanced Widgets', 'subtitle': 'Pertemuan 4 — Widget Lanjut', 'icon': Icons.view_quilt_rounded, 'color': Color(0xFFFF6B6B)},
  {'title': 'State Management', 'subtitle': 'Pertemuan 5 — Manajemen State', 'icon': Icons.sync_rounded, 'color': Color(0xFF4CAF50)},
  {'title': 'Navigation & Routing', 'subtitle': 'Pertemuan 4 — Navigator', 'icon': Icons.route_rounded, 'color': Color(0xFFFF9800)},
  {'title': 'Form & Validation', 'subtitle': 'Pertemuan 4 — TextFormField', 'icon': Icons.fact_check_rounded, 'color': Color(0xFFE91E63)},
  {'title': 'Networking & API', 'subtitle': 'Materi Lanjutan', 'icon': Icons.wifi_rounded, 'color': Color(0xFF00BCD4)},
  {'title': 'Local Storage', 'subtitle': 'Materi Lanjutan', 'icon': Icons.storage_rounded, 'color': Color(0xFF795548)},
  {'title': 'Firebase Integration', 'subtitle': 'Materi Lanjutan', 'icon': Icons.local_fire_department_rounded, 'color': Color(0xFFFF5722)},
  {'title': 'Testing & Debugging', 'subtitle': 'Best Practices', 'icon': Icons.bug_report_rounded, 'color': Color(0xFF607D8B)},
  {'title': 'Deployment & Publish', 'subtitle': 'App Store & Play Store', 'icon': Icons.rocket_launch_rounded, 'color': Color(0xFF9C27B0)},
];

// DashboardScreen adalah StatelessWidget karena:
// - Data user sudah disimpan di AppState (InheritedWidget)
// - Halaman ini hanya MEMBACA state, tidak mengubahnya
// - Tidak ada interaksi yang memerlukan setState() di halaman ini
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // Fungsi logout — dipanggil saat tombol logout ditekan
  void _handleLogout(BuildContext context) {
    // Tampilkan Dialog konfirmasi sebelum logout
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Konfirmasi Logout'),
        content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx), // tutup dialog
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx); // tutup dialog dulu
              // Hapus data user dari AppState
              AppState.of(context)?.logout();
              // Navigator.pushAndRemoveUntil:
              // - Buka halaman login
              // - HAPUS semua halaman di bawahnya dari stack
              // Kenapa bukan push biasa?
              // Kalau pakai push, user bisa tekan back dan kembali ke dashboard
              // tanpa login ulang — ini celah keamanan!
              // pushAndRemoveUntil memastikan stack bersih hanya ada login.
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const _LoginPlaceholder()),
                (route) => false, // (route) => false = hapus SEMUA route yang ada
              );
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Ambil data user dari AppState (InheritedWidget)
    // Inilah manfaat InheritedWidget: akses data tanpa prop drilling
    final appState = AppState.of(context);
    final user = appState?.currentUser;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false, // sembunyikan tombol back otomatis
        backgroundColor: colorScheme.surface,
        elevation: 0,
        title: Text(
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.w700, color: colorScheme.onSurface),
        ),
        actions: [
          // Tombol logout di AppBar
          IconButton(
            icon: Icon(Icons.logout_rounded, color: colorScheme.error),
            tooltip: 'Logout',
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),

      // CustomScrollView: scroll view yang bisa menggabungkan berbagai jenis widget
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ── KARTU PROFIL USER ──────────────────────────────
                  // Card: widget yang menampilkan konten dengan elevation (bayangan)
                  // dan rounded corner — visual standar Material Design
                  Card(
                    elevation: 0,
                    color: colorScheme.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          // AvatarCircle: widget dari lib/widgets/custom_widgets.dart
                          AvatarCircle(
                            initials: user?.avatarInitials ?? '?',
                            size: 56,
                          ),
                          const SizedBox(width: 16),
                          // Expanded: mengisi sisa ruang yang tersedia dalam Row
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selamat datang,',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                                Text(
                                  user?.name ?? 'Guest',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    user?.role ?? '',
                                    style: const TextStyle(fontSize: 12, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── STATISTIK ──────────────────────────────────────
                  // Row: menyusun widget secara horizontal
                  Row(
                    children: [
                      // Expanded: tiap card mendapat ruang yang sama (1:1)
                      Expanded(child: _StatCard(
                        label: 'Total Materi',
                        value: '12',
                        icon: Icons.menu_book_rounded,
                        color: colorScheme.primary,
                      )),
                      const SizedBox(width: 12),
                      Expanded(child: _StatCard(
                        label: 'Selesai',
                        value: '5',
                        icon: Icons.check_circle_outline_rounded,
                        color: Colors.green,
                      )),
                      const SizedBox(width: 12),
                      Expanded(child: _StatCard(
                        label: 'Pertemuan',
                        value: '5',
                        icon: Icons.event_rounded,
                        color: colorScheme.secondary,
                      )),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Daftar Materi',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),

          // ── LIST VIEW DENGAN LISTVIEW.BUILDER ─────────────────────
          // SliverList: versi ListView yang bekerja dalam CustomScrollView
          // ListView.builder: membuat item secara LAZY (hanya yang terlihat di layar)
          // Ini lebih efisien daripada membuat semua item sekaligus,
          // terutama untuk list yang panjang (ribuan item)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                // Builder function: dipanggil untuk setiap item saat muncul di layar
                (context, index) {
                  final item = _dummyItems[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _MateriCard(item: item),
                  );
                },
                childCount: _dummyItems.length, // total jumlah item
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}

// ─── Widget: _StatCard ─────────────────────────────────────────────────────
// Private widget (diawali _) = hanya bisa dipakai dalam file ini
class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: color)),
          Text(label, style: TextStyle(fontSize: 11, color: color.withOpacity(0.7))),
        ],
      ),
    );
  }
}

// ─── Widget: _MateriCard ───────────────────────────────────────────────────
// Card untuk setiap item di ListView
class _MateriCard extends StatelessWidget {
  final Map<String, dynamic> item;
  const _MateriCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final color = item['color'] as Color;
    final colorScheme = Theme.of(context).colorScheme;

    // Card: komponen Material Design dengan shadow, rounded corner, dan padding
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: colorScheme.outline.withOpacity(0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            // Ikon dengan background warna
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(item['icon'] as IconData, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            // Expanded agar teks tidak overflow ke kanan
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item['subtitle'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurface.withOpacity(0.55),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: colorScheme.onSurface.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder untuk navigasi pushAndRemoveUntil ke login
// Diperlukan agar tidak ada circular dependency antara dashboard dan login
class _LoginPlaceholder extends StatelessWidget {
  const _LoginPlaceholder();

  @override
  Widget build(BuildContext context) {
    // Setelah build, langsung navigasi ke named route '/login'
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, '/login');
    });
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
