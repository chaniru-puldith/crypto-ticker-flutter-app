import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'price_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.system);
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue.shade800));
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light().copyWith(
                primaryColor: Colors.blue.shade800,
                scaffoldBackgroundColor: Color(0xFFF5F5F5)),
            darkTheme: ThemeData.dark().copyWith(
                primaryColor: Colors.blue.shade800,
                scaffoldBackgroundColor: Color(0xFF142432)),
            themeMode: currentMode,
            home: PriceScreen(),
          );
        });
  }
}
