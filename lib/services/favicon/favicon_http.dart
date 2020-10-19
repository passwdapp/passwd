import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../models/favicon.dart';
import 'favicon_service.dart';

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
                (element) =>
                    element.src.endsWith("png") ||
                    element.src.endsWith("ico") ||
                    (element.type != null && element.type == "image/png") ||
                    (element.type != null && element.type == "image/x-icon"),
              )
              .toList();

          Icons bestIcon = filteredIcons[0];
          int bestQuality = 0;

          for (Icons element in filteredIcons) {
            if (RegExp(r"fluid[-_]?icon").hasMatch(element.src)) {
              bestIcon = element;
              bestQuality = 9999;
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
      if (RegExp("any").hasMatch(icon.sizes)) {
        rank = 100;
      } else {
        RegExpMatch match = RegExp(
          r"(\d+)x(\d+)",
          caseSensitive: false,
        ).firstMatch(icon.sizes);

        if (match != null) {
          int height = 100 -
              int.parse(
                icon.sizes
                    .substring(match.start, match.end)
                    .split(RegExp("x", caseSensitive: false))[0],
                onError: (str) => 10,
              );

          rank = height.abs();
        }
      }
    } else {
      RegExpMatch match = RegExp(
        r"(\d+)x(\d+)",
        caseSensitive: false,
      ).firstMatch(icon.src);

      if (match != null) {
        int height = int.parse(icon.sizes
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
      r"fluid[-_]?icon",
      caseSensitive: false,
    ).hasMatch(
      url,
    )) {
      rank = 3;
    } else if (RegExp(
      r"apple[-_]+(?:touch[-_]+)?icon",
      caseSensitive: false,
    ).hasMatch(
      url,
    )) {
      rank = 2;
    } else if (RegExp(
      r"mask[-_]?icon",
      caseSensitive: false,
    ).hasMatch(
      url,
    )) {
      rank = 1;
    }

    return rank;
  }

  int estimateExt(String url) {
    int rank = 0;

    switch (getExtension(url)) {
      case ".png":
        rank = 2;
        break;
      case ".svg":
        rank = 1;
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
