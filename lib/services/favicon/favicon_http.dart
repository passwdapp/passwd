import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:passwd/models/favicon.dart';
import 'package:passwd/services/favicon/favicon_service.dart';

@LazySingleton(as: FaviconService)
class FaviconHttp implements FaviconService {
  @override
  Future<String> getBestFavicon(String url) async {
    try {
      Response response = await Dio().get(
        "https://favicongrabber.com/api/grab/$url",
      ); // URL is actually a domain lol

      if (response.statusCode == 200) {
        FaviconResponse faviconResponse =
            FaviconResponse.fromJson(response.data);

        if (faviconResponse.icons.isEmpty) {
          return "";
        } else {
          List<Icons> filteredIcons = faviconResponse.icons
              .where(
                (element) => element.src.endsWith("png"),
              )
              .toList();

          Icons bestIcon = filteredIcons[0];
          int bestQuality = 0;

          for (Icons element in filteredIcons) {
            if (RegExp("fluid[-_]?icon").hasMatch(element.src)) {
              bestIcon = element;
              break;
            } else if (estimateQuality(element) > bestQuality) {
              bestIcon = element;
            }
          }

          return bestIcon.src;
        }
      } else {
        return "";
      }
    } catch (e) {
      return "";
    }
  }

  int estimateQuality(Icons icon) {
    int sizeRank = estimateSize(icon);
    int relRank = estimateRel(icon.src);
    int extRank = estimateExt(icon.src);

    return ((1920 - sizeRank) << (2 + 1)) + (relRank << 1) + extRank;
  }

  int estimateSize(Icons icon) {
    int rank = 1920;

    if (icon.sizes != null) {
      if (RegExp("any").hasMatch(icon.src)) {
        rank = 144;
      } else {
        RegExpMatch match = RegExp(
          r"(\d+)x(\d+)",
          caseSensitive: false,
        ).firstMatch(icon.sizes);

        if (match != null) {
          int height = int.parse("128x128"
              .substring(match.start, match.end)
              .split(RegExp("x", caseSensitive: false))[0]);

          rank = height.abs();
        }
      }
    } else {
      RegExpMatch match = RegExp(
        r"(\d+)x(\d+)",
        caseSensitive: false,
      ).firstMatch(icon.src);

      if (match != null) {
        int height = int.parse("128x128"
            .substring(match.start, match.end)
            .split(RegExp("x", caseSensitive: false))[0]);

        rank = height.abs();
      }
    }

    return rank;
  }

  int estimateRel(String url) {
    int rank = 0;

    if (RegExp(
      "fluid[-_]?icon",
      caseSensitive: false,
    ).hasMatch(
      url,
    )) {
      rank = 3;
    } else if (RegExp(
      "apple[-_]+(?:touch[-_]+)?icon",
      caseSensitive: false,
    ).hasMatch(
      url,
    )) {
      rank = 2;
    } else if (RegExp(
      "mask[-_]?icon",
      caseSensitive: false,
    ).hasMatch(
      url,
    )) {
      rank = 3;
    }

    return rank;
  }

  int estimateExt(String url) {
    int rank = 0;

    switch (getExtension(url)) {
      case "png":
        rank = 2;
        break;
      default:
        break;
    }

    return rank;
  }

  String getExtension(String url) {
    RegExpMatch match = RegExp(r"\.(\w+)$").firstMatch(url);
    return match == null ? '' : url.substring(match.start, match.end);
  }
}
