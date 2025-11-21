import 'package:dio/dio.dart';
import 'package:movies/core/models/api_result.dart';

class ApiManager{
  static final _dio = Dio(
    BaseOptions(baseUrl: "https://yts.lt/api/v2/")
  );
  
  
  static Future<ApiResult?> getMovieList()async {
    try {
      var response = await _dio.get("list_movies");

      if (response.statusCode == 200) {
        print("Success!");
        print(response.data);
      } else {
        print("Request failed with status: ${response.statusCode}");
      }
    } on DioException catch (e) {
      print("Dio Error: ${e.message}");
      if (e.response != null) {
        print("Response data: ${e.response?.data}");
      }
    } catch (e) {
      print("An unknown error occurred: $e");
    }
  }

  static Future<ApiResult?> getMovieDetails(int id)async {
    try {
      var response = await _dio.get("movie_details",
      queryParameters: {
        "movie_id" : id,
        "with_images" : true,
        "with_cast" : true
      });

      if (response.statusCode == 200) {
        print("Success!");
        print(response.data);
      } else {
        print("Request failed with status: ${response.statusCode}");
      }
    } on DioException catch (e) {
      print("Dio Error: ${e.message}");
      if (e.response != null) {
        print("Response data: ${e.response?.data}");
      }
    } catch (e) {
      // Handle any other unexpected errors
      print("An unknown error occurred: $e");
    }
  }

  static Future<ApiResult?> getMovieSuggestions(int id)async {
    try {
      var response = await _dio.get("movie_suggestions",
          queryParameters: {
            "movie_id" : id
          });

      if (response.statusCode == 200) {
        print("Success!");
        print(response.data);
      } else {
        print("Request failed with status: ${response.statusCode}");
      }
    } on DioException catch (e) {
      print("Dio Error: ${e.message}");
      if (e.response != null) {
        print("Response data: ${e.response?.data}");
      }
    } catch (e) {
      // Handle any other unexpected errors
      print("An unknown error occurred: $e");
    }
  }

}