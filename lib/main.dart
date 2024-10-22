import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:memoria/firebase_options.dart';
import 'package:memoria/bottomBar/bottom_nav_bar.dart';
import 'package:memoria/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: 0);

    return MaterialApp(
        title: 'Memoria',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.notoSansJp(
              textStyle: const TextStyle(
            color: Color(0xff333333),
            fontWeight: FontWeight.w500,
          )).fontFamily,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 58, 183, 152)),
          useMaterial3: true,
        ),
        home: Scaffold(
          extendBody: true,
          body: PageView(
            controller: controller,
            children: [
              const HomePage(),
              Container(
                color: Colors.red,
                child: const Text(
                  "Search\nPage",
                  style: TextStyle(fontSize: 80),
                ),
              ),
              //DetailPage(),
            ],
          ),
          bottomNavigationBar: BottomNavBar(controller: controller),
        ));
  }
}
