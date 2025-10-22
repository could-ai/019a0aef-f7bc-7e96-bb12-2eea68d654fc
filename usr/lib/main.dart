import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:shamswahaai/screens/home_screen.dart';
import 'package:shamswahaai/screens/dashboard_screen.dart';
import 'package:shamswahaai/screens/sandbox_screen.dart';
import 'package:shamswahaai/screens/ar_screen.dart';
import 'package:shamswahaai/screens/reports_screen.dart';
import 'package:shamswahaai/widgets/voice_assistant.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ShamsWahaAIApp());
}

class ShamsWahaAIApp extends StatefulWidget {
  const ShamsWahaAIApp({super.key});

  @override
  State<ShamsWahaAIApp> createState() => _ShamsWahaAIAppState();
}

class _ShamsWahaAIAppState extends State<ShamsWahaAIApp> {
  bool _isArabic = false;
  int _userScore = 0;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isArabic = prefs.getBool('isArabic') ?? false;
      _userScore = prefs.getInt('userScore') ?? 0;
    });
  }

  void _toggleLanguage() {
    setState(() {
      _isArabic = !_isArabic;
    });
    SharedPreferences.getInstance().then((prefs) => prefs.setBool('isArabic', _isArabic));
  }

  void _updateScore(int points) {
    setState(() {
      _userScore += points;
    });
    SharedPreferences.getInstance().then((prefs) => prefs.setInt('userScore', _userScore));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShamsWahaAI - شمس الواحة AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme(
          primary: Color(0xFFFF4500), // Orange for heat
          secondary: Color(0xFF32CD32), // Green for cool
          surface: Color(0xFFF5F5DC), // Beige for desert
          background: Color(0xFFE0F7FA), // Light blue for optimal
          error: Color(0xFFD32F2F), // Red for extreme
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        fontFamily: _isArabic ? 'NotoSansArabic' : 'Roboto',
      ),
      locale: _isArabic ? const Locale('ar') : const Locale('en'),
      home: HomeScreen(
        isArabic: _isArabic,
        userScore: _userScore,
        onLanguageToggle: _toggleLanguage,
        onScoreUpdate: _updateScore,
      ),
      routes: {
        '/dashboard': (context) => DashboardScreen(isArabic: _isArabic),
        '/sandbox': (context) => SandboxScreen(
          isArabic: _isArabic,
          onScoreUpdate: _updateScore,
        ),
        '/ar': (context) => ARScreen(isArabic: _isArabic),
        '/reports': (context) => ReportsScreen(isArabic: _isArabic),
      },
    );
  }
}