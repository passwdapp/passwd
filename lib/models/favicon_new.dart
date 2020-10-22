/// [FaviconResponse] holds the favicons while they are fetched and compared
/// These are never persisted to the disk
/// It is also used to deserialize the JSON API response
class FaviconResponse {
  String url;
  List<Icons> icons;

  FaviconResponse({
    this.url,
    this.icons,
  });

  FaviconResponse.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    if (json['icons'] != null) {
      icons = <Icons>[];
      json['icons'].forEach((v) {
        icons.add(Icons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    if (icons != null) {
      data['icons'] = icons.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Icons {
  String url;
  int width;
  int height;
  String format;
  int bytes;
  Null error;
  String sha1sum;

  Icons({
    this.url,
    this.width,
    this.height,
    this.format,
    this.bytes,
    this.error,
    this.sha1sum,
  });

  Icons.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
    format = json['format'];
    bytes = json['bytes'];
    error = json['error'];
    sha1sum = json['sha1sum'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['url'] = url;
    data['width'] = width;
    data['height'] = height;
    data['format'] = format;
    data['bytes'] = bytes;
    data['error'] = error;
    data['sha1sum'] = sha1sum;
    return data;
  }
}
