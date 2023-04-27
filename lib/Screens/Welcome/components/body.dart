import 'package:flutter/material.dart';
//import 'package:flutter_auth/Screens/Home.dart';
//import 'package:flutter_auth/Screens/Login/loginScreen.dart';
//import 'package:flutter_auth/Screens/Signup/components/signup_form.dart';
import 'package:flutter_svg/svg.dart';
import '../../../components/rounded_button.dart';
import '../../Login/loginScreen.dart';
import '../../Signup/signscreen.dart';
import 'background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Video Conference App',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              'assets/icons/chat.svg',
              height: size.height * 0.4,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
