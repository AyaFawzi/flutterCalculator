import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//Step4: import file 'calculatorButton' to be able to use class 'MyButton'
import 'calculatorButton.dart';

//Step12: call 'MyApp' class ,then run app
void main() => runApp(MyApp());

// Step1: create stateFulWidget
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  String input = "";
  String output = "";
  String temp = "";
  String temp2 = "";
  double finalResult;

  List<String> list = List();

  //Step11: create 'factor' method to calculate factorial
  factor() {
    double fac = double.parse(list.last);
    double res = 1;
    if (fac < 0) {
      fac = fac * -1;
      res = -1;
    }
    if (fac == 0 || fac == 1) {
      list.last = 1.toString();
    } else {
      for (double i = fac; i > 0; i--) {
        res *= i;
      }
      list.last = res.toString();
    }
  }

  //Step9: create 'check' method , used to check if user pressed on button after display the output
  check({String buttonText}) {
    if (temp2 != "") {
      if (temp2 == "Wrong format" || temp2 == "Unable to divide by zero") {
        list.clear();
        output = "";
        input = "";
        temp2 = "";
        print(temp2);
      } else {
        if (buttonText == "." ||
            buttonText == "0" ||
            buttonText == "1" ||
            buttonText == "2" ||
            buttonText == "3" ||
            buttonText == "4" ||
            buttonText == "5" ||
            buttonText == "6" ||
            buttonText == "7" ||
            buttonText == "8" ||
            buttonText == "9") {
          list.clear();
          input = "";
        } else {
          input = temp2;
        }
        output = "";
        temp2 = "";
      }
    }
  }

  //Step10: create 'check2' method, it specified how to display the input if user pressed on -/+ button followed by number or other
  check2() {
    if (!list.isEmpty && list.last == "(-" && temp != '') {
      list.last = "-" + temp;
      temp = "";
      input = input + ")";
    }
    if (temp != "") {
      list.add(temp);
      temp = "";
    }
  }

  //step8: create 'display' method to take calculated input from 'calculate' method and put final shape of output
  display(double number) {
    if (number.truncateToDouble() == number)
      return number.toStringAsFixed(0);
    else if ((number.toString().length > 11))
      return number.toStringAsFixed(11);
    else
      return number.toString();
  }

  // Step6:  start calculator logic => create 'result' method which is one parameter of parameters of button
  // it is used to control if user pressed on any button at any time
  result(String buttonText) {
    setState(() {
      if (buttonText == "=") {
        if (list.isEmpty) {
          input = "";
          output = "";
        }
        check2();
        if (!list.isEmpty) {
          calculate(list);
        }
      } else if (buttonText == "!") {
        check();
        check2();
        if (!list.isEmpty &&
            (list.last != '+' &&
                list.last != '-' &&
                list.last != '*' &&
                list.last != '/' &&
                list.last != '+' &&
                list.last != '(-')) {
          input += buttonText;
          factor();
        }
      } else if (buttonText == "%") {
        check2();
        check();
        if (!list.isEmpty &&
            (list.last != '+' &&
                list.last != '-' &&
                list.last != '*' &&
                list.last != '/' &&
                list.last != '+' &&
                list.last != '(-')) {
          list.last = (double.parse(list.last) / 100).toString();
          input += buttonText;
        }
      } else if (buttonText == "AC") {
        list.clear();
        input = "";
        output = "";
        temp2 = "";
      } else if (buttonText == "+/-") {
        check();
        check2();
        input += '(-';
        list.add('(-');
      } else {
        if ((buttonText == '/' ||
            buttonText == '*' ||
            buttonText == '+' ||
            buttonText == '-')) {
          check2();
          check();

          if (!list.isEmpty &&
              (list.last != '+' &&
                  list.last != '-' &&
                  list.last != '*' &&
                  list.last != '/' &&
                  list.last != '+' &&
                  list.last != '(-')) {
            input += buttonText;
            list.add(buttonText);
          }
        } else {
          check(buttonText: buttonText);
          if (list.isEmpty || input.substring(input.length - 1) != "%") {
            if (buttonText == "." && temp == "") {
              buttonText = "0.";
            }
            input += buttonText;
            temp += buttonText;
          }
        }
      }
    });
  }

  //Step7: create 'calculate' method to calculate the input and out final result for this input
  calculate(List<String> list) {
    if (list.last == "(-") {
      list.last = "Wrong format";
    } else {
      for (int i = 0; i < list.length; i++) {
        if (list[i] == "*") {
          if (i == list.length - 1) {
            list.last = 'Wrong format';
            break;
          }
          finalResult = double.parse(list[i - 1]) * double.parse(list[i + 1]);
          list.removeRange(i - 1, i + 2);
          temp = display(finalResult);
          list.insert(i - 1, temp);
          i = i - 1;
        } else if (list[i] == "/") {
          if (i == list.length - 1) {
            list.last = 'Wrong format';
            break;
          }
          if (double.parse(list[i + 1]) == 0) {
            list.last = "Unable to divide by zero";
            break;
          }

          finalResult = double.parse(list[i - 1]) / double.parse(list[i + 1]);
          list.removeRange(i - 1, i + 2);
          temp = display(finalResult);
          list.insert(i - 1, temp);
          i = i - 1;
        }
      }

      for (int i = 0; i < list.length; i++) {
        if (list[i] == "+") {
          if (i == list.length - 1) {
            list.last = 'Wrong format';
            break;
          }
          finalResult = double.parse(list[i - 1]) + double.parse(list[i + 1]);
          list.removeRange(i - 1, i + 2);
          temp = display(finalResult);
          list.insert(i - 1, temp);
          i = i - 1;
        } else if (list[i] == "-") {
          if (i == list.length - 1) {
            list.last = 'Wrong format';
            break;
          }
          finalResult = double.parse(list[i - 1]) - double.parse(list[i + 1]);
          list.removeRange(i - 1, i + 2);
          temp = display(finalResult);
          list.insert(i - 1, temp);
          i = i - 1;
        }
      }
      if (list.last != "Wrong format" &&
          list.last != "Unable to divide by zero") {
        finalResult = 0;

        for (int i = 0; i < list.length; i++) {
          finalResult += double.parse(list[i]);
          temp = display(finalResult);
          if (i == list.length - 1) {
            list.clear();
            list.add(temp);
          }
        }
      }
    }

    output = list.last;
    temp2 = output;
    temp = "";
  }

  // Step2: in build method,first put design for app by using these widgets and using two Text Widget one for display the input
  //and another for display the output
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      home: Scaffold(
          body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(40),
                      ),
                      Text(
                        input,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        output,
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                ),
                // Step5: inside  each row widget , call ' MyButton' method to create calculator buttons and give it its parameters
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MyButton(
                        buttonText: "AC",
                        buttonColor: Colors.grey[800],
                        textColor: Colors.white,
                        onPress: () => result("AC")),
                    MyButton(
                        buttonText: "+/-",
                        buttonColor: Colors.grey[800],
                        textColor: Colors.white,
                        onPress: () => result("+/-")),
                    MyButton(
                        buttonText: "%",
                        buttonColor: Colors.grey[800],
                        textColor: Colors.white,
                        onPress: () => result("%")),
                    MyButton(
                        buttonText: "/",
                        buttonColor: Colors.yellow[700],
                        textColor: Colors.white,
                        onPress: () => result("/")),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MyButton(
                        buttonText: "7",
                        buttonColor: Colors.grey[200],
                        onPress: () => result("7")),
                    MyButton(
                        buttonText: "8",
                        buttonColor: Colors.grey[200],
                        onPress: () => result('8')),
                    MyButton(
                        buttonText: "9",
                        buttonColor: Colors.grey[200],
                        onPress: () => result('9')),
                    MyButton(
                        buttonText: "*",
                        buttonColor: Colors.yellow[700],
                        textColor: Colors.white,
                        onPress: () => result('*')),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MyButton(
                        buttonText: "4",
                        buttonColor: Colors.grey[200],
                        onPress: () => result('4')),
                    MyButton(
                        buttonText: "5",
                        buttonColor: Colors.grey[200],
                        onPress: () => result('5')),
                    MyButton(
                        buttonText: "6",
                        buttonColor: Colors.grey[200],
                        onPress: () => result('6')),
                    MyButton(
                        buttonText: "-",
                        buttonColor: Colors.yellow[700],
                        textColor: Colors.white,
                        onPress: () => result('-')),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MyButton(
                        buttonText: "1",
                        buttonColor: Colors.grey[200],
                        onPress: () => result('1')),
                    MyButton(
                        buttonText: "2",
                        buttonColor: Colors.grey[200],
                        onPress: () => result('2')),
                    MyButton(
                        buttonText: "3",
                        buttonColor: Colors.grey[200],
                        onPress: () => result('3')),
                    MyButton(
                        buttonText: "+",
                        buttonColor: Colors.yellow[700],
                        textColor: Colors.white,
                        onPress: () => result('+')),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MyButton(
                        buttonText: "0",
                        buttonColor: Colors.grey[200],
                        onPress: () => result('0')),
                    MyButton(
                        buttonText: ".",
                        buttonColor: Colors.grey[200],
                        onPress: () => result('.')),
                    MyButton(
                        buttonText: "!",
                        buttonColor: Colors.grey[200],
                        onPress: () => result('!')),
                    MyButton(
                        buttonText: "=",
                        buttonColor: Colors.yellow[700],
                        textColor: Colors.white,
                        onPress: () => result('=')),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
