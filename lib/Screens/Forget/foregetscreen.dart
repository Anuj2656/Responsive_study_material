import 'package:flutter/material.dart';
import 'Component/body.dart';

class forgetScreen extends StatelessWidget {
  const forgetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      body: Body4(),
    );
  }
}
