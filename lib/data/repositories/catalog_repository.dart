
import '../models/media.dart';
import '../models/paged_response.dart';
import '../tmdb_api.dart';

class CatalogRepository {
  final TmdbApi _api;
  CatalogRepository(this._api);

  Future<PagedResponse<Media>> trending({int page = 1}) async {
    final res = await _api.get('/trending/all/week', query: {'page': page});
    final data = res.data as Map<String, dynamic>;
    final results = (data['results'] as List)
        .map((e) => Media.fromMap(e as Map<String, dynamic>))
        .where((m) => m.type == MediaType.movie || m.type == MediaType.tv)
        .toList();
    return PagedResponse(page: data['page'], totalPages: data['total_pages'], results: results);
  }

  Future<PagedResponse<Media>> popularMovies({int page = 1}) async {
    final res = await _api.get('/movie/popular', query: {'page': page});
    final data = res.data as Map<String, dynamic>;
    final results = (data['results'] as List)
        .map((e) => Media.fromMap({...e as Map<String, dynamic>, 'media_type': 'movie'}))
        .toList();
    return PagedResponse(page: data['page'], totalPages: data['total_pages'], results: results);
  }

  Future<PagedResponse<Media>> popularTv({int page = 1}) async {
    final res = await _api.get('/tv/popular', query: {'page': page});
    final data = res.data as Map<String, dynamic>;
    final results = (data['results'] as List)
        .map((e) => Media.fromMap({...e as Map<String, dynamic>, 'media_type': 'tv'}))
        .toList();
    return PagedResponse(page: data['page'], totalPages: data['total_pages'], results: results);
  }

  Future<PagedResponse<Media>> searchMulti(String query, {int page = 1}) async {
    final res = await _api.get('/search/multi', query: {'query': query, 'page': page, 'include_adult': false});
    final data = res.data as Map<String, dynamic>;
    final results = (data['results'] as List)
        .map((e) => Media.fromMap(e as Map<String, dynamic>))
        .where((m) => m.type == MediaType.movie || m.type == MediaType.tv)
        .toList();
    return PagedResponse(page: data['page'], totalPages: data['total_pages'], results: results);
  }
}
