import 'package:chalet_sharks/screens/login.dart';
import 'package:chalet_sharks/screens/signup.dart';
import 'package:flutter/material.dart';
class First extends StatefulWidget {
  const First({super.key});

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        title: Text("Chalet Sharks ",style: TextStyle(
        color:Colors.white
      ),),),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      
          Container(
            margin:const EdgeInsets.symmetric(horizontal:20),
            decoration: BoxDecoration(
              color:const Color.fromARGB(255, 23, 132, 221),
              borderRadius: BorderRadius.circular(50)
            ),
            child: Center(
              child:MaterialButton(
                minWidth: double.infinity,
                onPressed:(){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
                },
                child:const Text("login",style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
                  
              ),
            ),
          ),
          const SizedBox(height: 30,),
          Container(
            margin:const EdgeInsets.symmetric(horizontal:20),
            decoration: BoxDecoration(
              color:const Color.fromARGB(255, 23, 132, 221),
              borderRadius: BorderRadius.circular(50)
            ),
            child: Center(
              child:MaterialButton(
                minWidth: double.infinity,
                onPressed:(){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignupScreen()));
                },
                child:const Text("signup",style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
                  
              ),
            ),
          ),
          
        ],
      )
    );
  }
}