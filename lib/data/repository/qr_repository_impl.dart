import 'package:dodamdodam_q/data/repository/qr_repository.dart';
import 'package:dodamdodam_q/data/service/qr_service.dart';
import 'package:dodamdodam_q/model/qr_request.dart';
import '../../model/qr_response.dart';


class QrRepositoryImpl implements QrRepository{
  final QrService _qrService;
  QrRepositoryImpl(this._qrService);


  @override
  Future<QrResponse> sendQr(QrRequest request) async {
    final response = await _qrService.sendQr(request);
    return response;
  }

}