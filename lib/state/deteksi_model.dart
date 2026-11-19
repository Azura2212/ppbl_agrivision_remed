import 'dart:math';

import 'package:flutter/foundation.dart';

import '../models/hasil_deteksi.dart';

enum FilterPetak { semua, petak1, petak2 }

class DeteksiModel extends ChangeNotifier {
  final List<HasilDeteksi> _hasil = [];
  FilterPetak _filterPetak = FilterPetak.semua;
  bool _isDarkMode = false;

  List<HasilDeteksi> get hasil => List.unmodifiable(_hasil);
  FilterPetak get filterPetak => _filterPetak;
  bool get isDarkMode => _isDarkMode;

  List<HasilDeteksi> get hasilTerfilter {
    switch (_filterPetak) {
      case FilterPetak.semua:
        return hasil;
      case FilterPetak.petak1:
        return _hasil.where((item) => item.petak == 'Petak 1').toList();
      case FilterPetak.petak2:
        return _hasil.where((item) => item.petak == 'Petak 2').toList();
    }
  }

  int get totalSehat => _hasil.where((item) => item.isSehat).length;

  int get totalPerluTindakan =>
      _hasil.where((item) => item.status == 'Perlu Tindakan').length;

  void tambahData(HasilDeteksi hasil) {
    _hasil.insert(0, hasil);
    notifyListeners();
  }

  void hapusData(HasilDeteksi hasil) {
    _hasil.remove(hasil);
    notifyListeners();
  }

  void hapusSemuaData() {
    _hasil.clear();
    notifyListeners();
  }

  void ubahFilter(FilterPetak filter) {
    _filterPetak = filter;
    notifyListeners();
  }

  void ubahModeGelap(bool aktif) {
    _isDarkMode = aktif;
    notifyListeners();
  }

  List<HasilDeteksi> buatDataSimulasi({Random? random, DateTime? waktu}) {
    final rng = random ?? Random();
    final sekarang = waktu ?? DateTime.now();
    return List.generate(10, (index) {
      return HasilDeteksi(
        petak: rng.nextBool() ? 'Petak 1' : 'Petak 2',
        kelas: kelasDeteksi[rng.nextInt(kelasDeteksi.length)],
        skor: (30 + rng.nextInt(70)).toDouble(),
        namaPetugas: 'Petugas ${index + 1}',
        waktu: sekarang.subtract(Duration(hours: index * 3)),
      );
    });
  }

  void muatDataSimulasi({Random? random, DateTime? waktu}) {
    _hasil.insertAll(0, buatDataSimulasi(random: random, waktu: waktu));
    notifyListeners();
  }
}
