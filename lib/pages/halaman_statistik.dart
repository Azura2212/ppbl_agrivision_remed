import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/hasil_deteksi.dart';
import '../state/deteksi_model.dart';

class HalamanStatistik extends StatelessWidget {
  const HalamanStatistik({super.key});

  static const _labelKelas = [
    'Hawar',
    'Blas',
    'Bercak',
    'Sehat',
    'Tungro',
  ];

  @override
  Widget build(BuildContext context) {
    final hasil = context.watch<DeteksiModel>().hasil;
    final jumlahPerKelas = [
      for (final kelas in kelasDeteksi)
        hasil.where((item) => item.kelas == kelas).length,
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Statistik Deteksi',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          'Jumlah deteksi untuk setiap kelas penyakit dan kondisi tanaman.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 16, 12),
            child: Column(
              children: [
                Text(
                  'Deteksi per Kelas',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 260,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: _maxY(jumlahPerKelas),
                      gridData: const FlGridData(show: true),
                      borderData: FlBorderData(show: false),
                      barTouchData: BarTouchData(enabled: true),
                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 32,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 38,
                            getTitlesWidget: (value, meta) {
                              final index = value.toInt();
                              if (index < 0 || index >= _labelKelas.length) {
                                return const SizedBox.shrink();
                              }
                              return SideTitleWidget(
                                meta: meta,
                                child: Text(
                                  _labelKelas[index],
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      barGroups: [
                        for (var index = 0;
                            index < jumlahPerKelas.length;
                            index++)
                          BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: jumlahPerKelas[index].toDouble(),
                                color: Theme.of(context).colorScheme.primary,
                                width: 28,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        ...List.generate(
          kelasDeteksi.length,
          (index) => ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            title: Text(kelasDeteksi[index]),
            trailing: CircleAvatar(
              radius: 16,
              backgroundColor: Theme.of(context)
                  .colorScheme
                  .primaryContainer,
              child: Text('${jumlahPerKelas[index]}'),
            ),
          ),
        ),
      ],
    );
  }

  double _maxY(List<int> counts) {
    final maxCount = counts.fold<int>(0, (max, count) => count > max ? count : max);
    return maxCount == 0 ? 1 : (maxCount + 1).toDouble();
  }
}
