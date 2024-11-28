class EmailSignUpRequest {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  EmailSignUpRequest(
      {required this.email,
      required this.password,
      required this.firstName,
      required this.lastName});

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName
    };
  }
}
