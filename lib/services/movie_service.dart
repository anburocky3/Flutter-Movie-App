import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_spot/model/movie.dart';
import 'package:movie_spot/services/http_service.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;

  late HttpService _http;

  MovieService() {
    _http = getIt.get<HttpService>();
  }

  Future<List<Movie>?> getPopularMovies({int? page}) async {
    Response? _response = await _http.get('/movie/popular', query: {
      'page': page,
    });

    if (_response!.statusCode == 200) {
      Map _data = _response.data;
      List<Movie>? _movies = _data['results'].map<Movie>((_movieData) {
        return Movie.fromJson(_movieData);
      }).toList();
      return _movies;
    } else {
      throw Exception("Couldn\'t load popular movies.");
    }
  }

  Future<List<Movie>?> getUpcomingMovies({int? page}) async {
    Response? _response = await _http.get('/movie/upcoming', query: {
      'page': page,
    });
    if (_response!.statusCode == 200) {
      Map _data = _response.data;
      List<Movie>? _movies = _data['results'].map<Movie>((_movieData) {
        return Movie.fromJson(_movieData);
      }).toList();
      return _movies;
    } else {
      throw Exception("Couldn't load upcoming movies.");
    }
  }

  Future<List<Movie>?> searchMovies(String? _searchTerm, {int? page}) async {
    Response? _response = await _http.get('/search/movie', query: {
      'query': _searchTerm,
      'page': page,
    });
    if (_response!.statusCode == 200) {
      Map _data = _response.data;
      List<Movie>? _movies = _data['results'].map<Movie>((_movieData) {
        return Movie.fromJson(_movieData);
      }).toList();
      return _movies;
    } else {
      throw Exception("Couldn't perform movies search.");
    }
  }
}
