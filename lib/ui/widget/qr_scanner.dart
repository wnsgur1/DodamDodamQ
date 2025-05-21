import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends StatefulWidget {
  final void Function(String code) onScan;

  const QrScanner({super.key, required this.onScan});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool _canScan = true;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) controller?.pauseCamera();
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.blueAccent,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: 250,
      ),
    );
  }

  // void flipCamera() {
  //   controller?.flipCamera();
  // }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) async {
      if (!_canScan) return;
      _canScan = false;

      final code = scanData.code;
      if (code == null) {
        _canScan = true;
        return;
      }

      final jsonMap = jsonDecode(code);
      final memberId = jsonMap['memberId'];
      final nonce = jsonMap['nonce'];

      if (memberId != null && nonce != null) {

        widget.onScan(code);
      } else {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ 잘못된 QR 형식입니다.')),
        );
      }

      await Future.delayed(const Duration(seconds: 8));
      _canScan = true;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
