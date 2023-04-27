import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:videoconferenceapp/Screens/Forget/no_internet.dart';
import 'package:videoconferenceapp/Screens/Login/loginScreen.dart';
import '../../../components/rounded_button.dart';
import '../../../constants.dart';
import '../../Login/components/background.dart';
import '../../Signup/signscreen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Body4 extends StatefulWidget {
  const Body4({
    Key? key,
  }) : super(key: key);

  @override
  State<Body4> createState() => _Body4State();
}

class _Body4State extends State<Body4> {
  var mytext = true;
  bool loading=false;
  bool myfunction() {
    return !mytext;
  }
  bool isSecure = true;
  final _formKey = GlobalKey<FormState>();
  final Connectivity _connectivity = Connectivity();
  final emailController =  TextEditingController();
  final FirebaseAuth _auth  = FirebaseAuth.instance;

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }
  connectivity() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      // Show "Oops" screen
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ConnectionLostScreen()));
    }
  }
  resetPassword() async{
    try {
      await _auth.sendPasswordResetEmail(
          email: emailController.text.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueAccent,
          content: Text('Password Reset Email has been sent !',
            style:TextStyle(fontSize:15.0, color: Colors.white),
          ),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }on FirebaseAuthException catch (e) {
      if(e.code == 'user-not-found'){
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.deepPurpleAccent,
            content: Text(
              'No User Found .',
              style:TextStyle(fontSize:15.0, color: Colors.white),
            ),
          ),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    // final formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          //resizeToAvoidBottomInset: true,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Reset Link Will be Sent To Your Email Id',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              'assets/images/forget.png',
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: TextFormField(
                      key: const ValueKey('email'),
                      controller: emailController,
                      validator: (val) {
                        //   FirebaseAuth.instance.createUserWithEmailAndPassword(email:emailController,password:passwordController);
                        if (val == null || val.isEmpty) {
                          return 'Please Enter your Email';
                        }
                        else if  ( !val.contains('@gmail.com')) {
                          return 'Please enter valid email address';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: kPrimaryColor,
                        ),
                        hintText: "Your Email",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            RoundedButton(
              text: "Send Email",
              press: () async {
                setState(() {
                  loading = true;
                });
                if (_formKey.currentState!.validate()) {
                  await  connectivity();
                 await resetPassword();
                }
                setState(() {
                  loading = false;
                });
              },
              loading: loading,
            ),

            SizedBox(height: size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Dont have an Account?",
                  style: TextStyle(color: kPrimaryColor),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const
                          SignScreen();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            // )
          ],

        ),
      ),
    );
  }
  Widget tooglePassword(){
    return IconButton(onPressed: (){
      setState(() {
        isSecure = !isSecure;
      });
    }, icon: isSecure ? const Icon( Icons.visibility_off_rounded) : const Icon( Icons.visibility_rounded),
      color :  kPrimaryColor,
    );
  }
}