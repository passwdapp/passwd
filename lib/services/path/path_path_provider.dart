import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:passwd/services/path/path_service.dart';
import 'package:path_provider/path_provider.dart';

@LazySingleton(as: PathService)
class PathPathProvider implements PathService {
  @override
  Future<Directory> getDocDir() async {
    return (await getApplicationDocumentsDirectory());
  }

  @override
  Future checkCacheDir() async {
    if (!Platform.isAndroid || !Platform.isIOS) {
      Directory directory = await getTemporaryDirectory();

      if (!(await directory.exists())) {
        await directory.create(recursive: true);
      }
    }
  }
}
