class PagedResponse<T> {
  final int page;
  final int totalPages;
  final List<T> results;
  PagedResponse({required this.page, required this.totalPages, required this.results});
}