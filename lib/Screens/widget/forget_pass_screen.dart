// ignore_for_file: must_be_immutable
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kidzo_app/Re-usable_Component/commonbutton.dart';
import 'package:kidzo_app/Re-usable_Component/login_sigup_header.dart';
import 'package:kidzo_app/Re-usable_Component/text_field.dart';
import 'package:kidzo_app/Screens/Child/child_login.dart';
import 'package:kidzo_app/Screens/Parent/parent_login.dart';
import 'package:kidzo_app/Screens/widget/login_imports.dart';

import 'imports.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({
    super.key,
    required this.isParentLoginScreen,
  });

  final bool isParentLoginScreen;

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController emailcontroller = TextEditingController();
  final auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  bool? isParentLoginScreen;

  void resetPassword() async {
    setState(() {
      isLoading = true;
    });
    {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailcontroller.text.trim())
            .then((user) => {
                  Fluttertoast.showToast(msg: "An email has been send"),
                  if (isParentLoginScreen == true)
                    {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ParentLoginScreen(),
                        ),
                      ),
                    }
                  else
                    {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ChildLoginScreen(),
                        ),
                      ),
                    },
                  setState(() {
                    isLoading = false;
                  }),
                });
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(msg: e.message.toString(), fontSize: 14);
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              if (isParentLoginScreen = true) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const ParentLoginScreen(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  const ChildLoginScreen(),
                  ),
                );
              }
            }),
        backgroundColor: const Color.fromRGBO(18, 69, 89, 1),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          LoginAndSignupHeader(
            headerName: 'Forget Password',
          ),
          Form(
            key: _formkey,
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.22),
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
                        CustomTextButton(
                          onTap: null,
                          textName:
                              "Enter your email and we will send you a password reset link",
                          textColor: Colors.black,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.020,
                        ),
                        CustomTextField(
                          autoCorrect: false,
                          cursorHeight: null,
                          hintText: "example@example.com",
                          keyboardType: TextInputType.emailAddress,
                          labelText: "Enter your Email you want to recover",
                          obscureText: false,
                          suffixIcon: const Icon(
                            Icons.email,
                            color: Color(0xFF598393),
                          ),
                          textInputAction: TextInputAction.done,
                          controller: emailcontroller,
                          hintStyle: const TextStyle(color: Color(0xFF598393)),
                          textStyle: null,
                          cursorColor: const Color.fromRGBO(18, 69, 89, 1),
                          onSaved: (value) {
                            emailcontroller.text = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ('Please enter your email');
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ('Please enter a valid email');
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        if (isLoading == false)
                          CustomCommonButton(
                            textColor: Colors.white,
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                resetPassword();
                              } else {
                                return;
                              }
                            },
                            buttonName: "Reset password",
                          )
                        else
                          LoadingAnimationWidget.staggeredDotsWave(
                            color: const Color(0xFF598393),
                            size: 50,
                          ),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
