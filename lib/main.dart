import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_delivery_app/common/color_extension.dart';
import 'package:food_delivery_app/common/globs.dart';
import 'package:food_delivery_app/common/locator.dart';
import 'package:food_delivery_app/common/my_http_overrides.dart';
import 'package:food_delivery_app/common/service_call.dart';
import 'package:food_delivery_app/view/login/welcom_view.dart';
import 'package:food_delivery_app/view/main_tabview/main_tab_view.dart';
import 'package:food_delivery_app/view/on_boarding/startup_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

void main() async {
  setUpLocator();

  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  if (Globs.udValueBool(Globs.userLogin)) {
    ServiceCall.userPayload = Globs.udValue(Globs.userPayload);
  }
  runApp(
    const MyApp(
      defaultHome: StartupView(),
    ),
  );
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 5.0
    ..progressColor = TColor.primaryText
    ..backgroundColor = TColor.primary
    ..indicatorColor = Colors.yellow
    ..textColor = TColor.primaryText
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  final Widget defaultHome;
  const MyApp({super.key, required this.defaultHome});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Metropolis",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WelcomeView(),
      navigatorKey: locator<NavigationService>().navigatorKey,
      builder: (context, child) {
        return FlutterEasyLoading(child: child);
      },
    );
  }
}
