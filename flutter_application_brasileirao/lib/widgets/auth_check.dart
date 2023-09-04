import 'package:flutter/material.dart';
import 'package:flutter_application_brasileirao/pages/home_page.dart';
import 'package:flutter_application_brasileirao/pages/login_page.dart';
import 'package:flutter_application_brasileirao/services/auth_service.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    if (auth.isLoading) {
      return loanding();
    } else if (auth.usuario == null) {
      return const LoginPage();
    } else {
      return const HomePage();
    }
  }

  loanding() {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
