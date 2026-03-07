import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config/app_theme.dart';
import 'screens/login/welcome_login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Configure System UI
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const FoodyVrindaV3());
}

class FoodyVrindaV3 extends StatelessWidget {
  const FoodyVrindaV3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foody Vrinda Premium',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const WelcomeLoginScreen(),
    );
  }
}
