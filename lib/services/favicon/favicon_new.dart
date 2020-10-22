import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../models/favicon_new.dart';
import 'favicon_service.dart';

/// [FaviconHttp] uses "https://besticon-demo.herokuapp.com/allicons.json" to extract favicons for a domain
/// It implements the [FaviconService]
@LazySingleton(as: FaviconService)
class FaviconNew implements FaviconService {
  @override
  Future<String> getBestFavicon(String url) async {
    try {
      final response = await Dio().get(
        'https://besticon-demo.herokuapp.com/allicons.json?url=$url&formats=png,ico,gif',
      );

      if (response.statusCode != 200) {
        return '';
      }

      final deserailizedIcons = FaviconResponse.fromJson(response.data);

      if (deserailizedIcons.icons.isEmpty) {
        return '';
      }
      return deserailizedIcons.icons.first.url;
    } catch (e) {
      print(e);

      return '';
    }
  }
}
