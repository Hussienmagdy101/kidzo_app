// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:kidzo_app/Re-usable_Component/textbutton.dart';

class LoginAndSignupHeader extends StatelessWidget {
  LoginAndSignupHeader({
    super.key,
    required this.headerName,
    this.paddingAllSizeHeight = 0.048,
  });

  final String headerName;
  num paddingAllSizeHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(18, 69, 89, 1),
            Color.fromRGBO(18, 69, 89, 1)
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(
            MediaQuery.of(context).size.height * paddingAllSizeHeight),
        child: CustomTextButton(
          onTap: null,
          textName: headerName,
          isBold: true,
          textColor: Colors.white,
          textFontSize: 30,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}
