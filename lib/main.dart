import 'package:datefruitnew/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:datefruitnew/resources/theme/date_fruit_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: CustomAppTheme.lightTheme,
        darkTheme: CustomAppTheme.darkTheme,
        home: const SafeArea(
          child: MainPage(),
        ),
      ),
    ),
  );
}
