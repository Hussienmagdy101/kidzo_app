import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kidzo_app/Re-usable_Component/commonbutton.dart';
import 'package:kidzo_app/Re-usable_Component/login_sigup_header.dart';
import 'package:kidzo_app/Re-usable_Component/textbutton.dart';
import 'package:kidzo_app/Screens/App/home.dart';
import 'package:kidzo_app/Screens/welcome_screen/welcome_screen.dart';
import 'package:kidzo_app/Screens/widget/create_new_account_widget.dart';
import 'package:kidzo_app/Screens/widget/forget_pass_screen.dart';
import 'package:kidzo_app/Screens/widget/login_imports.dart';
import 'package:kidzo_app/Screens/widget/login_text_field.dart';

class ParentLoginScreen extends StatefulWidget {
  const ParentLoginScreen({super.key});

  @override
  State<ParentLoginScreen> createState() => _ParentLoginScreenState();
}

class _ParentLoginScreenState extends State<ParentLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) => {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const HomePage(),
                )),
                Fluttertoast.showToast(msg: 'Logged In Successfully'),
                setState(() {
                  isLoading = false;
                }),
              });
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
            headerName: "Login",
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.22),
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
                  top: MediaQuery.of(context).size.height * 0.08,
                ),
                child: Column(
                  children: [
                    LoginTextField(
                      formkey: _formkey,
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    CustomTextButton(
                      alignment: Alignment.centerRight,
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) => const ForgetPassword(
                              isParentLoginScreen: true,
                            ),
                          ),
                        );
                      },
                      textName: "Forget Password?",
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.053,
                    ),
                    if (isLoading == false)
                      CustomCommonButton(
                        buttonColor: const Color(0xFF598393),
                        fontSize: 18,
                        textColor: Colors.white,
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            login();
                          } else {
                            return;
                          }
                        },
                        buttonName: "login",
                      )
                    else
                      LoadingAnimationWidget.staggeredDotsWave(
                        color: const Color(0xFF598393),
                        size: 50,
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.020,
                    ),
                    CreateNewAccountWidget(
                      isParent: true,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
