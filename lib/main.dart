import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery/config/routes/routes_manager.dart';
import 'package:movie_discovery/config/theme/app_theme_manager.dart';
import 'package:movie_discovery/di/injector.dart';
import 'package:movie_discovery/presentation/blocs/movie/movie_bloc.dart';
import 'package:movie_discovery/presentation/blocs/movie_detail/movie_detail_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MovieDiscoveryApp());
}

class MovieDiscoveryApp extends StatelessWidget {
  const MovieDiscoveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(create: (_) => injector<MovieBloc>()),

        BlocProvider<MovieDetailBloc>(
          create: (_) => injector<MovieDetailBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Movie Discovery',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: Routes.splash,
        onGenerateRoute: RouteGenerator.getRoute,
      ),
    );
  }
}
