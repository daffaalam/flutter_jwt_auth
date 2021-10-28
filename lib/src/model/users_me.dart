import 'dart:convert';

class UsersMe {
  UsersMe({
    this.code,
    this.message,
    this.data,
    this.id,
    this.name,
    this.url,
    this.description,
    this.link,
    this.slug,
    this.meta,
    this.links,
  });

  String? code;
  String? message;
  Data? data;
  int? id;
  String? name;
  String? url;
  String? description;
  String? link;
  String? slug;
  List<dynamic>? meta;
  Links? links;

  factory UsersMe.fromJson(String str) {
    return UsersMe.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory UsersMe.fromMap(Map<String, dynamic> json) {
    return UsersMe(
      code: json["code"],
      message: json["message"],
      data: Data.fromMap(json["data"] ?? {}),
      id: json["id"],
      name: json["name"],
      url: json["url"],
      description: json["description"],
      link: json["link"],
      slug: json["slug"],
      meta: List<dynamic>.from(json["meta"]?.map((x) => x) ?? []),
      links: Links.fromMap(json["_links"] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "code": code,
      "message": message,
      "data": data?.toMap(),
      "id": id,
      "name": name,
      "url": url,
      "description": description,
      "link": link,
      "slug": slug,
      "meta": List<dynamic>.from(meta?.map((x) => x) ?? []),
      "_links": links?.toMap(),
    };
  }

  @override
  String toString() {
    JsonEncoder encoder = const JsonEncoder.withIndent('    ');
    return encoder.convert(toMap());
  }
}

class Data {
  Data({
    this.status,
  });

  int? status;

  factory Data.fromJson(String str) {
    return Data.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory Data.fromMap(Map<String, dynamic> json) {
    return Data(
      status: json["status"],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "status": status,
    };
  }
}

class Links {
  Links({
    this.self,
    this.collection,
  });

  List<Collection>? self;
  List<Collection>? collection;

  factory Links.fromJson(String str) {
    return Links.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory Links.fromMap(Map<String, dynamic> json) {
    return Links(
      self: List<Collection>.from(
        json["self"]?.map((x) => Collection.fromMap(x)) ?? [],
      ),
      collection: List<Collection>.from(
        json["collection"]?.map((x) => Collection.fromMap(x)) ?? [],
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "self": List<dynamic>.from(
        self?.map((x) => x.toMap()) ?? [],
      ),
      "collection": List<dynamic>.from(
        collection?.map((x) => x.toMap()) ?? [],
      ),
    };
  }
}

class Collection {
  Collection({
    this.href,
  });

  String? href;

  factory Collection.fromJson(String str) {
    return Collection.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory Collection.fromMap(Map<String, dynamic> json) {
    return Collection(
      href: json["href"],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "href": href,
    };
  }
}
