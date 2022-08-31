import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import '../button.dart';
import '../constants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

//Project variable
String fullnameregister = '';

class _SignupScreenState extends State<SignupScreen> {
  final formkey = GlobalKey<FormState>();
  //Class variables
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool isloading = false;
  @override

  //Main widget
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(), //Go back to login
        ),
      ),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: formkey,
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: SingleChildScrollView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.1.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 37.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value.toString().trim();
                        },
                        validator: (value) =>
                            (value!.isEmpty) ? ' Please enter email' : null,
                        textAlign: TextAlign.center,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter Your Email',
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Full Name";
                          }
                        },
                        onChanged: (value) {
                          fullnameregister = value;
                        },
                        textAlign: TextAlign.center,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Full Name',
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Colors.black,
                            )),
                      ),
                      SizedBox(height: 5.h),
                      TextFormField(
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Password";
                          }
                        },
                        onChanged: (value) {
                          password = value;
                        },
                        textAlign: TextAlign.center,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Choose a Password',
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.black,
                            )),
                      ),
                      SizedBox(height: 5.h),
                      LoginSignupButton(
                        title: 'Register',
                        ontapp: () async {
                          if (formkey.currentState!.validate()) {
                            setState(() {
                              isloading = true;
                            });
                            try {
                              //Register
                              final UserCredential user =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: email, password: password);
                              setUser(user);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.blueGrey,
                                  content: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                        'Sucessfully Register.You Can Login Now'),
                                  ),
                                  duration: Duration(seconds: 5),
                                ),
                              );
                              Navigator.of(context).pop();
                              setState(() {
                                isloading = false;
                              });
                            } on FirebaseAuthException catch (e) {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title:
                                      const Text(' Ops! Registration Failed'),
                                  content: Text('${e.message}'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: const Text('Okay'),
                                    )
                                  ],
                                ),
                              );
                            }
                            setState(() {
                              isloading = false;
                            });
                          }
                        },
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        'BadgeAI by Lior & Amit',
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

//Set user in firestore database
Future<void> setUser(UserCredential user) async {
  FirebaseFirestore.instance
      .collection('users')
      .doc(user.user!.uid) // <-- Document ID
      .set({
    'uid': user.user!.uid,
    'email': user.user!.email,
    'fullname': fullnameregister,
    'doors': 'None',
    '/Building1/Door1': false,
    '/Building1/Door2': false,
    '/Building2/Door1': false
  }); // <-- Your data
}
