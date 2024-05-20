import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kidzo_app/Re-usable_Component/commonbutton.dart';
import 'package:kidzo_app/Re-usable_Component/login_sigup_header.dart';
import 'package:kidzo_app/Screens/App/home.dart';
import 'package:kidzo_app/Screens/packages/appInformation.dart';
import 'package:kidzo_app/Screens/welcome_screen/welcome_screen.dart';
import 'package:kidzo_app/Screens/widget/already_have_account.dart';
import 'package:kidzo_app/Screens/widget/login_imports.dart';
import 'package:kidzo_app/Screens/widget/signup_text_field.dart';

class ParentSignUpScreen extends StatefulWidget {
  const ParentSignUpScreen({super.key});

  @override
  State<ParentSignUpScreen> createState() => _ParentSignUpScreenState();
}

class _ParentSignUpScreenState extends State<ParentSignUpScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future signUp() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: newEmailController.text.trim(),
            password: newPasswordController.text.trim());
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const HomePage()));
        final User? user = FirebaseAuth.instance.currentUser;
        final uid = user?.uid;
        final code = generateCode();
        Appinformation appinformation = Appinformation('', '', '', '', false);
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'id': uid,
          'Name': usernameController.text,
          'Email': newEmailController.text,
          'Password': newPasswordController.text,
          'code': code,
          'appinfo': appinformation.toJson()
        }).then(
          (value) => Fluttertoast.showToast(msg: 'Created successfully'),
        );
        setState(() {
          isLoading = false;
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
          msg: 'Cant create account because ${e.message.toString()}');
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    newEmailController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  String generateCode() {
    const String alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789';
    const int codelength = 6;
    final Random random = Random();
    String code = '';

    for (int i = 0; i < codelength; i++) {
      final int randomIndex = random.nextInt(alphabet.length);
      code += alphabet[randomIndex];
    }
    return code;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(18, 69, 89, 1),
        foregroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => const WelcomeScreen(),
                ),
              );
            }),
      ),
      body: Stack(
        children: [
          LoginAndSignupHeader(
            headerName: "Create Your Account",
            paddingAllSizeHeight: 0.038,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.18,
            ),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 18,
                    right: 18,
                    top: MediaQuery.of(context).size.height * 0.06,
                  ),
                  child: Column(
                    children: [
                      SignupTextField(
                        isParent: true,
                        fullNameController: usernameController,
                        formkey: _formKey,
                        emailController: newEmailController,
                        passwordController: newPasswordController,
                        confirmPasswordController: confirmPasswordController,
                      ),
                      if (isLoading == false)
                        CustomCommonButton(
                          buttonColor: const Color(0xFF598393),
                          fontSize: 18,
                          textColor: Colors.white,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              signUp();
                            } else {
                              return;
                            }
                          },
                          buttonName: "Sign Up",
                        )
                      else
                        LoadingAnimationWidget.staggeredDotsWave(
                          color: const Color(0xFF598393),
                          size: 50,
                        ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020,
                      ),
                      AlreadyHaveAccount(
                        isParent: true,
                      )
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
