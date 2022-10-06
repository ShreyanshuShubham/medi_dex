import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class User{
  late String date;
  late String time;
  late String sys;
  late String dia;
  late String sugar;
  User({
    required this.sugar,
    required this.dia,
    required this.sys,
    required this.time,
    required this.date
});
  static User fromJson(Map<String,dynamic> json) => User(
    date : json['date'],
    time : json['time'],
    sys : json['sys'],
    dia : json['dia'],
    sugar : json['sugar'],
  );
}
class FormRead extends StatefulWidget {
  const FormRead({Key? key}) : super(key: key);

  @override
  State<FormRead> createState() => _FormReadState();
}

class _FormReadState extends State<FormRead> {

  final user = FirebaseAuth.instance.currentUser!;


  Stream<List<User>> readEntry() => FirebaseFirestore.instance
      .collection(user.email!.substring(0, user.email!.indexOf('@')))
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

  Widget buildUser(User user) => ListTile(
    title: Text("${user.date} ${user.time}"),
    subtitle: Text("sys: ${user.sys} dia: ${user.dia} sugar: ${user.sugar}"),
  );
  @override
  //=========this is above method for loading every time
  Widget build(BuildContext context) {
    return StreamBuilder<List<User>>(
        stream: readEntry(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            final users = snapshot.data!;
            return ListView(
              children: users.map(buildUser).toList(),
            );
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }
        }
    );
  }

  //=========this is above method for not loading every time
  // Widget build(BuildContext context) {
  //   return FutureBuilder<List<User>>(
  //       future: readEntry().first,
  //       builder: (context,snapshot){
  //         if(snapshot.hasData){
  //           final users = snapshot.data!;
  //           return ListView(
  //             reverse: true,
  //             children: users.map(buildUser).toList(),
  //           );
  //         }else{
  //           return const Center(child: CircularProgressIndicator(),);
  //         }
  //       }
  //   );
  // }
}
