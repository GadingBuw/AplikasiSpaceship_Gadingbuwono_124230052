import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('userBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpaceFlight News',
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E2C), 
          foregroundColor: Colors.white, 
          centerTitle: true,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E1E2C)),
        useMaterial3: true,
      ),
      home: const CheckAuth(),
    );
  }
}

class CheckAuth extends StatefulWidget {
  const CheckAuth({super.key});

  @override
  State<CheckAuth> createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  void _checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool status = prefs.getBool('isLoggedIn') ?? false;
    if (mounted) {
      setState(() {
        isAuth = status;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? const HomePage() : const LoginPage();
  }
}