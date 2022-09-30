import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'form_fill.dart';
import 'form_read.dart';

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
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.email!.substring(0, user.email!.indexOf('@'))),
        actions: [
          IconButton(onPressed: ()=> FirebaseAuth.instance.signOut(), icon: const Icon(Icons.logout)),
        ],
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
          BottomNavigationBarItem(icon: Icon(Icons.list),label: 'Data',backgroundColor: Colors.blue),
          BottomNavigationBarItem(icon: Icon(Icons.format_align_justify),label: 'Post',backgroundColor: Colors.blue),
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
