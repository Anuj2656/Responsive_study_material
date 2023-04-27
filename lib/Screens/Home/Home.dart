import 'package:flutter/material.dart';
import 'package:videoconferenceapp/Screens/Home/components/Newbody.dart';
import 'package:videoconferenceapp/Screens/Home/components/homebody.dart';
import 'package:videoconferenceapp/Screens/Home/components/joinbody.dart';
class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background2(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Lets Start',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Image.asset(
              'assets/images/home.png',
              height: size.height * 0.35,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: ElevatedButton.icon(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return  const MyApp()  ;
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text("New Meeting"),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(350, 30), backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              height: 40,
              indent: 40,
              endIndent: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: OutlinedButton.icon(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return
                        const MyApp2();
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.margin),
                label: const Text("Join with a code"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.indigo, side: const BorderSide(color: Colors.indigo),
                  fixedSize: const Size(350, 30),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

