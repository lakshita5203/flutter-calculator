import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {

  final txtcolor;
  final buttontxt;
  final color;
  final Character;
  final fntsize;

  const Buttons({super.key, this.color, this.buttontxt, this.txtcolor, this.Character, this.fntsize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Character,
      child: Padding(
          padding: const EdgeInsets.all(12.0),
          child:  ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Container(
              color: color,
              child: Center(
                  child: Text(buttontxt, style: TextStyle(color: txtcolor, fontSize: fntsize),)),
            ),
          ),),
    );
  }
}
