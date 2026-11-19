import 'rekomendasi.dart';

const List<String> kelasDeteksi = [
  'Hawar daun bakteri',
  'Penyakit blas (jamur)',
  'Bercak coklat',
  'Normal / Sehat',
  'Penyakit tungro (virus)',
];

class HasilDeteksi {
  const HasilDeteksi({
    required this.petak,
    required this.kelas,
    required this.skor,
    required this.namaPetugas,
    required this.waktu,
  });

  final String petak;
  final String kelas;
  final double skor;
  final String namaPetugas;
  final DateTime waktu;

  bool get isSehat => kelas == 'Normal / Sehat';

  String get status {
    if (isSehat) return 'Sehat';
    if (skor < 50) return 'Tidak Pasti';
    return 'Perlu Tindakan';
  }

  String get rekomendasi =>
      rekomendasiPenanganan[kelas] ?? 'Cek kondisi tanaman kembali.';
}
