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

import '../../data/service/auth_service.dart';
import '../../data/service/profile_service.dart';
import '../../presentation/bloc/auth/auth_bloc.dart';
import '../../presentation/bloc/profile/profile_bloc.dart';
import '../../presentation/page/auth/register_page.dart';
import '../../presentation/page/splash/splash.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());

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

      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterPage());

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
