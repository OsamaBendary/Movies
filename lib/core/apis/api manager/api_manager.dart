import 'package:dio/dio.dart';
import 'package:movies/core/models/api_result.dart';

import '../../models/movie.dart';
import '../../models/movie_details.dart';

class ApiManager{
  static final _dio = Dio(
    BaseOptions(baseUrl: "https://yts.lt/api/v2/")
  );


  static Future<ApiResult?> getMovieList() async {
    try {
      var response = await _dio.get("list_movies.json");

      if (response.statusCode == 200 && response.data != null) {
        return ApiResult.fromJson(response.data);
      }

      return null;

    } on DioException catch (e) {
      // ... error handling
      return null;
    } catch (e) {
      // ... error handling
      return null;
    }
  }

  static Future<MovieDetails?> getMovieDetails(int id) async {
    try {
      var response = await _dio.get(
        "movie_details.json",
        queryParameters: {
          "movie_id": id,
          "with_images": true,
          "with_cast": true,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return MovieDetails.fromJson(response.data);
      }

      return null;
    } catch (e) {
      print("Error fetching movie details: $e");
      return null;
    }
  }



  static Future<ApiResult?> getMovieSuggestions(int id) async {
    try {
      var response = await _dio.get(
        "movie_suggestions.json",
        queryParameters: {"movie_id": id},
      );

      if (response.statusCode == 200 && response.data != null) {
        print("Success!");
        print(response.data);
        return ApiResult?.fromJson(response.data);
      } else {
        print("Request failed with status: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print("Dio Error: ${e.message}");
      if (e.response != null) {
        print("Response data: ${e.response?.data}");
      }
      return null;
    } catch (e) {
      print("An unknown error occurred: $e");
      return null;
    }
  }


}