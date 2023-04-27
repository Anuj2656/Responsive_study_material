import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:videoconferenceapp/Screens/Login/no_internet.dart';
import 'package:videoconferenceapp/Screens/Home/components/homepass.dart';
import '../../../components/rounded_button.dart';
import '../../../constants.dart';
import '../../Forget/foregetscreen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Signup/signscreen.dart';
import './background.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Body1 extends StatefulWidget {
  const Body1({
    Key? key,
  }) : super(key: key);

  @override
  State<Body1> createState() => _Body1State();
}

class _Body1State extends State<Body1> {
  var mytext = true;
  bool loading=false;
  bool myfunction() {
    return !mytext;

  }
   bool isSecure = true;
  final Connectivity _connectivity = Connectivity();
  final _formKey = GlobalKey<FormState>();
  final emailController =  TextEditingController();
  final passwordController =  TextEditingController();
  final FirebaseAuth _auth  = FirebaseAuth.instance;

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
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
  login() async{
    try {
       await _auth.signInWithEmailAndPassword(
           email: emailController.text.toString(),
          password: passwordController.text.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueAccent,
          content: Text('Login Successfully',
            style:TextStyle(fontSize:15.0, color: Colors.white),
          ),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const homepass(),
        ),
      );
    }on FirebaseAuthException catch (e) {
      if(e.code == 'user-not-found'){
        print('No User Found for that Email');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.deepPurpleAccent,
            content: Text(
              'No User Found',
              style:TextStyle(fontSize:15.0, color: Colors.white),
            ),
          ),
        );
      }else if (e.code=='wrong-password'){
        print("Wrong Password Provided by User");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.deepPurpleAccent,
            content: Text(
              'Incorrect Password',
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
              'LOGIN',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              'assets/icons/login.svg',
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
                      validator: (validateEmail) {
                     //   FirebaseAuth.instance.createUserWithEmailAndPassword(email:emailController,password:passwordController);
                        if (validateEmail == null || validateEmail.isEmpty) {
                          return 'Please Enter your Email';
                        }
                          else if  ( !RegExp(r'^[\w-]+(\.[\w-]+)*@gmail\.com$').hasMatch(validateEmail)) {
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
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: TextFormField(
                      key: const ValueKey('Password'),
                      controller: passwordController,
                      validator: (validatePassword) {
                     //   FirebaseAuth.instance.createUserWithEmailAndPassword(email:value,password:Pvalue);
                        if (validatePassword == null ||
                            validatePassword.isEmpty){
                          return 'Please Enter Your Password';
                        }
                        else if   (validatePassword.length < 6) {
                          return 'Password should be of 6 characters';
                        }
                        return null;
                      },

                      obscureText:isSecure,
                      decoration:  InputDecoration(
                        icon: const Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                        hintText: "Your Password",
                        border: InputBorder.none,
                        suffixIcon: tooglePassword(),
                      ),

                    ),
                  ),
                ],
              ),
            ),
            RoundedButton(
              text: "Login",
              press: () async {
                setState(() {
                  loading = true;
                });
                if (_formKey.currentState!.validate()) {
                await connectivity();
                await  login();
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
            SizedBox(height: size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Dont Remember the password?",
                  style: TextStyle(color: kPrimaryColor),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const
                          forgetScreen();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Reset Password",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
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
