import 'dart:io';

abstract class PathService {
  Future<Directory> getDocDir();
  Future checkCacheDir();
}
