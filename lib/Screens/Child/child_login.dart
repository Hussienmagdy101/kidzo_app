
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kidzo_app/Re-usable_Component/commonbutton.dart';
import 'package:kidzo_app/Re-usable_Component/login_sigup_header.dart';
import 'package:kidzo_app/Re-usable_Component/textbutton.dart';
import 'package:kidzo_app/Screens/Child/childHP.dart';
import 'package:kidzo_app/Screens/welcome_screen/welcome_screen.dart';
import 'package:kidzo_app/Screens/widget/create_new_account_widget.dart';
import 'package:kidzo_app/Screens/widget/forget_pass_screen.dart';
import 'package:kidzo_app/Screens/widget/login_imports.dart';
import 'package:kidzo_app/Screens/widget/login_text_field.dart';

class ChildLoginScreen extends StatefulWidget {
  const ChildLoginScreen({super.key});

  @override
  State<ChildLoginScreen> createState() => _ChildLoginScreenState();
}

class _ChildLoginScreenState extends State<ChildLoginScreen> {
  final TextEditingController childEmailController = TextEditingController();
  final TextEditingController childPasswordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;

  Future login() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: childEmailController.text,
              password: childPasswordController.text)
          .then((value) => {
                setState(() {
                  isLoading = false;
                }),
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const ChildHomePage())),
                Fluttertoast.showToast(msg: 'Logged In Successfully')
              });
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: e.message.toString());
    }
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
            paddingAllSizeHeight: 0.040,
            headerName: "Child Login",
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.22,
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
                  top: MediaQuery.of(context).size.height * 0.08,
                ),
                child: Column(
                  children: [
                    LoginTextField(
                      formkey: _formkey,
                      emailController: childEmailController,
                      passwordController: childPasswordController,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    CustomTextButton(
                      alignment: Alignment.centerRight,
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const ForgetPassword(
                              isParentLoginScreen: false,
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
                      isParent: false,
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
