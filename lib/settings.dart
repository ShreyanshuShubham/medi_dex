import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'config.dart';


class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          IconButton(
            icon: Icon(isDark?Icons.dark_mode:Icons.light_mode),
            tooltip: 'Change theme',
            onPressed: (){setState(() => isDark = !isDark ); },
          ),

          const Divider(),

          IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: ()=> FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
    );
  }
}
