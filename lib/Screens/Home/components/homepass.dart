import 'package:flutter/material.dart';
import 'package:videoconferenceapp/Screens/Home/Home.dart';


class homepass extends StatelessWidget {
  const homepass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      body: home(),
    );
  }
}