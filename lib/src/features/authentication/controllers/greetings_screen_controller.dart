import 'package:flutter/material.dart';
import 'package:vivid/src/features/authentication/screens/sign_up_screen/signup_screen.dart';

class GreetingsScreenController extends StatefulWidget {
  @override
  _GreetingsScreenControllerState createState() =>
      _GreetingsScreenControllerState();
}

class _GreetingsScreenControllerState extends State<GreetingsScreenController> {
  @override
  Widget build(BuildContext context) {
    return SignupScreen();
  }
}
