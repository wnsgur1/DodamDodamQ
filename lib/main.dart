import 'package:dodamdodam_q/ui/screen/main_screen.dart';
import 'package:dodamdodam_q/ui/view_model/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'data/repository/qr_repository_impl.dart';
import 'data/service/qr_service.dart';

void main() {
  final dio = Dio();
  final service = QrService(dio);
  final repository = QrRepositoryImpl(service);

  runApp(
    ChangeNotifierProvider(
      create: (_) => MainViewModel(repository),
      child: const MaterialApp(
        home: MainScreen(),
      ),
    ),
  );
}