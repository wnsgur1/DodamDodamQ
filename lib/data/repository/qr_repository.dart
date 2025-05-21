import '../../model/qr_request.dart';
import '../../model/qr_response.dart';



abstract class QrRepository{
  Future<QrResponse> sendQr(QrRequest request);
}
