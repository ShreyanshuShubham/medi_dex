import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'form_fill.dart';
import 'form_read.dart';
import 'settings.dart';
import 'config.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser!;
  int _currentIndex = 0;
  final tabs = [
    const FormFill(),
    const FormRead(),
    const SettingPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDark?Colors.red:Colors.blue,
        title: Text(user.email!.substring(0, user.email!.indexOf('@'))),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black26,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedIconTheme: const IconThemeData(size: 30,),
        unselectedIconTheme: const IconThemeData(size: 20,),
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.edit),label: 'Upload',backgroundColor: Colors.blue),
          BottomNavigationBarItem(icon: Icon(Icons.remove_red_eye),label: 'View',backgroundColor: Colors.blue),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings',backgroundColor: Colors.blue),
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: tabs[_currentIndex],
    );
  }
}
