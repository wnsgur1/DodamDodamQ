import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/qr_status.dart';
import '../view_model/main_view_model.dart';
import '../widget/dodam_topApp_bar.dart';
import '../widget/qr_scanner.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewModel>();

    void onQrScanned(String code) async {
      final jsonMap = jsonDecode(code);
      final memberId = jsonMap['memberId'];
      final nonce = jsonMap['nonce'];
      print("1123 $jsonMap");
      print("1123 $memberId");
      print("1123 $nonce");

      if (memberId != null && nonce != null) {
        await viewModel.handleQrScan(memberId, nonce);

        final message = viewModel.message ?? '응답 없음';
        final status = viewModel.status;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              status == QrScanStatus.SUCCESS ? '✅ $message' : '❌ $message',
              style: const TextStyle(fontSize: 16),
            ),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );

        viewModel.reset();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('❌ 잘못된 QR 코드입니다.'),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          QrScanner(onScan: onQrScanned),
          Positioned(
            left: 0,
            right: 0,
            child: const DodamTopAppBar(title: 'QR 스캔', description: 'QR코드는 버스좌석 선택시 확인할 수 있습니다.'),
          ),
        ],
      ),
    );
  }
}
