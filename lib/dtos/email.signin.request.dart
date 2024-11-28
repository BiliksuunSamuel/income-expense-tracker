class EmailSignInRequest {
  final String email;
  final String password;

  EmailSignInRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {"email": email, "password": password};
  }
}
