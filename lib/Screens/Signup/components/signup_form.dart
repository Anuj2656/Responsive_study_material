import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../components/rounded_button.dart';
import '../../../constants.dart';
import '../no_internet.dart';
import '../../Login/components/background.dart';
import '../../Login/loginScreen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Body2 extends StatefulWidget {
  const Body2({
    Key? key,
  }) : super(key: key);

  @override
  State<Body2> createState() => _Body2State();
}

class _Body2State extends State<Body2> {
  var mytext = true;
  bool loading = false;

  bool myfunction() {
    return !mytext;
  }

  bool isSecure = true;
  final Connectivity _connectivity = Connectivity();
  final _formKey = GlobalKey<FormState>();
  final  emailController = TextEditingController();
  final  passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
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
  signup() async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueAccent,
          content: Text('Sign in Successfully',
            style: TextStyle(fontSize: 15.0, color: Colors.white),
          ),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('Account Already exists');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.deepPurpleAccent,
            content: Text(
              'Account Already exists',
              style: TextStyle(fontSize: 15.0, color: Colors.white),
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
          //resizeToAvoidBottomPadding: false,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'SIGNUP',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              'assets/icons/signup.svg',
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
                       if (val == null || val.isEmpty) {
                          return 'Please Enter your Email';
                        }
                       else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@gmail\.com$').hasMatch(val)) {
                         return 'Please enter a valid email address';
                       }
                       //return null;
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
                    margin: const EdgeInsets.symmetric(vertical: 10),
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
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty){
                          return 'Please Enter Your Password';
                        }
                        else if   (value.length < 6 ) {
                          return 'Password should be of 6 characters';
                        }
                        return null;
                      },

                      obscureText: isSecure,
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
              text: "Signup",
              press: () async {
                setState(() {
                  loading = true;
                });
    if (_formKey.currentState!.validate()) {
      await  connectivity();
      await signup();

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
                  "Already have an Account?",
                  style: TextStyle(color: kPrimaryColor),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const
                          LoginScreen();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),

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
