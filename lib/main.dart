import 'dart:convert';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/HomePage.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => ThemeData.light(),
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
          theme: theme,
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          );
        });
  }
}
