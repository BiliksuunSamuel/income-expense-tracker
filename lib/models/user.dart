class User {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? updatedBy;
  final String? createdBy;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final bool? isLoggedIn;
  final String? picture;
  final String? status;
  final bool? isGoogleAuth;
  final bool authenticated;
  final bool resetPassword;
  final DateTime? otpExpiryTime;

  User(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.updatedBy,
      this.createdBy,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.isLoggedIn,
      this.picture,
      this.status,
      this.isGoogleAuth,
      this.authenticated = false,
      this.resetPassword = false,
      this.otpExpiryTime});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'] as String?,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null,
        updatedBy: json['updatedBy'] as String?,
        createdBy: json['createdBy'] as String?,
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        email: json['email'] as String?,
        phoneNumber: json['phoneNumber'] as String?,
        isLoggedIn: json['isLoggedIn'] as bool?,
        picture: json['picture'] as String?,
        status: json['status'] as String?,
        isGoogleAuth: json['isGoogleAuth'] as bool?,
        authenticated: json["authenticated"] as bool,
        resetPassword: json["resetPassword"],
        otpExpiryTime: json["otpExpiryTime"] != null
            ? DateTime.parse(json["otpExpiryTime"])
            : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'updatedBy': updatedBy,
      'createdBy': createdBy,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'isLoggedIn': isLoggedIn,
      'picture': picture,
      'status': status,
      'isGoogleAuth': isGoogleAuth,
      "authenticated": authenticated,
      "resetPassword": resetPassword,
      "otpExpiryTime": otpExpiryTime?.toIso8601String()
    };
  }
}
