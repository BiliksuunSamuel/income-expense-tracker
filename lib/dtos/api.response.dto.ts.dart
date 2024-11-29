class ApiResponse {
  dynamic data;
  String? message;
  int? code;
  bool isSuccessful;

  ApiResponse(
      {required this.data,
      required this.message,
      required this.code,
      this.isSuccessful = false});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
        data: json["data"],
        code: json["code"] ?? 400,
        isSuccessful: json["code"] == 200 || json["code"] == 201,
        message: json["message"].runtimeType == Null
            ? null
            : json["message"].runtimeType == String
                ? json["message"]
                : (json["message"] as List<dynamic>)
                    .map((e) => e as String)
                    .toList()
                    .join(","));
  }
}
