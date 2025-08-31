import 'package:ie_montrac/models/subscription.dart';

import 'user.dart';

class AuthResponse {
  User? user;
  String? token;
  Subscription? subscription;
  AuthResponse({this.user, this.token, this.subscription});

  //
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
        user: User.fromJson(json["user"]),
        token: json["token"],
        subscription: json["subscription"] != null
            ? Subscription.fromJson(json["subscription"])
            : null);
  }

  Map<String, dynamic> toJson() {
    return {
      "user": user?.toJson(),
      "token": token,
      "subscription": subscription?.toJson()
    };
  }
}
