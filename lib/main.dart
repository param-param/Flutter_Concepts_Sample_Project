import 'package:flutter/material.dart';
import 'package:flutter_concepts/extensions/color_extension.dart';
import 'package:flutter_concepts/extensions/font_extension.dart';
import 'package:flutter_concepts/gen/fonts.gen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_concepts/screens/tabs.dart';

final theme = ThemeData(
    useMaterial3: true,

    /*

     1) Way

     Using the ColorScheme.fromSeed() constructor allows you to create a dynamic ColorScheme.
     with the specified seed color it automatically derives other colors, such as primary, secondary, surface,
     and background etc based on Material Design guidelines

     colorScheme: ColorScheme.fromSeed(
     brightness: Brightness.light,
     seedColor: const Color.fromARGB(255, 187,84,240),),

    */

    /*
    2) Way
    Here you can define ColorScheme of your choice.
    */

    colorScheme: const ColorScheme(
      primary: MyColor.primary,
      secondary: MyColor.secondary,
      surface: MyColor.surface,
      background: MyColor.background,
      error: MyColor.error,
      onPrimary: MyColor.onPrimary,
      onSecondary: MyColor.onSecondary,
      onSurface: MyColor.onSurface,
      onBackground: MyColor.onBackground,
      onError: MyColor.onError,
      brightness: Brightness.light,
    ),

    fontFamily: FontFamily.poppins,

    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 20, fontWeight: FW.semiBold, color: MyColor.onPrimary),
      bodyLarge: TextStyle(
          fontSize: 16, fontWeight: FW.medium, color: MyColor.onPrimary),
      bodyMedium: TextStyle(
          fontSize: 14, fontWeight: FW.medium, color: MyColor.onPrimary),
      bodySmall: TextStyle(
          fontSize: 12, fontWeight: FW.medium, color: MyColor.onPrimary),
      headlineMedium: TextStyle(
          fontSize: 14, fontWeight: FW.medium, color: MyColor.onPrimary),
      headlineSmall: TextStyle(
          fontSize: 10, fontWeight: FW.regular, color: MyColor.onPrimary),
    ));

void main() {
  runApp(
    /* Wrapping your Material app with "ProviderScope". This initializes the Riverpod provider scope for your entire app.*/
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const TabsScreen(),
    );
  }
}
