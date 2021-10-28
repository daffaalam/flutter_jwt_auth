import 'dart:convert';

class AuthToken {
  AuthToken({
    this.code,
    this.message,
    this.data,
    this.token,
    this.userEmail,
    this.userNicename,
    this.userDisplayName,
  });

  String? code;
  String? message;
  Data? data;
  String? token;
  String? userEmail;
  String? userNicename;
  String? userDisplayName;

  factory AuthToken.fromJson(String str) => AuthToken.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthToken.fromMap(Map<String, dynamic> json) => AuthToken(
        code: json["code"],
        message: json["message"],
        data: Data.fromMap(json["data"] ?? {}),
        token: json["token"],
        userEmail: json["user_email"],
        userNicename: json["user_nicename"],
        userDisplayName: json["user_display_name"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "message": message,
        "data": data?.toMap(),
        "token": token,
        "user_email": userEmail,
        "user_nicename": userNicename,
        "user_display_name": userDisplayName,
      };
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

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
      };
}
