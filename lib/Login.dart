import 'package:firebase/userAuth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Signup.dart';
import 'Home.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}



class _LoginState extends State<Login>  {




  final FirebaseAuthService _auth = FirebaseAuthService();



  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }




  //this is used to find the state of the form
  final _formKey = GlobalKey<FormState>();

  //email validation regex
  final emailRegEx = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

  //password hide & show
  bool _isVisible = false;

  void updateStatus(){
    setState(() {
      _isVisible = !_isVisible;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("Login")),
      ),
      //body applied with background image
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            height: double.infinity,
            width: double.infinity,


            //overall column
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                //card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    //textField & button
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          //email
                          TextFormField(
                            controller:_emailController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.mail),
                              labelText: "Email *",
                              hintText: "Enter your email address ",
                              border: OutlineInputBorder(),
                            ),

                            validator: (value){
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email address';
                              }
                              if (!emailRegEx.hasMatch(value)) {
                                return 'Please enter valid email address';
                              }
                              return null;
                            },
                          ),

                          //password
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _isVisible ? false : true,
                            decoration: InputDecoration(
                              prefixIcon:Icon(Icons.lock_outline) ,
                              labelText: "Password *",
                              hintText: "Enter your password ",
                              suffixIcon:IconButton(
                                onPressed: () => updateStatus(),
                                icon:Icon(_isVisible ? Icons.visibility: Icons.visibility_off),
                              ),
                              border: OutlineInputBorder(),
                            ),

                            validator: (value){
                              if (value == null || value.isEmpty){
                                return "Please enter your password";
                              }
                              return null;
                            },
                          ),

                          Container(
                            width: 200,
                            height: 40,
                            child: ElevatedButton(
                                onPressed: (){
                                  if(_formKey.currentState!.validate()){
                                    _signIn();
                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()),(route) => false);
                                  }
                                },
                                child: Text("LOGIN")
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("New User? "),
                              GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> Signup()),(route) => false);
                                  },
                                  child: Text(" Signup",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _signIn() async{
    String email = _emailController.text;
    String password = _passwordController.text;


    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user!= null){
      print("User is successfully signed in");
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> Home()), (route) => false);
    } else {
      print("Some Error happened");
    }
  }
}