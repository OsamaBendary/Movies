class Pages{
  String image;
  String text1;
  String text2;

  Pages({required this.text1, required this.image, required this.text2});

  static List<Pages> pages = [
    Pages(image: "assets/images/1.png", text1: "Discover Movies", text2: "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease."),
    Pages(image: "assets/images/2.png", text1: "Explore All Genres", text2: "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day."),
    Pages(image: "assets/images/3.png", text1: "Create Watchlists", text2: "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres."),
    Pages(image: "assets/images/4.png", text1: "Rate, Review, and Learn", text2: "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews."),
    Pages(image: "assets/images/5.png", text1: "Start Watching Now", text2: ""),
  ];

}