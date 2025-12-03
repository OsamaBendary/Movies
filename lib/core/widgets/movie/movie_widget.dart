import 'package:flutter/material.dart';
import 'package:movies/core/models/movie.dart';
import 'package:movies/core/theme/app%20colors/app_colors.dart';
import 'package:movies/modules/layout/pages/movie%20details/pages/movie_details_screen.dart';

class MovieWidget extends StatelessWidget {
  final Movies movie;
  const MovieWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final imageUrl = movie.mediumCoverImage ?? '';

    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailsScreen(movie: movie,),));
      },
      child: Container(
        width: 146,
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,

                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) =>
                  // Use a slightly more prominent error indicator
                  const Center(child: Icon(Icons.broken_image, color: Colors.white70, size: 40)),
                ),

                Positioned(
                  top: 11,
                  left: 9,
                  child: Container(
                    width: 58,
                    height: 28,
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                    decoration: BoxDecoration(
                        color: AppColors.grey.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${movie.rating}",
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        const SizedBox(width: 3),
                        const Icon(Icons.star, color: Colors.yellow, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}