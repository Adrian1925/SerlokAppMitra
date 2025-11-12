import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../widgets/wallet/wallet_primary_button.dart';

class WalletVaWebviewPage extends StatefulWidget {
  const WalletVaWebviewPage({super.key});

  @override
  State<WalletVaWebviewPage> createState() => _WalletVaWebviewPageState();
}

class _WalletVaWebviewPageState extends State<WalletVaWebviewPage> {
  late final WebViewController _webController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            setState(() => _isLoading = false);
          },
        ),
      )
      // sementara pakai url google nanti ganti ke midtrans
      ..loadRequest(Uri.parse('https://www.google.com'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Virtual Account', style: AppTextStyles.semi18),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.3,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _webController),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.violet,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: WalletPrimaryButton(
            backgroundColor: AppColors.redAlert,
            text: 'Batalkan Transaksi',
            enabled: true,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
