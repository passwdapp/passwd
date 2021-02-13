import 'dart:io';

abstract class PathService {
  Future<Directory> getDocDir();
  Future checkCacheDir();
  Future<Directory> getExternalDirectory();
  Future<Directory> getTempDir();
}
