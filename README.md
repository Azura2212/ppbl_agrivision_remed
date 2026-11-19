# AgriVision CNN

Aplikasi Flutter simulasi pencatatan hasil deteksi penyakit dan hama padi.
Data disimpan dalam memori aplikasi dan tidak menggunakan API.

## Menjalankan aplikasi

```shell
flutter pub get
flutter run
```

Jalankan pengujian dengan `flutter test` dan pemeriksaan kode dengan
`flutter analyze`.

## Fitur

- Navigasi tab Beranda, Deteksi, Statistik, dan Pengaturan.
- Form hasil deteksi dengan validasi dan konfirmasi sebelum disimpan.
- Riwayat yang dapat difilter berdasarkan petak dan dihapus per entri.
- Statistik jumlah deteksi per kelas menggunakan grafik batang.
- Pembuatan 10 data simulasi serta penghapusan seluruh riwayat.
- Tema terang dan gelap.

## Struktur kode

- `lib/models/`: model hasil deteksi dan rekomendasi penanganan.
- `lib/pages/`: halaman navigasi, input, riwayat, statistik, dan informasi.
- `lib/state/`: state aplikasi menggunakan Provider.
- `lib/widgets/`: kartu statistik dan kartu hasil deteksi.
