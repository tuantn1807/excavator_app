class PaginatedResponse<T> {
  final int currentPage;
  final List<T> data;
  final int lastPage;
  final int perPage;
  final int total;

  PaginatedResponse({
    required this.currentPage,
    required this.data,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginatedResponse<T>(
      currentPage: json['current_page'] ?? 1,
      data: (json['data'] as List).map((item) => fromJsonT(item)).toList(),
      lastPage: json['last_page'] ?? 1,
      perPage: json['per_page'] ?? 15,
      total: json['total'] ?? 0,
    );
  }
}
