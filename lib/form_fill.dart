import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class FormFill extends StatefulWidget {
  const FormFill({Key? key}) : super(key: key);

  @override
  State<FormFill> createState() => _FormFillState();
}

class _FormFillState extends State<FormFill> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('assets/main_logo.png'),
    );
  }
}
