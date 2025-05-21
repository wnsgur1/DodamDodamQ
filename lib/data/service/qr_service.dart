
import 'dart:io';

import 'package:dio/dio.dart';

import '../../model/qr_request.dart';
import '../../model/qr_response.dart';

class QrService{
  final Dio _dio;
  QrService(this._dio);

  Future<QrResponse> sendQr(QrRequest request) async {
    try {
      final response = await _dio.post(
        'https://dodamapi.b1nd.com/bus/qr-code/scan', // 실제 API 주소로 수정
        queryParameters: request.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'bus-api-key': 'dfea7f9a-f400-4018-b68d-ac318fcc239d'
          },
        ),
      );

      return QrResponse.fromJson(response.data);
    } on DioException catch (e) {

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.unknown ||
          e.type == DioExceptionType.connectionError ||
          e.error is SocketException) {
        throw '인터넷 연결을 확인해주세요.';
      }
      print("🔗 요청한 URL: ${e.requestOptions.uri}");
      print("📡 응답 코드: ${e.response?.statusCode}");
      print("📨 응답 내용: ${e.response?.data}");
      final statusCode = e.response?.statusCode;
      String errorMessage;
      if (statusCode == 401){
        errorMessage = "재 로그인 해주세요.";
      } else if (statusCode == 403){
        errorMessage = "접근이 거부되었습니다.";
      }else if (statusCode == 404){
        errorMessage = "멤버가 존재하지 않습니다.";
      }else{
        errorMessage = "서버오류가 발생했습니다.";
      }

      throw errorMessage;

    } catch (e) {
      print('Unknown error: $e');
      rethrow;
    }
  }
}