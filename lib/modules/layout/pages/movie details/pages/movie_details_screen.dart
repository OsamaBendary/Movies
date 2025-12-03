import 'package:flutter/material.dart';
import 'package:movies/core/theme/app%20colors/app_colors.dart';
import 'package:movies/core/widgets/custom_button/custom_button.dart';
import 'package:movies/core/widgets/movie/movie_widget.dart';
import '../../../../../core/apis/api manager/api_manager.dart';
import '../../../../../core/models/api_result.dart';
import '../../../../../core/models/movie.dart';
import '../../../../../core/models/movie_details.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movies movie;

  MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  MovieDetails? _movieDetails;
  ApiResult? _movieData;

  bool _isLoading = true;
  bool _isSuggestionsLoading = true;


  @override
  void initState() {
    _fetchMovieDetails();
    _fetchMovieSugg();
    super.initState();
  }

  void _fetchMovieDetails() async {
    final result = await ApiManager.getMovieDetails(widget.movie.id);

    setState(() {
      _movieDetails = result;
      _isLoading = false;
    });
  }

  void _fetchMovieSugg() async {
    final sugResult = await ApiManager.getMovieSuggestions(widget.movie.id);

    setState(() {
      _movieData = sugResult;
      _isSuggestionsLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final movieDetails = _movieDetails ?? MovieDetails();
    final moviesSugg = _movieData?.movies?? [];

    final castList = movieDetails.data?.movie?.cast;
    final hasCast = castList != null && castList.isNotEmpty;


    return Scaffold(
      backgroundColor: AppColors.black,

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(
              height: 550,

              width: double.infinity,

              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      widget.movie.mediumCoverImage ?? '',

                      fit: BoxFit.cover,

                      errorBuilder: (context, error, stackTrace) =>
                          Container(color: AppColors.black),
                    ),
                  ),

                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,

                          end: Alignment.bottomCenter,

                          colors: [
                            Colors.transparent,

                            AppColors.black.withValues(
                              alpha: 0.1,
                            ),

                            AppColors.black.withValues(
                              alpha: 0.7,
                            ),

                            AppColors.black,
                          ],

                          stops: const [0.0, 0.4, 0.7, 1.0],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 30,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },

                            child: Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.white,
                              size: 30,
                            ),
                          ),

                          Icon(
                            Icons.bookmark,
                            color: AppColors.white,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),


                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        const SizedBox(height: 130),

                        IconButton(
                          onPressed: () {},
                          icon: Image.asset("assets/icons/play.png"),
                        ),

                        const SizedBox(height: 188),

                        Text(
                          movieDetails.data?.movie?.titleLong?? "",
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 15),

                        Text(
                          widget.movie.year.toString(),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  CustomButton(
                    color: AppColors.red,
                    text: "Watch",
                    textColor: AppColors.white,
                    onPressed: () {},
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [
                      Container(
                        height: 47,

                        width: 122,

                        decoration: BoxDecoration(
                          color: AppColors.grey.withValues(alpha: 0.7),

                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Image.asset("assets/icons/Heart.png", scale: 0.7, color: AppColors.yellow,),

                            const SizedBox(width: 14),

                            Text(
                              '${movieDetails.data?.movie?.likeCount ?? 0}',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        height: 47,

                        width: 122,

                        decoration: BoxDecoration(
                          color: AppColors.grey.withValues(alpha: 0.7),

                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Icon(
                              Icons.access_time_filled,
                              color: AppColors.yellow,
                              size: 28,
                            ),

                            const SizedBox(width: 14),

                            Text(
                              '${movieDetails.data?.movie?.runtime ?? 0}',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        height: 47,

                        width: 122,

                        decoration: BoxDecoration(
                          color: AppColors.grey.withValues(alpha: 0.7),

                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColors.yellow,
                              size: 28,
                            ),

                            const SizedBox(width: 14),

                            Text(
                              '${movieDetails.data?.movie?.rating ?? 0}',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Screen Shots", style: TextStyle(
                        color: AppColors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),

                      const SizedBox(height: 8,),

                      Container(
                        width: double.infinity,
                        height: 167,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(image: NetworkImage(movieDetails.data?.movie?.screenShot1??""), fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(height: 14,),
                      Container(
                        width: double.infinity,
                        height: 167,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(image: NetworkImage(movieDetails.data?.movie?.screenShot2??""), fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(height: 14,),
                      Container(
                        width: double.infinity,
                        height: 167,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(image: NetworkImage(movieDetails.data?.movie?.screenShot3??""), fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(height: 16,),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Similar", style: TextStyle(
                            color: AppColors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),),

                          const SizedBox(height: 16,),

                          if (_isSuggestionsLoading)
                            const Center(child: CircularProgressIndicator())
                          else if (moviesSugg.isEmpty)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 0.0),
                              child: Text("No suggestions found", style: TextStyle(color: Colors.white)),
                            )
                          else
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 0.7,
                              ),
                              itemCount: moviesSugg.length,
                              itemBuilder: (context, index) {
                                final movie = moviesSugg[index];
                                return MovieWidget(movie: movie);
                              },
                            ),
                        ],
                      ),

                      const SizedBox(height: 16,),


                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Summery", style: TextStyle(
                            color: AppColors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),),

                          const SizedBox(height: 8,),

                          Text(
                            movieDetails.data?.movie?.descriptionFull ?? "No summary available.",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16,),

                      if (hasCast)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Cast", style: TextStyle(
                              color: AppColors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),),
                            const SizedBox(height: 3,),


                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: castList!.length,
                              itemBuilder: (context, index) {
                                final castMember = castList[index];
                                final imageUrl = castMember.urlSmallImage ?? '';

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Container(
                                    height: 92,
                                    decoration: BoxDecoration(
                                      color: AppColors.grey.withValues(alpha: 0.9),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      children: [
                                        if (imageUrl.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: Image.network(
                                                imageUrl,
                                                width: 60,
                                                height: 76,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) => Container(width: 60, height: 76, color: Colors.blueGrey),
                                              ),
                                            ),
                                          )
                                        else
                                          const SizedBox(width: 16),

                                        const SizedBox(width: 4),

                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  castMember.name ?? 'Unknown Actor',
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 16
                                                  )
                                              ),
                                              Text(
                                                  castMember.characterName ?? 'N/A Role',
                                                  style: const TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 14
                                                  )
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),

                      if (!hasCast && !_isLoading)
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "No cast information available.",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),


                      const SizedBox(height: 32,),
                    ],
                  ),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}