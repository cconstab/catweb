import 'dart:async';

import 'package:flutter/material.dart';
import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_utils/at_logger.dart' show AtSignLogger;
import 'package:path_provider/path_provider.dart'
    show getApplicationSupportDirectory;
import 'package:catweb/services/at_env.dart' show MyAtEnv;

import 'package:catweb/screens/main_screen.dart';
import 'package:catweb/screens/new_radio.dart';
import 'package:catweb/theme/ui_theme.dart';
import 'package:catweb/screens/home_screen.dart';

Future<void> main() async {
  await MyAtEnv.load();
  runApp(const MyApp());
}

Future<AtClientPreference> loadAtClientPreference() async {
  var dir = await getApplicationSupportDirectory();
  print(MyAtEnv.rootDomain);
  print(MyAtEnv.appNamespace);

  return AtClientPreference()
        ..rootDomain = MyAtEnv.rootDomain
        ..namespace = MyAtEnv.appNamespace
        ..hiveStoragePath = dir.path
        ..commitLogPath = dir.path
        ..isLocalStoreRequired = true
      // TODO set the rest of your AtClientPreference here
      ;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // * load the AtClientPreference in the background
  Future<AtClientPreference> futurePreference = loadAtClientPreference();
  AtClientPreference? atClientPreference;

  final AtSignLogger _logger = AtSignLogger(MyAtEnv.appNamespace);

  bool isFirstLoad = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HamLib-Web UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: UItheme.richBlackFOGRA29,
      ),
      // * The onboarding screen (first screen)
      routes: {
        HomeScreen.id: (_) => const HomeScreen(),
        MainScreen.id: (_) => const MainScreen(),
        NewRadio.id: (_) => const NewRadio(),
        //EditRadio.id: (_) => const EditRadio(),
      },
      initialRoute: HomeScreen.id,
    );
  }
}
