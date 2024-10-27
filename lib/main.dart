import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic displaytxt = 20;


  Widget calcButton(String btntxt, Color btncolor, Color txtcolor) {
    return ElevatedButton(
      onPressed: () {
        calculation(btntxt);
      },
      child: Text(
        btntxt,
        style: TextStyle(fontSize: 30, color: txtcolor),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: btncolor,
        shape: RoundedRectangleBorder(),
        minimumSize: Size(80, 80),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
   
          Padding(
            padding: EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Text(
                '$text',
                style: TextStyle(color: Colors.white, fontSize: 60),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              padding: EdgeInsets.all(10.0),
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              children: <Widget>[
                calcButton('AC', Colors.grey, Colors.black),
                calcButton('+/-', Colors.grey, Colors.black),
                calcButton('%', Colors.grey, Colors.black),
                calcButton('/', Colors.amber[700] ?? Colors.amber, Colors.white),
                calcButton('7', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('8', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('9', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('x', Colors.amber[700] ?? Colors.amber, Colors.white),
                calcButton('4', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('5', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('6', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('-', Colors.amber[700] ?? Colors.amber, Colors.white),
                calcButton('1', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('2', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('3', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('+', Colors.amber[700] ?? Colors.amber, Colors.white),
                calcButton('0.0', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('0', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('.', Colors.grey[850] ?? Colors.grey, Colors.white),
                calcButton('=', Colors.amber[700] ?? Colors.amber, Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Calculator logic
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;
  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';

  void calculation(btnText) {
    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') finalResult = add();
      else if (preOpr == '-') finalResult = sub();
      else if (preOpr == 'x') finalResult = mul();
      else if (preOpr == '/') finalResult = div();
    } else if (btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }
      if (opr == '+') finalResult = add();
      else if (opr == '-') finalResult = sub();
      else if (opr == 'x') finalResult = mul();
      else if (opr == '/') finalResult = div();
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = (numOne / 100).toString();
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }
    setState(() {
      text = finalResult;
    });
  }

  String add() => doesContainDecimal((numOne + numTwo).toString());
  String sub() => doesContainDecimal((numOne - numTwo).toString());
  String mul() => doesContainDecimal((numOne * numTwo).toString());
  String div() => doesContainDecimal((numOne / numTwo).toString());

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) return splitDecimal[0].toString();
    }
    return result;
  }
}
