class HttpRequestDto {
  final Map<String, dynamic>? data;
  final String? token;
  final Map<String, dynamic>? params;
  final String url;

  HttpRequestDto(this.url, {this.token, this.data, this.params});
}
