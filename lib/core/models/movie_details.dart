// File: movie_details_model.dart

class MovieDetails {
  final String? status;
  final String? statusMessage;
  final Data? data;

  MovieDetails({
    this.status,
    this.statusMessage,
    this.data,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      status: json['status'] as String?,
      statusMessage: json['status_message'] as String?,
      data: json['data'] != null ? Data.fromJson(json['data'] as Map<String, dynamic>) : null,
    );
  }
}

class Data {
  final Movie? movie;

  Data({this.movie});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      movie: json['movie'] != null ? Movie.fromJson(json['movie'] as Map<String, dynamic>) : null,
    );
  }
}

class Movie {
  final num? id;
  final String? url;
  final String? imdbCode;
  final String? title;
  final String? titleLong;
  final num? year;
  final num? rating;
  final num? runtime;
  final List<String>? genres;
  final num? likeCount;
  final String? descriptionFull;
  final String? ytTrailerCode;
  final String? language;
  final String? backgroundImage;
  final String? mediumCoverImage;
  final String? screenShot1;
  final String? screenShot2;
  final String? screenShot3;
  final List<Cast>? cast;

  Movie({
    this.id,
    this.url,
    this.imdbCode,
    this.title,
    this.titleLong,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.likeCount,
    this.descriptionFull,
    this.ytTrailerCode,
    this.language,
    this.backgroundImage,
    this.mediumCoverImage,
    this.cast,
    this.screenShot1,
    this.screenShot2,
    this.screenShot3,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? genresJson = json['genres'] as List<dynamic>?;
    final List<dynamic>? castJson = json['cast'] as List<dynamic>?;

    return Movie(
      id: json['id'] as num?,
      url: json['url'] as String?,
      imdbCode: json['imdb_code'] as String?,
      title: json['title'] as String?,
      titleLong: json['title_long'] as String?,
      year: json['year'] as num?,
      rating: json['rating'] as num?,
      runtime: json['runtime'] as num?,
      genres: genresJson?.map((e) => e.toString()).toList(),
      likeCount: json['like_count'] as num?,
      descriptionFull: json['description_full'] as String?,
      ytTrailerCode: json['yt_trailer_code'] as String?,
      language: json['language'] as String?,
      backgroundImage: json['background_image'] as String?,
      mediumCoverImage: json['medium_cover_image'] as String?,
      screenShot1: json['medium_screenshot_image1'] as String?,
      screenShot2: json['medium_screenshot_image2'] as String?,
      screenShot3: json['medium_screenshot_image3'] as String?,
      cast: castJson?.map((v) => Cast.fromJson(v as Map<String, dynamic>)).toList(),
    );
  }
}

class Cast {
  final String? name;
  final String? characterName;
  final String? urlSmallImage;
  final String? imdbCode;

  Cast({
    this.name,
    this.characterName,
    this.urlSmallImage,
    this.imdbCode,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      name: json['name'] as String?,
      characterName: json['character_name'] as String?,
      urlSmallImage: json['url_small_image'] as String?,
      imdbCode: json['imdb_code'] as String?,
    );
  }
}
