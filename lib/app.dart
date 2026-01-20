import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/home/home_screen.dart';
import 'screens/catalog/catalog_screen.dart';
import 'screens/calculator/calculator_screen.dart';
import 'screens/order_detail/order_detail_screen.dart';
import 'screens/extra_work/extra_work_screen.dart';
import 'screens/photos/photos_screen.dart';
import 'screens/documents/documents_screen.dart';

class LevneOpravyApp extends StatelessWidget {
  const LevneOpravyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Levné Opravy',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/catalog': (context) => const CatalogScreen(),
        '/calculator': (context) => const CalculatorScreen(),
        '/order-detail': (context) => const OrderDetailScreen(),
        '/extra-work': (context) => const ExtraWorkScreen(),
        '/photos': (context) => const PhotosScreen(),
        '/documents': (context) => const DocumentsScreen(),
      },
    );
  }
}
