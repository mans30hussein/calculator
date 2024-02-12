import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> symbol = [
    'C',
    'Del',
    '%',
    '/',
    '9',
    '8',
    '7',
    '*',
    '6',
    '5',
    '4',
    '+',
    '3',
    '2',
    '1',
    '-',
    '.',
    '0',
    'Ans',
    '=',
  ];

  String input = "";

  String output = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Calculator",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              alignment: Alignment.topLeft,
              child: Text(
                input,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child:  Text(
                output,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  color: Colors.redAccent,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: symbol.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if(symbol[index] == "C"){
                          setState(() {
                            input = '' ;
                            output = '' ;
                          });
                        } else if(symbol[index] == "Del"){
                         setState(() {
                           input = input.substring(0 , input.length -1) ;
                         });
                        }else if(symbol[index] == "Ans"){
                          setState(() {
                            input = output;
                            output = '' ;
                          });
                        } else if(symbol[index] == '%' ||
                            symbol[index] == '/' ||
                            symbol[index] == '*' ||
                            symbol[index] == '+' ||
                            symbol[index] == '-'){
                          if(input.endsWith("%") ||
                              input.endsWith("*") ||
                              input.endsWith("/") ||
                              input.endsWith("+") ||
                              input.endsWith("-")){
                          } else {
                            setState(() {
                              input += symbol[index];
                            });
                          }
                        } else if(symbol[index] == "="){
                          try{
                            Expression exp = Parser().parse(input) ;
                            double result = exp.evaluate(EvaluationType.REAL, ContextModel()) ;

                            setState(() {
                              output = result.toString() ;
                            });
                          } catch (e){
                            throw StateError('Variable not bound: ${input}');

                          }

                        }
                        else if(input.length == 30){
                         setState(() {
                           Text(input , style: TextStyle(
                             fontSize: 20,
                           ),);
                         });
                        }
                          else{
                          setState(() {
                            input += symbol[index] ;
                          });
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: myBackgroundcolor(symbol[index]),
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          symbol[index],
                          style: TextStyle(
                            color: myText(symbol[index]),
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color myBackgroundcolor(String x) {
    if (x == "C") {
      return Colors.teal.shade400;
    } else if (x == "Del") {
      return Colors.red;
    } else if (x == '%' ||
        x == '/' ||
        x == '*' ||
        x == '=' ||
        x == '-' ||
        x == '+' ||
        x == '*') {
      return Colors.blueAccent.shade200;
    } else {
      return Colors.grey.shade400;
    }
  }

  Color myText(String x) {
    if (x == '%' ||
        x == '/' ||
        x == '*' ||
        x == '=' ||
        x == '-' ||
        x == '+' ||
        x == '*' ||
        x == "Del" ||
        x == 'C') {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }
}
