import 'package:agrivision_remed_707012400042/main.dart';
import 'package:agrivision_remed_707012400042/state/deteksi_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('navigasi tab, data simulasi, dan grafik dapat digunakan',
      (tester) async {
    final model = DeteksiModel();
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: model,
        child: const AgriVisionApp(),
      ),
    );

    expect(find.text('Selamat Datang di AgriVision CNN'), findsOneWidget);

    await tester.tap(find.text('Deteksi').last);
    await tester.pumpAndSettle();
    expect(find.text('Riwayat Deteksi'), findsOneWidget);
    expect(find.text('Belum ada data'), findsOneWidget);

    await tester.tap(find.text('Pengaturan').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Muat Data Simulasi'));
    await tester.pump();
    expect(model.hasil, hasLength(10));

    await tester.tap(find.text('Statistik').last);
    await tester.pumpAndSettle();
    expect(find.text('Deteksi per Kelas'), findsOneWidget);
  });
}
