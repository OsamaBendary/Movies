import 'package:movies/core/models/torrent.dart';

class Movie {
  final int id;
  final String title;
  final int year;
  final double rating;
  final int runtime;
  final List<String> genres;
  final String mediumCoverImage;
  final List<Torrent> torrents;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.mediumCoverImage,
    required this.torrents,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      title: json['title_english'] as String,
      year: json['year'] as int,
      rating: (json['rating'] as num).toDouble(),
      runtime: json['runtime'] as int,

      genres: List<String>.from(json['genres'] ?? []),

      mediumCoverImage: json['medium_cover_image'] as String,

      torrents: (json['torrents'] as List<dynamic>?)
          ?.map((t) => Torrent.fromJson(t as Map<String, dynamic>))
          .toList() ?? [],
    );
  }
}