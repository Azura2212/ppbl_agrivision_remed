import 'package:flutter/material.dart';

import '../app_routes.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colors.primary, colors.primary.withValues(alpha: 0.78)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(26),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.eco_outlined, color: colors.onPrimary, size: 38),
              const SizedBox(height: 18),
              Text(
                'Selamat Datang di AgriVision CNN',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: colors.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Catat dan pantau kondisi tanaman padi di setiap petak sawah.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: colors.onPrimary.withValues(alpha: 0.9),
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Model Deteksi', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                const _InfoBaris(
                  icon: Icons.memory_outlined,
                  label: 'Arsitektur',
                  value: 'EfficientNet-B0',
                ),
                const Divider(height: 24),
                const _InfoBaris(
                  icon: Icons.category_outlined,
                  label: 'Kelas deteksi',
                  value: '5 kelas',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.tentang),
          icon: const Icon(Icons.info_outline),
          label: const Text('Tentang aplikasi'),
        ),
      ],
    );
  }
}

class _InfoBaris extends StatelessWidget {
  const _InfoBaris({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(child: Text(label)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
