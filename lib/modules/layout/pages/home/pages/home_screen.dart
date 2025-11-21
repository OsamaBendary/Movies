import 'package:flutter/material.dart';
import 'package:movies/core/apis/api%20manager/api_manager.dart';

import '../../../../../core/models/api_result.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiResult? _movieData;
  bool _isLoading = true;

  @override
  void initState() {
    _fetchMovies();
    super.initState();
  }

  void _fetchMovies() async {
    final result = await ApiManager.getMovieList();

    setState(() {
      _movieData = result;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_movieData == null || _movieData!.movies.isEmpty) {
      return const Center(child: Text('No movies found.'));
    }

    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Home (1).png"),
              fit: BoxFit.cover
          )
      ),
      child: ListView.builder(
        itemCount: _movieData!.movies.length,
        itemBuilder: (context, index) {
          final movie = _movieData!.movies[index];
          return ListTile(title: Text(movie.title));
        },
      ),
    );
  }
}