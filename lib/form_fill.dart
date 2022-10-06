import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'config.dart';

class FormFill extends StatefulWidget {
  const FormFill({Key? key}) : super(key: key);

  @override
  State<FormFill> createState() => _FormFillState();
}

class _FormFillState extends State<FormFill> {
  final sysController = TextEditingController();
  final diaController = TextEditingController();
  final sugarController = TextEditingController();
  // var dt = DateTime.now();
  String currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String currentTime = DateFormat("HH-mm-ss").format(DateTime.now());
  final user = FirebaseAuth.instance.currentUser!;
  bool useCustomTime = false;
  Future createEntry({required String sys,required String dia,required String sugar,required String date,required String time})async{
    final docUser = FirebaseFirestore.instance.collection(user.email!.substring(0, user.email!.indexOf('@'))).doc("$date@$time");
    final json = {
      'date' : date,
      'time' : time,
      'sys' : sys,
      'dia' : dia,
      'sugar' : sugar,
    };
    await docUser.set(json);
  }
  DateTime dateTime = DateTime.now();
  Future<DateTime?> pickDate()=>showDatePicker(context: context, initialDate: dateTime, firstDate: DateTime(2020), lastDate: DateTime(2100));
  Future<TimeOfDay?> pickTime() => showTimePicker(context: context, initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
  @override
  Widget build(BuildContext context) {
    // return const Center(child: Text("FormFill"),);
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: ListView(
        children: [
            SizedBox(height: MediaQuery.of(context).size.height/8,),
            // Container(
            //   child: RichText(
            //     text: TextSpan(
            //       text: "hello",
            //       children: <TextSpan>[
            //         TextSpan(text: currentDate,style: const TextStyle(color: Colors.black)),
            //         const TextSpan(text: "\t"),
            //         TextSpan(text: currentTime,style: const TextStyle(color: Colors.black)),
            //       ]
            //     ),
            //   ),
            // ),
            ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(useCustomTime?Colors.blue:Colors.grey)),
                child: Text(useCustomTime?"Use Current Time":"Use Custom Time"),
                onPressed: (){setState(() =>useCustomTime = !useCustomTime);},
            ),
            Visibility(
              visible: !useCustomTime,
                child: Text("Date : $currentDate\nTime : $currentTime"),
            ),
            Visibility(
              visible: useCustomTime,
                child: ElevatedButton(
                  onPressed: ()async{
                    final date = await pickDate();
                    if(date==null) return;
                    final newDateTime = DateTime(
                      date.year,
                      date.month,
                      date.day,
                      dateTime.hour,
                      dateTime.minute,
                    );
                    setState(() {
                      dateTime = newDateTime;
                    });
                  },
                  child: Text("Set Date : ${dateTime.year}/${dateTime.month}/${dateTime.day}"),
                ),
            ),
            Visibility(
              visible: useCustomTime,
                child: ElevatedButton(
                  onPressed: ()async{
                    final time = await pickTime();
                    if (time==null) return;
                    final newDateTime = DateTime(dateTime.year,dateTime.month,dateTime.day,time.hour,time.minute,);
                    setState(() => dateTime = newDateTime);
                  },
                  child: Text("Set Time : ${dateTime.hour.toString().padLeft(2,'0')}:${dateTime.minute.toString().padLeft(2,'0')}:00"),
                ),
            ),
            // Text("DATE : $currentDate"),
            // Text("TIME : $currentTime"),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Blood Pressure',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 30,letterSpacing: 2,),),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width /2.5,
                  child: TextField(
                    controller: sysController,
                    decoration: InputDecoration(
                      // prefixIcon: const ImageIcon(AssetImage('assets/blood-pressure.png'),color: Colors.black38,),
                      labelText: "  Sys",
                      border: UnderlineInputBorder(borderRadius: BorderRadius.circular(5.0),),
                      fillColor: Colors.blue[100],
                      filled: true,
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                // SizedBox(width: 35,),
                SizedBox(
                  width: MediaQuery.of(context).size.width /2.5,
                  child: TextField(
                    controller: diaController,
                    decoration: InputDecoration(
                      // prefixIcon: const ImageIcon(AssetImage('assets/blood-pressure.png'),color: Colors.black38,),
                      labelText: "  Dia",
                      border: UnderlineInputBorder(borderRadius: BorderRadius.circular(5.0),),
                      fillColor: Colors.blue[100],
                      filled: true,
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Blood Sugar',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 30,letterSpacing: 2,),),
            ),
            TextField(
              controller: sugarController,
              decoration: InputDecoration(
                // prefixIcon: const ImageIcon(AssetImage('assets/blood-sugar.png'),color: Colors.black38,),
                labelText: "  Sugar",
                border: UnderlineInputBorder(borderRadius: BorderRadius.circular(5.0),),
                fillColor: Colors.blue[100],
                filled: true,
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
                child: const Padding(padding: EdgeInsets.all(8.0),child: Text('Submit',style: TextStyle(fontSize: 25),),),
                onPressed: (){
                  setState(() {
                    currentDate = DateFormat("yyyy-MM-dd").format(useCustomTime?dateTime:DateTime.now());
                    currentTime = DateFormat("HH-mm-ss").format(useCustomTime?dateTime:DateTime.now());
                    createEntry(
                      sys: sysController.text,
                      dia: diaController.text,
                      sugar: sugarController.text,
                      date: currentDate,
                      time: currentTime
                    );
                    const snackBar = SnackBar(content: Text('Your entry has been created!!'),);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    sysController.clear();
                    diaController.clear();
                    sugarController.clear();
                  });
                },
            ),
          ],
      ),
    );
  }
}
