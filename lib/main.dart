import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_spot/screens/main_screen.dart';
import 'package:movie_spot/screens/splash_screen.dart';

void main() {
  runApp(
    SplashScreen(
      key: UniqueKey(),
      onInitializationComplete: () => runApp(
        ProviderScope(child: MyApp()),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MovieSpot',
      initialRoute: '/home',
      routes: {
        '/home': (BuildContext _context) => MainScreen(),
      },
      theme: ThemeData(primaryColor: Colors.blue, visualDensity: VisualDensity.adaptivePlatformDensity),
    );
  }
}
