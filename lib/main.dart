import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_routes.dart';
import 'pages/halaman_input_deteksi.dart';
import 'pages/halaman_tentang.dart';
import 'pages/kerangka_navigasi.dart';
import 'state/deteksi_model.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => DeteksiModel(),
      child: const AgriVisionApp(),
    ),
  );
}

class AgriVisionApp extends StatelessWidget {
  const AgriVisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DeteksiModel>(
      builder: (context, model, _) => MaterialApp(
        title: 'AgriVision CNN',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: model.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        initialRoute: AppRoutes.beranda,
        routes: {
          AppRoutes.beranda: (_) => const KerangkaNavigasi(),
          AppRoutes.tentang: (_) => const HalamanTentang(),
          AppRoutes.inputDeteksi: (_) => const HalamanInputDeteksi(),
        },
      ),
    );
  }
}
