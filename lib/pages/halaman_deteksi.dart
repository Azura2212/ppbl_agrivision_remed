import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/deteksi_model.dart';
import '../widgets/deteksi_card.dart';
import '../widgets/stat_card.dart';

class HalamanDeteksi extends StatelessWidget {
  const HalamanDeteksi({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DeteksiModel>();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      children: [
        Text(
          'Riwayat Deteksi',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: StatCard(
                label: 'Total',
                value: model.hasil.length,
                icon: Icons.fact_check_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Expanded(
              child: StatCard(
                label: 'Sehat',
                value: model.totalSehat,
                icon: Icons.eco_outlined,
                color: Colors.green,
              ),
            ),
            Expanded(
              child: StatCard(
                label: 'Perlu Tindakan',
                value: model.totalPerluTindakan,
                icon: Icons.warning_amber_rounded,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text('Filter petak', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            _FilterChip(
              label: 'Semua',
              filter: FilterPetak.semua,
              selected: model.filterPetak,
            ),
            _FilterChip(
              label: 'Petak 1',
              filter: FilterPetak.petak1,
              selected: model.filterPetak,
            ),
            _FilterChip(
              label: 'Petak 2',
              filter: FilterPetak.petak2,
              selected: model.filterPetak,
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (model.hasil.isEmpty)
          const _PesanKosong(pesan: 'Belum ada data')
        else if (model.hasilTerfilter.isEmpty)
          const _PesanKosong(pesan: 'Tidak ada data untuk petak ini')
        else
          ...model.hasilTerfilter.map(
            (hasil) => DeteksiCard(
              hasil: hasil,
              onDelete: () => context.read<DeteksiModel>().hapusData(hasil),
            ),
          ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.filter,
    required this.selected,
  });

  final String label;
  final FilterPetak filter;
  final FilterPetak selected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected == filter,
      onSelected: (_) => context.read<DeteksiModel>().ubahFilter(filter),
    );
  }
}

class _PesanKosong extends StatelessWidget {
  const _PesanKosong({required this.pesan});

  final String pesan;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 48,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 12),
          Text(pesan),
        ],
      ),
    );
  }
}
