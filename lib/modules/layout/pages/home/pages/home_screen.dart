import 'package:flutter/material.dart';
import 'package:movies/core/apis/api%20manager/api_manager.dart';
import 'package:movies/core/widgets/movie/movie_widget.dart';
import '../../../../../core/models/api_result.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiResult? _movieData;
  bool _isLoading = true;
  late final PageController _pageController;
  double _currentPage = 0;

  static const double _scaleFactor = 0.8;
  static const double _viewHeight = 360;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.7);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
    _fetchMovies();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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

    final movies = _movieData!.movies;

    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/Home (1).png"),
                  fit: BoxFit.cover)),
        ),

        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 80),

              SizedBox(
                height: _viewHeight,
                child: Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      double scale = 1;
                      double offset = 0.0;
                  
                      if (index != _currentPage.floor()) {
                        var distance = (index - _currentPage).abs();
                        scale = 1.0 - (distance * (0.9 - _scaleFactor));
                        offset = distance * 20.0;
                      }
                  
                      final movie = movies[index];
                  
                      return Transform.scale(
                        scale: scale,
                        child: Padding(
                          padding: EdgeInsets.only(top: offset),
                          child: MovieWidget(movie: movie),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 80),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ],
    );
  }
}