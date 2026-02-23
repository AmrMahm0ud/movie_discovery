class ApiKeys {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkZmE3MDg2ZGMxZDJhNTMzZTQ1YWNjZTNiZTQ4MzExOSIsIm5iZiI6MTc3MTg3MzYzNi41NTUsInN1YiI6IjY5OWNhNTY0ZjBhZDJkMTQ3YmIyOTU4MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qtYMlRijZ_66Z_pWbvNTimjFDUkQw_rztKAB71IOG3Q';

  static Map<String, String> get authHeaders => {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p';
  static const String posterSize = '/w500';
  static const String backdropSize = '/w780';

  static String posterUrl(String path) => '$imageBaseUrl$posterSize$path';
  static String backdropUrl(String path) => '$imageBaseUrl$backdropSize$path';
}
