import 'package:flutter/material.dart';

import '../models/hasil_deteksi.dart';

class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang AgriVision')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Tujuan Aplikasi',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          const Text(
            'AgriVision CNN membantu kelompok tani mencatat hasil identifikasi '
            'penyakit dan hama padi, memantau riwayat tiap petak, serta melihat '
            'ringkasan deteksi untuk mendukung tindak lanjut di sawah.',
          ),
          const SizedBox(height: 24),
          Text(
            'Kelas Deteksi',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          ...kelasDeteksi.map(
            (kelas) => Card(
              child: ListTile(
                leading: const Icon(Icons.grass_outlined),
                title: Text(kelas),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
