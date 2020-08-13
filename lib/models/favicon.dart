class FaviconResponse {
  String domain;
  List<Icons> icons;

  FaviconResponse({this.domain, this.icons});

  FaviconResponse.fromJson(Map<String, dynamic> json) {
    domain = json['domain'];
    if (json['icons'] != null) {
      icons = new List<Icons>();
      json['icons'].forEach((v) {
        icons.add(new Icons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['domain'] = this.domain;
    if (this.icons != null) {
      data['icons'] = this.icons.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['src'] = this.src;
    data['type'] = this.type;
    data['sizes'] = this.sizes;
    return data;
  }
}
