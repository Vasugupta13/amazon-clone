import 'package:wick_wiorra/constants/global_variables.dart';
import 'package:wick_wiorra/features/splash.dart';
import 'package:wick_wiorra/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const ProviderScope(child: MyApp())); // Run app after setting orientation
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        textTheme: TextTheme(
          headlineMedium: GoogleFonts.albertSans(
              color: GlobalVariables.kPrimaryTextColor,
              fontWeight: FontWeight.w600),
          headlineSmall: GoogleFonts.albertSans(
              color: GlobalVariables.kPrimaryTextColor,
              fontWeight: FontWeight.w600),
          displaySmall: GoogleFonts.albertSans(
              color: GlobalVariables.kPrimaryTextColor,
              fontWeight: FontWeight.w700),
          titleLarge: GoogleFonts.albertSans(
              color: GlobalVariables.kPrimaryTextColor,
              fontWeight: FontWeight.w700),
          titleMedium: GoogleFonts.albertSans(
              color: GlobalVariables.kPrimaryTextColor,
              fontWeight: FontWeight.w700),
          bodyLarge: GoogleFonts.albertSans(
              color: Colors.black, fontWeight: FontWeight.w700),
          bodyMedium: GoogleFonts.albertSans(
              color: Colors.black, fontWeight: FontWeight.w500),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const SplashScreen(),
    );
  }
}
