import 'package:flutter/material.dart';
import 'package:movie_app/features/home/domain/entities/movies_entity.dart';
import 'package:movie_app/features/movie_details/presentation/pages/movie_details_screen.dart';
import '../../features/home/presentation/pages/home.dart';


class Routes {
  static const String home = "/";
  static const String movieDetails = "movieDetails";
}

class AppRoutes {
  static Route onGenerate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case Routes.movieDetails:
        ResultsEntity movie =routeSettings.arguments as ResultsEntity;
        return MaterialPageRoute(
          builder: (context) => MovieDetailsScreen(movie),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => unDefineRoute(),
        );
    }
  }

  static Widget unDefineRoute() => const Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Center(child: Text("Undefine Route"))],
        ),
      );
}
