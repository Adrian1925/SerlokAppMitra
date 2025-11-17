import 'package:flutter/material.dart';
import 'package:serlok_mitra/presentation/page/main_page.dart';
import 'package:serlok_mitra/presentation/page/wallet/wallet_bank_confirm_page.dart';
import 'package:serlok_mitra/presentation/page/wallet/wallet_bank_transfer_page.dart';
import 'package:serlok_mitra/presentation/page/wallet/wallet_bank_select_page.dart';
import 'package:serlok_mitra/presentation/page/wallet/wallet_page.dart';
import 'package:serlok_mitra/presentation/page/home/home_page.dart';
import 'package:serlok_mitra/presentation/page/auth/login_page.dart';
import 'package:serlok_mitra/presentation/page/wallet/wallet_va_webview_page.dart';
import 'package:serlok_mitra/presentation/page/wallet/wallet_virtual_account_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/main-tab':
        return MaterialPageRoute(builder: (_) => const MainTabPage());

      case '/home-page':
        return MaterialPageRoute(builder: (_) => const HomePage());

      case '/wallet':
        return MaterialPageRoute(builder: (_) => const WalletPage());

      case '/wallet-bank-transfer':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const WalletBankTransferPage(),
        );

      case '/wallet-bank-select':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const WalletBankSelectPage(),
        );

      case '/wallet-bank-confirm':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const WalletBankConfirmPage(),
        );

      case '/wallet-virtual-account':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const WalletVirtualAccountPage(),
        );

      case '/wallet-va-webview':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const WalletVaWebviewPage(),
        );

      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
