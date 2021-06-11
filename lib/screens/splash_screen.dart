import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_spot/model/app_config.dart';
import 'package:movie_spot/services/http_service.dart';
import 'package:movie_spot/services/movie_service.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashScreen({Key? key, required this.onInitializationComplete}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3)).then(
      (_) => _setup(context).then(
        (_) => widget.onInitializationComplete(),
      ),
    );
  }

  Future<void> _setup(BuildContext _context) async {
    final getIt = GetIt.instance;

    final configFile = await rootBundle.loadString('assets/config/main.json');
    final configData = jsonDecode(configFile);

    getIt.registerSingleton<AppConfig>(
      AppConfig(
          BASE_API_URL: configData["BASE_API_URL"],
          BASE_IMAGE_API_URL: configData["BASE_IMAGE_API_URL"],
          API_KEY: configData["API_KEY"]),
    );

    getIt.registerSingleton<HttpService>(
      HttpService(),
    );

    getIt.registerSingleton<MovieService>(
      MovieService(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MovieSpot",
      theme: ThemeData(primaryColor: Colors.blue),
      home: Center(
        child: Container(
          height: 200,
          width: 200,
          decoration:
              BoxDecoration(image: DecorationImage(fit: BoxFit.contain, image: AssetImage("assets/images/logo.png"))),
        ),
      ),
    );
  }
}
