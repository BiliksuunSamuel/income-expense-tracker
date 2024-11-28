import 'user.dart';

class AuthResponse {
  User? user;
  String? token;
  AuthResponse({this.user, this.token});

  //
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
        user: User.fromJson(json["user"]), token: json["token"]);
  }

  Map<String, dynamic> toJson() {
    return {"user": user?.toJson(), "token": token};
  }
}
