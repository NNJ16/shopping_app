import 'package:flutter/material.dart';
import 'package:shopping_app/components/constants.dart';
import '../components/account_button.dart';
import '../services/authentication_service.dart';
import 'login_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Profile"),
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 16, 0, 4),
                child: Text(
                  "Account Settings",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Text(
                "Update your account settings.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: AccountButton(
                  title: "Profile Information",
                  subTitle: "Change your account details.",
                  icon: Icons.person,
                  onPressed: () {},
                ),
              ),
              const Divider(
                color: Colors.black54,
                indent: 20,
                endIndent: 20,
              ),
              AccountButton(
                title: "Logout",
                subTitle: "Logout from the app",
                icon: Icons.power_settings_new,
                onPressed: () {
                  Authentication.signOut(context: context);
                },
              ),
              const Divider(
                color: Colors.black54,
                indent: 20,
                endIndent: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
