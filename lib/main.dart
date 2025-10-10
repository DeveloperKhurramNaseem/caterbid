import 'package:caterbid/core/config/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/routes/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: AppFonts.nunito),

      routerConfig: appRouter,
    );
  }
}
