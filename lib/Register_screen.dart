import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _confirmPasswordController = TextEditingController();

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 200.0,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                hintText: "User Email",
                prefixIcon: Icon(Icons.mail, color: Colors.black)),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock, color: Colors.black)),
            )),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _confirmPasswordController,
            obscureText: true,
            decoration: const InputDecoration(
                hintText: "Confirm Password",
                prefixIcon: Icon(Icons.lock, color: Colors.black)),
          ),
        ),
        Container(
          width: double.infinity,
          child: RawMaterialButton(
            fillColor: Color.fromARGB(255, 0, 0, 247),
            elevation: 0.0,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            onPressed: () async {
              try {
                final credential =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: _emailController.text,
                  password: _passwordController.text,
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  print('The password provided is too weak.');
                } else if (e.code == 'email-already-in-use') {
                  print('The account already exists for that email.');
                }
              } catch (e) {
                print(e);
              }
            },
            child: const Text(
              "Sign-up",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
      ],
    )));
  }
}
