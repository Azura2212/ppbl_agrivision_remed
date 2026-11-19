import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/deteksi_model.dart';
import 'halaman_beranda.dart';
import 'halaman_deteksi.dart';
import 'halaman_pengaturan.dart';
import 'halaman_statistik.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _tabAktif = 0;

  static const _namaTab = ['Beranda', 'Deteksi', 'Statistik', 'Pengaturan'];

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DeteksiModel>();
    final halaman = [
      const HalamanBeranda(),
      const HalamanDeteksi(),
      const HalamanStatistik(),
      const HalamanPengaturan(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AgriVision',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              _namaTab[_tabAktif],
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
      body: IndexedStack(index: _tabAktif, children: halaman),
      floatingActionButton: _tabAktif == 1
          ? FloatingActionButton.extended(
              onPressed: () =>
                  Navigator.pushNamed(context, '/input-deteksi'),
              icon: const Icon(Icons.add_a_photo_outlined),
              label: const Text('Deteksi Baru'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabAktif,
        onDestinationSelected: (index) => setState(() => _tabAktif = index),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Badge.count(
              count: model.totalPerluTindakan,
              isLabelVisible: model.totalPerluTindakan > 0,
              child: const Icon(Icons.document_scanner_outlined),
            ),
            selectedIcon: Badge.count(
              count: model.totalPerluTindakan,
              isLabelVisible: model.totalPerluTindakan > 0,
              child: const Icon(Icons.document_scanner),
            ),
            label: 'Deteksi',
          ),
          const NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Statistik',
          ),
          const NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}
