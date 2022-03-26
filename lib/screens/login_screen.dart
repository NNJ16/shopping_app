import 'package:flutter/material.dart';
import 'package:shopping_app/screens/admin/admin_screen.dart';

import '../components/sign_in_button.dart';
import '../services/authentication_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Image.asset(
                "assets/images/logo.png",
                width: 250,
                height: 350,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Center(
                  child: Text(
                    "Welcome",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
                const Center(
                  child: Text(
                    "to our store",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 40.0),
                  child: Center(
                    child: Text(
                      "Get your orders as soon as hour",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 40,
                //   ),
                //   child: ElevatedButton(
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const MainScreen()),
                //       );
                //     },
                //     child: Row(
                //       mainAxisSize: MainAxisSize.min,
                //       //mainAxisAlignment: MainAxisAlignment.center,
                //       children: const [
                //         // Icon(Icons.mail),
                //         // SizedBox(
                //         //   width: 10,
                //         // ),
                //         Text('Sign Up')
                //       ],
                //     ),
                //     style:
                //         ElevatedButton.styleFrom(shape: const StadiumBorder()),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminScreen()),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        // Icon(Icons.mail),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        Text('Continue with Gmail')
                      ],
                    ),
                    style:
                        ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  ),
                ),
                FutureBuilder(
                  future: Authentication.initializeFirebase(context),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Error initializing Firebase');
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return const GoogleSignInButton();
                    }
                    return const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
