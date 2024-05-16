import 'package:flutter/material.dart';

class CatecoryCard extends StatefulWidget {
  final String svgScr;
  final String title;
  final void Function()? onTap;

  const CatecoryCard({
    super.key,
    required this.svgScr,
    required this.title,
    required this.onTap,
  });

  @override
  State<CatecoryCard> createState() => _CatecoryCardState();
}

class _CatecoryCardState extends State<CatecoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 17),
            blurRadius: 15,
            spreadRadius: -19,
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          child: Column(
            children: <Widget>[
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  widget.svgScr,

                  width: 140,
                  height: 100,
                  fit: BoxFit.contain, // Ensure the image covers the entire box
                ),
              ),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(18, 69, 89, 1),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
