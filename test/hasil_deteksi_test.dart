import 'dart:math';

import 'package:agrivision_remed_707012400042/models/hasil_deteksi.dart';
import 'package:agrivision_remed_707012400042/state/deteksi_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HasilDeteksi', () {
    HasilDeteksi buatHasil(String kelas, double skor) => HasilDeteksi(
          petak: 'Petak 1',
          kelas: kelas,
          skor: skor,
          namaPetugas: 'Petugas Uji',
          waktu: DateTime(2026, 1, 1),
        );

    test('menentukan status sesuai kelas dan ambang skor 50 persen', () {
      expect(buatHasil('Normal / Sehat', 30).status, 'Sehat');
      expect(buatHasil('Hawar daun bakteri', 49).status, 'Tidak Pasti');
      expect(buatHasil('Hawar daun bakteri', 50).status, 'Perlu Tindakan');
    });

    test('menggunakan rekomendasi untuk kelas deteksi', () {
      expect(
        buatHasil('Bercak coklat', 70).rekomendasi,
        'Tambah pupuk kalium, jaga sawah tetap tergenang.',
      );
    });
  });

  test('simulasi berisi sepuluh hasil valid dan filter petak bekerja', () {
    final model = DeteksiModel();
    model.muatDataSimulasi(random: Random(4), waktu: DateTime(2026, 1, 1));

    expect(model.hasil, hasLength(10));
    expect(model.hasil.every((item) => item.skor >= 30 && item.skor <= 99), isTrue);
    expect(
      model.hasil.every((item) => item.petak == 'Petak 1' || item.petak == 'Petak 2'),
      isTrue,
    );

    model.ubahFilter(FilterPetak.petak1);
    expect(model.hasilTerfilter.every((item) => item.petak == 'Petak 1'), isTrue);
  });
}
