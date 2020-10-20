/// [FaviconResponse] holds the favicons while they are fetched and compared
/// These are never persisted to the disk
/// It is also used to deserialize the JSON API response
class FaviconResponse {
  String domain;
  List<Icons> icons;

  FaviconResponse({this.domain, this.icons});

  FaviconResponse.fromJson(Map<String, dynamic> json) {
    domain = json['domain'];
    if (json['icons'] != null) {
      icons = <Icons>[];
      json['icons'].forEach((v) {
        icons.add(Icons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['domain'] = domain;
    if (icons != null) {
      data['icons'] = icons.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/// [Icons] stores a single favicon, while [FaviconResponse] holds a list of [Icons]
class Icons {
  String src;
  String type;
  String sizes;

  Icons({this.src, this.type, this.sizes});

  Icons.fromJson(Map<String, dynamic> json) {
    src = json['src'];
    type = json['type'];
    sizes = json['sizes'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['src'] = src;
    data['type'] = type;
    data['sizes'] = sizes;
    return data;
  }
}
