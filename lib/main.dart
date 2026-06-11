import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'theme/app_theme.dart';
import 'providers/appointment_provider.dart';
import 'providers/notification_provider.dart';
import 'providers/profile_provider.dart';
import 'screens/splash_home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock screen to portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Transparent status bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const TabibiApp());
}

class TabibiApp extends StatelessWidget {
  const TabibiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Manages all appointment data in memory
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),

        // Manages all notification data in memory
        ChangeNotifierProvider(create: (_) => NotificationProvider()),

        // Manages user profile data in memory
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: MaterialApp(
        title: 'موعدي',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,

        // Force RTL for Arabic UI across all screens
        builder: (context, child) => Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        ),

        home: const SplashScreen(),
      ),
    );
  }
}
