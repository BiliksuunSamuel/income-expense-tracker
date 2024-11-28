class ApiResponse {
  dynamic data;
  String? message;
  int? code;

  ApiResponse({required this.data, required this.message, required this.code});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
        data: json["data"],
        code: json["code"] ?? 400,
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
