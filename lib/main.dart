import 'package:flutter/material.dart';
import 'package:flutter_js_notes/providers/notesProvider.dart';
import 'package:provider/provider.dart';

import 'homeUI.dart';
import 'theme/dynamic_theme_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NotesProvider(),
        ),
      ],
      child: DynamicThemeBuilder(
        title: 'Flutter JS Notes',
        home: const HomeUI(),
      ),
    );
  }
}
