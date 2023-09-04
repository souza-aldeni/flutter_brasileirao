import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_brasileirao/controllers/theme_controller.dart';
import 'package:flutter_application_brasileirao/repositories/times_repository.dart';
import 'package:flutter_application_brasileirao/services/auth_service.dart';
import 'package:flutter_application_brasileirao/widgets/auth_check.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.lazyPut<ThemeController>(() => ThemeController());

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => TimesRepository()),
    ChangeNotifierProvider(create: (context) => AuthService()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController.to.loadThemeMode();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Brasileirão',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: Colors.grey,
          dividerColor: Colors.black45,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent[100]))),
      home: const AuthCheck(),
    );
  }
}
