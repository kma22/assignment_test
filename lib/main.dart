import 'package:flutter/material.dart';
import 'package:pipes/presentation/screens/home_screen.dart';
import 'package:pipes/presentation/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const HomeScreen(),
    ),
  );
}
