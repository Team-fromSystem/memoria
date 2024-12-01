import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memoria/firebase_options.dart';
import 'package:memoria/common/bottomBar/bottom_nav_bar.dart';
import 'package:memoria/pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoria/pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // TODO エミュレータを使用 デプロイ時には削除？
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  // runApp(ProviderScope(
  //   child: DevicePreview(builder: (context) => const MyApp()),
  // ));

  runApp(const ProviderScope(child: MyApp()));
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
          fontFamily: GoogleFonts.kiwiMaru(
              textStyle: const TextStyle(
            color: Color(0xff333333),
            fontWeight: FontWeight.w700,
          )).fontFamily,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 66, 206, 171)),
          useMaterial3: true,
        ),
        home: Scaffold(
          extendBody: true,
          body: PageView(
            controller: controller,
            physics: const NeverScrollableScrollPhysics(),
            children: const [HomePage(), RegisterPage()],
          ),
          bottomNavigationBar: BottomNavBar(controller: controller),
        ));
  }
}
