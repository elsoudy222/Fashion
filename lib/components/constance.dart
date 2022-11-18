import 'package:flutter/material.dart';
import '../view/screens/login_screen/login_screen.dart';

const defaultColor = Colors.blue;

String? token = '';

void signOut(context) =>
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => LoginScreen(),), (
        route) => false);




void printFullText(String text){
  
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=> print(match.group(0)));
}
