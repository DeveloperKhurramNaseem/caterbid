import 'dart:async';
import 'package:caterbid/core/utils/user_session.dart';
import 'package:caterbid/modules/Restaurant/home/screen/main_screen/bids_home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:caterbid/core/utils/helpers/secure_storage.dart';
import 'package:caterbid/core/utils/prefs/shared_preferences.dart';
import 'package:caterbid/modules/Producer/home/active_request/screen/main_screen/home_screen.dart';
import 'package:caterbid/modules/Restaurant/business_profile/screen/main_screen/set_business_profile_screen.dart';
import 'package:caterbid/modules/auth/login/screen/main_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String path = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Fade-in animation for smooth entry
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );

    _initApp();
  }

  Future<void> _initApp() async {
    await Future.delayed(const Duration(seconds: 3));

    final token = await SecureStorage.getToken();
    final role = await SharedPrefs.getUserRole();
    final locationRequired = await SharedPrefs.getLocationRequired();

    if (token == null || token.isEmpty) {
      if (mounted) context.go(LoginScreen.path);
      return;
    }

    if (role == 'provider') {
      UserSession.setRole('provider');

      if (locationRequired == true) {
        if (mounted) context.go(SetBusinessProfileScreen.path);
      } else {
        if (mounted) context.go(MyBidsScreen.path);
      }
    } else if (role == 'requestee') {
      UserSession.setRole('requestee');

      if (mounted) context.go(ProducerHomeScreen.path);
    } else {
      if (mounted) context.go(LoginScreen.path);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Image.asset(
            'assets/icons/app_logo.png',
            height: 95, // ↓ Decreased size
          ),
        ),
      ),
    );
  }
}
