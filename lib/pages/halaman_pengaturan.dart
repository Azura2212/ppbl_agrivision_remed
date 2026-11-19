import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/deteksi_model.dart';

class HalamanPengaturan extends StatelessWidget {
  const HalamanPengaturan({super.key});

  Future<void> _hapusSemua(BuildContext context) async {
    final hapus = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus semua data?'),
        content: const Text(
          'Seluruh riwayat deteksi akan dihapus dari memori aplikasi.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (hapus == true && context.mounted) {
      context.read<DeteksiModel>().hapusSemuaData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DeteksiModel>();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Pengaturan',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Card(
          child: SwitchListTile(
            value: model.isDarkMode,
            title: const Text('Mode Gelap'),
            subtitle: const Text('Sesuaikan tampilan untuk kondisi cahaya redup'),
            secondary: const Icon(Icons.dark_mode_outlined),
            onChanged: context.read<DeteksiModel>().ubahModeGelap,
          ),
        ),
        const SizedBox(height: 20),
        Text('Data Deteksi', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        FilledButton.icon(
          onPressed: () {
            context.read<DeteksiModel>().muatDataSimulasi();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('10 data simulasi berhasil dimuat')),
            );
          },
          icon: const Icon(Icons.auto_awesome_outlined),
          label: const Text('Muat Data Simulasi'),
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: model.hasil.isEmpty ? null : () => _hapusSemua(context),
          icon: const Icon(Icons.delete_sweep_outlined),
          label: const Text('Hapus Semua Data'),
        ),
        const SizedBox(height: 20),
        Card(
          child: ListTile(
            leading: const Icon(Icons.storage_outlined),
            title: const Text('Penyimpanan lokal'),
            subtitle: Text('${model.hasil.length} data tersimpan di memori'),
          ),
        ),
      ],
    );
  }
}
