import 'package:flutter/material.dart';

import '../models/hasil_deteksi.dart';

class DeteksiCard extends StatelessWidget {
  const DeteksiCard({
    super.key,
    required this.hasil,
    required this.onDelete,
  });

  final HasilDeteksi hasil;
  final VoidCallback onDelete;

  Color _statusColor(BuildContext context) {
    switch (hasil.status) {
      case 'Sehat':
        return Colors.green;
      case 'Tidak Pasti':
        return Colors.orange;
      default:
        return Theme.of(context).colorScheme.error;
    }
  }

  IconData _statusIcon() {
    switch (hasil.status) {
      case 'Sehat':
        return Icons.check_circle_outline;
      case 'Tidak Pasti':
        return Icons.help_outline;
      default:
        return Icons.warning_amber_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(context);
    final waktu = hasil.waktu;
    final tanggal =
        '${waktu.day.toString().padLeft(2, '0')}/${waktu.month.toString().padLeft(2, '0')}/${waktu.year} '
        '${waktu.hour.toString().padLeft(2, '0')}:${waktu.minute.toString().padLeft(2, '0')}';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hasil.petak,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        hasil.kelas,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onDelete,
                  tooltip: 'Hapus hasil deteksi',
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(_statusIcon(), size: 17, color: statusColor),
                  const SizedBox(width: 6),
                  Text(
                    hasil.status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const Expanded(child: Text('Skor deteksi')),
                Text('${hasil.skor.toStringAsFixed(0)}%'),
              ],
            ),
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: (hasil.skor / 100).clamp(0, 1),
              minHeight: 7,
              borderRadius: BorderRadius.circular(8),
              color: statusColor,
            ),
            const SizedBox(height: 12),
            Text(
              hasil.rekomendasi,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '$tanggal • ${hasil.namaPetugas}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
