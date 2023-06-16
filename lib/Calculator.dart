import 'package:flutter/material.dart';
import 'package:calculator/Buttons.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:get/get.dart';
import 'theme.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var input = "";
  var output = "";
  var inputsize = 50.0;
  var outputsize = 32.0;

  var theme = Get.put(themeController());

  final List<String> buttons = [
    "AC",
    "DEL",
    "%",
    "÷",
    "7",
    "8",
    "9",
    "×",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "lg",
    "0",
    ".",
    "=",
  ];

  bool click = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.islight ? Colors.white : Colors.black87,
      appBar: AppBar(
        // actions: <Widget>[
          leading: IconButton(
              onPressed: (){
                setState(() {
                    if(theme.islight) {
                      theme.darkTheme();
                    }
                    else
                      theme.lightTheme();
                });
              },
              icon: Icon((theme.islight == true) ? Icons.dark_mode_outlined :
                Icons.light_mode_outlined, color: Colors.deepOrangeAccent),
            ),
        // ],
        backgroundColor: Colors.transparent,
        elevation: 0,
    ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: theme.islight ? Colors.white : Colors.black87,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        input, style: TextStyle(fontSize: inputsize, color: theme.islight ? Colors.black : Colors.white),
                      )),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Container(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        output, style: TextStyle(fontSize: outputsize, color: theme.islight ? Colors.black : Colors.white),
                      ))
                ],
              ),
            ),
          )),
          Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.islight ? Colors.white : Colors.black87,
                ),
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 0.0,
                            crossAxisSpacing: 0.0),
                    itemBuilder: (BuildContext context, int index) {

                      if(index == 0) {
                        return Buttons(
                          Character: (){
                            setState(() {
                              inputsize = 50.0;
                              outputsize = 32.0;
                              input = "";
                              output="";
                              buttons[0] = "AC";
                            });
                          },
                          fntsize: 25.0,
                          txtcolor: Colors.deepOrangeAccent,
                          color: Colors.transparent,
                          buttontxt: buttons[index],
                        );
                      }
                      else if(index == 1) {
                        return Buttons(
                          Character: (){
                            setState(() {
                              input = input.substring(0, input.length-1);
                            });
                          },
                          fntsize: 25.0,
                          txtcolor: Colors.deepOrangeAccent,
                          color: Colors.transparent,
                          buttontxt: buttons[index],
                        );
                      }
                      if (index == buttons.length - 1) {
                        return Buttons(
                          Character: () {
                            setState(() {
                              inputsize = 32.0;
                              outputsize = 50.0;
                              buttonTapped();
                            });
                          },
                          txtcolor: Colors.white,
                          fntsize: 30.0,
                          buttontxt: buttons[index],
                          color: Colors.deepOrangeAccent,
                        );
                      } else {
                        return Buttons(
                          Character: () {
                            setState(() {
                              input += buttons[index];
                              buttons[0] = "C";
                            });
                          },
                          txtcolor: (isCharacter(buttons[index]) || buttons[index] == "lg")
                              ? Colors.deepOrangeAccent
                              : theme.islight ? Colors.black : Colors.white,
                          fntsize: isCharacter(buttons[index]) ? 30.0: 25.0,
                          buttontxt: buttons[index],
                          color: Colors.transparent,
                        );
                      }
                    }),
              )),
        ],
      ),
    );
  }

  bool isCharacter(String s) {
    if (
        s == "%" ||
        s == "÷" ||
        s == "×" ||
        s == "-" ||
        s == "+" ||
        s == "=" ) {
      return true;
    } else {
      return false;
    }
  }

  void buttonTapped() {
    String i = input;
    i = i.replaceAll("×", "*");
    i = i.replaceAll("÷", "/");

    Parser p = Parser();
    Expression exp = p.parse(i);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    output = "= $eval";
    if(output.endsWith(".0"))
      {
        output = output.replaceAll(".0", "");
      }

  }

}
