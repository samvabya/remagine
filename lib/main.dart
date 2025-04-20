import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remagine/providers/image_provider.dart';
import 'package:remagine/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ImageGeneratorProvider(),
      child: MaterialApp(
        title: 'Remagine',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6C63FF),
            brightness: Brightness.dark,
          ),
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
