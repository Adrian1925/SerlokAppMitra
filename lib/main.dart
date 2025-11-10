import 'package:flutter/material.dart';
import 'package:serlok_mitra/presentation/page/wallet/wallet_page.dart';
import 'presentation/page/splash/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serlok Mitra',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        fontFamily: 'PlusJakartaSans',
      ),
      home: const WalletPage(),
    );
  }
}
