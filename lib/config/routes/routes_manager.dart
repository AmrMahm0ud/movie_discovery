import 'package:flutter/material.dart';
import 'package:movie_discovery/presentation/screens/movie/movie_screen.dart';
import 'package:movie_discovery/presentation/screens/movie_detail/movie_detail_screen.dart';
import 'package:movie_discovery/presentation/screens/splash/splash_screen.dart';

class Routes {
  static const String splash = "splash";
  static const String movie = "movie";
  static const String movieDetail = "movieDetail";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splash:
        return _materialRoute(const SplashScreen());
      case Routes.movie:
        return _materialRoute(const MovieScreen());
      case Routes.movieDetail:
        int movieId = routeSettings.arguments as int;
        return _materialRoute(MovieDetailScreen(movieId: movieId));
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Not found")),
        body: const Center(child: Text("Not found")),
      ),
    );
  }
}
