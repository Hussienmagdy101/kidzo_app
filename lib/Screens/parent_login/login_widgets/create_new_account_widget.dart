// ignore_for_file: must_be_immutable

import 'imports.dart';

class CreateNewAccountWidget extends StatelessWidget {
  CreateNewAccountWidget({
    super.key,
    required this.isParent,
  });

  bool isParent;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CustomTextButton(
        onTap: null,
        textName: "Don't have account?",
        isBold: true,
        textColor: Colors.grey,
        textFontSize: 15,
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.005,
      ),
      CustomTextButton(
        textFontSize: 21,
        onTap: () {
          if (isParent == true) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => const ParentSignUpScreen(),
              ),
            );
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => const ChildSignUpScreen(),
              ),
            );
          }
        },
        textName: "Sign Up",
      ),
    ]);
  }
}
