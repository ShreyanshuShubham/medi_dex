import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  Future signIn() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()
    );
  }
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOGIN'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 35,),
              Image.asset('assets/main_logo.png'),
              SizedBox(height: 15,),
              TextField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email,color: Colors.blue),
                  labelText: "Email",
                  border: UnderlineInputBorder(borderRadius: BorderRadius.circular(5.0),),
                  fillColor: Colors.blue[100],
                  filled: true,
                ),
              ),
              const SizedBox(height: 15,),
              TextField(
                controller: passwordController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password,color: Colors.blue),
                  labelText: "Password",
                  border: UnderlineInputBorder(borderRadius: BorderRadius.circular(5.0),),
                  fillColor: Colors.blue[100],
                  filled: true,
                ),
                obscureText: true,
              ),
              const SizedBox(height: 15,),
              ElevatedButton(
                  onPressed: signIn,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Sign in",style: TextStyle(fontSize: 25),),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
