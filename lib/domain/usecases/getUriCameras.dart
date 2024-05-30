import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/core/usecase/usecase.dart';
import 'package:flutter_application_prgrado/domain/repository/device_repository.dart';

class GetUriUseCase implements UseCase<DataState<(Uri, Uri)>, void> {
  final DeviceRepository _sessionRepository;

  GetUriUseCase(this._sessionRepository);

  @override
  DataState<(Uri, Uri)> call({void params}) {
    return _sessionRepository.getUriVideoCameras();
  }
}
