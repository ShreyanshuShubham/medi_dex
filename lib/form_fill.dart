import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:intl/intl.dart';

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
  @override
  Widget build(BuildContext context) {
    // return const Center(child: Text("FormFill"),);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/6,),
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
            Text("DATE : $currentDate"),
            Text("TIME : $currentTime"),
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
                  ),
                ),
                // SizedBox(width: 35,),
                SizedBox(
                  width: MediaQuery.of(context).size.width /2.5,
                  child: TextField(
                    controller: sysController,
                    decoration: InputDecoration(
                      // prefixIcon: const ImageIcon(AssetImage('assets/blood-pressure.png'),color: Colors.black38,),
                      labelText: "  Dia",
                      border: UnderlineInputBorder(borderRadius: BorderRadius.circular(5.0),),
                      fillColor: Colors.blue[100],
                      filled: true,
                    ),
                    keyboardType: TextInputType.number,
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
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
                child: const Padding(padding: EdgeInsets.all(8.0),child: Text('Submit',style: TextStyle(fontSize: 25),),),
                onPressed: (){
                  setState(() {
                    currentDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
                    currentTime = DateFormat("HH-mm-ss").format(DateTime.now());
                  });
                },
            ),
          ],
        ),
      ),
    );
  }
}
