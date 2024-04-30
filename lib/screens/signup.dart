import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final fnTxtController = TextEditingController();
    final lnTxtController = TextEditingController();
    final passTxtController = TextEditingController();
    final rePassTxtController = TextEditingController();
    final emailTxtController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(" Chalet Sharks",style: TextStyle(
            color:Colors.white,
          ),),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
              //  child:Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: fnTxtController,
                  validator: ValidationBuilder().required().maxLength(50).minLength(3).build(),
                  decoration: const InputDecoration(
                    hintText: "First Name",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: lnTxtController,
                  validator: ValidationBuilder().required().maxLength(50).minLength(3).build(),
                  decoration: const InputDecoration(
                    hintText: "Last Name",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passTxtController,
                  validator: ValidationBuilder().required().maxLength(50).minLength(8).build(),
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(Icons.numbers),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: rePassTxtController,
                  validator: ValidationBuilder()
                      .required()
                      .maxLength(50)
                      .minLength(8)
                      .add(
                        (value) => passTxtController.text.trim() != value?.trim() ? 'The password is not the same' : null,
                      )
                      .build(),
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Confirm Password",
                    prefixIcon: Icon(Icons.numbers),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emailTxtController,
                  validator: ValidationBuilder().email().required().maxLength(50).build(),
                  decoration: const InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(Icons.numbers),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        signup(
                          context,
                          emailTxtController.text.toLowerCase().trim(),
                          passTxtController.text.trim(),
                          fnTxtController.text.trim(),
                          lnTxtController.text.trim(),
                        );
                      }
                    },
                    child: Text("Submit"),
                  ),
                ),
              ]),
        ));
    // );
  }
}

signup(BuildContext context, String emailAddress, String password, String firstName, String lastName) async {
  try {
    final userCredentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );

    userCredentials.user?.updateDisplayName("${firstName}_$lastName");

    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/CategroyScreen', (Route<dynamic> route) => false);
    }
  } on FirebaseAuthException catch (e) {
    String? message;

    if (e.code == 'weak-password') {
      message = 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      message = 'The account already exists for that email login instead.';
    } else if (e.code == 'invalid-email') {
      message = 'The email is invalid please check it again.';
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
