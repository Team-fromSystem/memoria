//import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart';
import 'package:memoria/firebase_options.dart';
import 'package:memoria/common/bottomBar/bottom_nav_bar.dart';
import 'package:memoria/pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoria/pages/register_page.dart';
import 'package:memoria/utils/location_permission_request.dart';
import 'package:memoria/utils/notification_permission_request.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation("Asia/Tokyo"));

  // runApp(ProviderScope(
  //   child: DevicePreview(builder: (context) => const MyApp()),
  // ));

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PageController controller = PageController(initialPage: 0);
    final Location location = Location();
    useEffect(() {
      // リクエストを出す処理
      RequestLocationPermission.request(location);
      requestNotificationPermissions();
      return null;
    }, []);
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
