import 'package:chat_gpt/provider/chats_provider.dart';
import 'package:chat_gpt/provider/models_provider.dart';
import 'package:chat_gpt/provider/theme_provider.dart';
import 'package:chat_gpt/screens/chat_screen.dart';
import 'package:chat_gpt/screens/splash_screen.dart';
import 'package:chat_gpt/styles/theme_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreference.getTheme();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        ),
        ChangeNotifierProvider(
            create:(_)=>themeChangeProvider
        ),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            // home: SplashScreen(),
            initialRoute: '/splash_screen',
            routes: {
                  '/splash_screen':(context)=>SplashScreen(),
                  '/cart_screen':(context)=>ChatScreen(),
            },
            // routes: <String, WidgetBuilder>{
            //   AGENDA: (BuildContext context) => AgendaScreen(),
            // },
          );
        },
      ),);
  }
}

/*
import 'package:chat_gpt/provider/chats_provider.dart';
import 'package:chat_gpt/provider/models_provider.dart';
import 'package:chat_gpt/provider/theme_provider.dart';
import 'package:chat_gpt/screens/chat_screen.dart';
import 'package:chat_gpt/screens/splash_screen.dart';
import 'package:chat_gpt/styles/theme_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return
      ChangeNotifierProvider(
        create: (_) {
          return themeChangeProvider;
        },
        child: Consumer<DarkThemeProvider>(
          builder: (BuildContext context, value, Widget? child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: Styles.themeData(themeChangeProvider.darkTheme, context),
              home: SplashScreen(),
              // routes: <String, WidgetBuilder>{
              //   AGENDA: (BuildContext context) => AgendaScreen(),
              // },
            );
          },
        ),);
  }
}


 */
