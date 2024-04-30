import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final passTxtController = TextEditingController();
  final emailTxtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        title: Text("Chalet Sharks",style: TextStyle(
          color: Colors.white,
        ),),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          // child:Column(
          children: [
            Image.asset("assets/chalett.jpeg"),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: emailTxtController,
              validator: ValidationBuilder().required().build(),
              decoration: const InputDecoration(hintText: "Email", prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passTxtController,
              validator: ValidationBuilder().required().build(),
              obscureText: true,
              decoration: const InputDecoration(hintText: "Password", prefixIcon: Icon(Icons.password), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    signin(
                      context,
                      emailTxtController.text.toLowerCase().trim(),
                      passTxtController.text.trim(),
                    );
                  }
                },
                child: Text("Login")),
          ],
        ),
      ),
    );
    // );
  }
}

signin(BuildContext context, String emailAddress, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/CategroyScreen', (Route<dynamic> route) => false);
    }
  } on FirebaseAuthException catch (e) {
    String? message;

    if (e.code == 'user-not-found') {
      message = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      message = 'Wrong password provided for that user.';
    } else if (e.code == 'invalid-email') {
      message = 'The email is invalid please check it again.';
    } else if (e.code == 'user-disabled') {
      message = 'The user corresponding to the given email has been disabled.';
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message ?? "Unknown error code: ${e.code}"),
        duration: Duration(milliseconds: 700),
      ));
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Unknown error: ${e}"),
        duration: Duration(milliseconds: 700),
      ));
    }
  }
}
