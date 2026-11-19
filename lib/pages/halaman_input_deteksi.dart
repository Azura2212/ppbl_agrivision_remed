import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/hasil_deteksi.dart';
import '../state/deteksi_model.dart';

class HalamanInputDeteksi extends StatefulWidget {
  const HalamanInputDeteksi({super.key});

  @override
  State<HalamanInputDeteksi> createState() => _HalamanInputDeteksiState();
}

class _HalamanInputDeteksiState extends State<HalamanInputDeteksi> {
  final _formKey = GlobalKey<FormState>();
  final _skorController = TextEditingController();
  final _petugasController = TextEditingController();
  String _petak = 'Petak 1';
  String _kelas = kelasDeteksi.first;
  bool _dataSudahBenar = false;

  @override
  void dispose() {
    _skorController.dispose();
    _petugasController.dispose();
    super.dispose();
  }

  Future<void> _simpan() async {
    if (!_formKey.currentState!.validate()) return;

    final skor = double.parse(_skorController.text.trim());
    final hasil = HasilDeteksi(
      petak: _petak,
      kelas: _kelas,
      skor: skor,
      namaPetugas: _petugasController.text.trim(),
      waktu: DateTime.now(),
    );

    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Konfirmasi Deteksi'),
        content: Text(
          '${hasil.kelas} • ${hasil.skor.toStringAsFixed(0)}%\n'
          'Status: ${hasil.status}\n'
          'Simpan hasil deteksi ini?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Ya, simpan'),
          ),
        ],
      ),
    );

    if (konfirmasi != true || !mounted) return;
    context.read<DeteksiModel>().tambahData(hasil);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data tersimpan')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input Hasil Deteksi')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Petak Sawah', style: Theme.of(context).textTheme.titleMedium),
            RadioGroup<String>(
              groupValue: _petak,
              onChanged: (value) {
                if (value != null) setState(() => _petak = value);
              },
              child: Column(
                children: const [
                  RadioListTile<String>(
                    value: 'Petak 1',
                    title: Text('Petak 1'),
                    contentPadding: EdgeInsets.zero,
                  ),
                  RadioListTile<String>(
                    value: 'Petak 2',
                    title: Text('Petak 2'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _kelas,
              decoration: const InputDecoration(labelText: 'Kelas Deteksi'),
              items: kelasDeteksi
                  .map((kelas) =>
                      DropdownMenuItem(value: kelas, child: Text(kelas)))
                  .toList(),
              onChanged: (value) => setState(() => _kelas = value!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _skorController,
              decoration: const InputDecoration(
                labelText: 'Skor Deteksi (%)',
                hintText: 'Contoh: 86',
                prefixIcon: Icon(Icons.percent),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                final skor = double.tryParse(value?.trim() ?? '');
                if (skor == null || !skor.isFinite || skor < 0 || skor > 100) {
                  return 'Masukkan skor angka antara 0 dan 100';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _petugasController,
              decoration: const InputDecoration(
                labelText: 'Nama Petugas',
                prefixIcon: Icon(Icons.person_outline),
              ),
              textCapitalization: TextCapitalization.words,
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Nama petugas wajib diisi'
                  : null,
            ),
            const SizedBox(height: 8),
            CheckboxListTile(
              value: _dataSudahBenar,
              contentPadding: EdgeInsets.zero,
              title: const Text('Data sudah benar'),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) =>
                  setState(() => _dataSudahBenar = value ?? false),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _dataSudahBenar ? _simpan : null,
              icon: const Icon(Icons.save_outlined),
              label: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
