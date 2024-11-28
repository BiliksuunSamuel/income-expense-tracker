class PagedResults<T> {
  int page;
  int pageSize;
  int totalPages;
  List<T> results;
  int totalCount;

  PagedResults(
      {this.pageSize = 10,
      this.page = 0,
      this.totalCount = 0,
      this.totalPages = 0,
      required this.results});

  factory PagedResults.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    var resultsData = <T>[];
    if (json["results"] != null) {
      resultsData = List<T>.from(
        (json["results"] as List).map((item) => fromJsonT(item)),
      );
    }

    return PagedResults(
      page: json["page"] ?? 0,
      totalCount: json["totalCount"] ?? 0,
      totalPages: json["totalPages"] ?? 0,
      pageSize: json["pageSize"] ?? 10,
      results: resultsData,
    );
  }
}
