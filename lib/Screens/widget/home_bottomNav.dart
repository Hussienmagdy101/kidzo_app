import 'package:flutter/material.dart';
import 'package:kidzo_app/Screens/App/home.dart';




class HomebottomNav extends StatelessWidget {
  const HomebottomNav({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/useraccpng'),
                  alignment: Alignment.topRight,
                )),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const HomePage()));
              },
            ),
          )
        ],
      ),
    );
  }
}
