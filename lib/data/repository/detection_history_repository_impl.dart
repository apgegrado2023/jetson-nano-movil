import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_application_prgrado/core/resources/data_state.dart';
import 'package:flutter_application_prgrado/core/resources/http_state.dart';
import 'package:flutter_application_prgrado/data/data_sources/remote/detection/detection_api_service.dart';
import 'package:flutter_application_prgrado/domain/entities/detection_history.dart';
import 'package:flutter_application_prgrado/domain/repository/detection_history_repository.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:archive/archive.dart';
import 'package:path/path.dart' as path;

class DetectionHistoryRepositoryImpl implements DetectionHistoryRepository {
  DetectionHistoryRepositoryImpl(
    this._detectionApiService,
  );
  final DetectionApiService _detectionApiService;

  @override
  Future<DataState<List<DetectionHistoryEntity>>> getDetectionHistory() async {
    final httpState = await _detectionApiService.getDetectionHistory();
    if (httpState is HttpSuccess) {
      final listPath =
          httpState.httpResponse!.data.expand((e) => e.listPath!).toList();
      final appDocPath = await getDirectoryPath();
      final listNamesSaveImg = await getListImgSave(appDocPath);

      final imagesNoContains =
          searchImagesSaveNames(listPath, listNamesSaveImg);
      if (imagesNoContains.isNotEmpty) {
        await getImageUrl(imagesNoContains);
      }
      var list = httpState.httpResponse!.data;
      list.forEach((objeto) {
        objeto.setListPath =
            objeto.listPath!.map((e) => path.join(appDocPath, e)).toList();
      });
      return DataSuccess(httpState.httpResponse!.data);
    } else {
      return DataFailed2(httpState.error!);
    }
  }

  Future<void> getImage() async {}

  @override
  Future<DataState<bool>> getImageUrl(List<String> listNameFile) async {
    final httpState = await _detectionApiService.getImagesZip(listNameFile);
    if (httpState is HttpSuccess) {
      final zipBytes = httpState.httpResponse!.data;

      Archive archive = ZipDecoder().decodeBytes(Uint8List.fromList(zipBytes));
      final String appDocPath = await getDirectoryPath();

      Directory imagesDirectory = Directory(appDocPath);

      if (!imagesDirectory.existsSync()) {
        print('se crea el directorio');
        imagesDirectory.createSync();
      }

      for (ArchiveFile file in archive.files) {
        String filePath = '$appDocPath/${file.name}';
        File(filePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(file.content as Uint8List);
      }

      print('Imágenes descomprimidas y guardadas en: $appDocPath');
      //final listNamesSaveImg = await getListImgSave(extractedImagesPath);

      return DataSuccess(true);
    } else {
      return DataFailed2(httpState.error!);
    }
  }

  Future<String> getDirectoryPath() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    final String filePath = path.join(appDocPath, 'imagenes_detection');

    return filePath;
  }

  List<String> searchImagesSaveNames(
      List<String> namesSearch, List<String> listImgSave) {
    return namesSearch
        .where((nombre) => !listImgSave.contains(nombre))
        .toList();
  }

  Future<List<String>> getListImgSave(String appDocPath) async {
    List<String> localFileNames = [];
    //final appDocPath = await getDirectoryPath();

    Directory imagesDirectory = Directory(appDocPath);

    if (!imagesDirectory.existsSync()) {
      print('se crea el directorio');
      imagesDirectory.createSync();
    }

    final List<FileSystemEntity> fileList = imagesDirectory.listSync();

    localFileNames = fileList
        .whereType<File>()
        .map((file) => file.uri.pathSegments.last)
        .toList();
    print(localFileNames);
    return localFileNames;
  }

  Future<List<String>> _saveImagesToLocal(List<Uint8List> images) async {
    final String appDocPath = await getDirectoryPath();
    List<String> listPath = [];
    for (int i = 0; i < images.length; i++) {
      final String fileName = '$i.png';
      final String filePath = path.join(appDocPath, fileName);

      await File(filePath).writeAsBytes(images[i]);
      listPath.add(filePath);
    }
    return listPath;
  }
}
