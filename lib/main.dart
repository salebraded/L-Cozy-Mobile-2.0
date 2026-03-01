import 'package:flutter/material.dart';
import 'Screen/Login Page/login_screen.dart'; 

void main() {
  // This runs your application
  runApp(const LcozyApp());
}

class LcozyApp extends StatelessWidget {
  const LcozyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "L'COZY",
      // Setting this to false hides that little red "DEBUG" banner in the top right
      debugShowCheckedModeBanner: false, 
      
      // 🎨 GLOBAL APP THEME
      // Setting this up here saves you hours of work later!
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF34495E), // Main Dark Slate from your web UI
        scaffoldBackgroundColor: const Color(0xFFF4F6F9), // Standard background
        
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF34495E),
          primary: const Color(0xFF34495E),
          secondary: const Color(0xFF3498DB), // The blue accent for the Student side
        ),
        
        // Global styling for ElevatedButtons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF34495E),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      
      // 🚀 INITIAL ROUTE
      // This tells the app to open the Student Login Screen when it launches
      home: const LoginScreen(), 
    );
  }
}