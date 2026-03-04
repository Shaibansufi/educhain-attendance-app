import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/test_blockchain_screen.dart';
import 'services/blockchain_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize BlockchainService
  final blockchainService = BlockchainService();
  await blockchainService.init();

  runApp(MyApp(blockchainService: blockchainService));
}

class MyApp extends StatelessWidget {
  final BlockchainService blockchainService;

  const MyApp({super.key, required this.blockchainService});

  @override
  Widget build(BuildContext context) {
    final routes = {
      '/': (context) => LoginScreen(blockchainService: blockchainService),
      '/register': (context) =>
          RegisterScreen(blockchainService: blockchainService),
      '/test': (context) =>
          TestBlockchainScreen(blockchainService: blockchainService),
    };

    if (Platform.isIOS) {
      return CupertinoApp(
        debugShowCheckedModeBanner: false,
        title: 'EduChain App',
        theme: const CupertinoThemeData(
          primaryColor: CupertinoColors.activeBlue,
        ),
        initialRoute: '/register',
        routes: routes,
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EduChain App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      initialRoute: '/register',
      routes: routes,
    );
  }
}
