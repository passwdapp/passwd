import '../../models/export.dart';

abstract class ExportService {
  Future export(ExportType type);
}
