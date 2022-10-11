
import 'package:fashion/view/screens/components/home/body.dart';
import 'package:fashion/view/screens/components/home/header.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  HomeHeader(),
                  const SizedBox(
                    height: 15,
                  ),
                  HomeBody(),
                ],
              ),
            ),
          ),

    );
  }
}
