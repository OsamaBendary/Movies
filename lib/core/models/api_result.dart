import 'movie.dart';

class ApiResult {
  final String status;
  final String statusMessage;
  final int movieCount;
  final List<Movie> movies;

  ApiResult({
    required this.status,
    required this.statusMessage,
    required this.movieCount,
    required this.movies,
  });

  factory ApiResult.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;

    final moviesList = (data['movies'] as List<dynamic>)
        .map((movieJson) => Movie.fromJson(movieJson as Map<String, dynamic>))
        .toList();

    return ApiResult(
      status: json['status'] as String,
      statusMessage: json['status_message'] as String,
      movieCount: data['movie_count'] as int,
      movies: moviesList,
    );
  }
}