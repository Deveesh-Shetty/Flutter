import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class Conversion extends StatefulWidget {
  const Conversion({super.key});
  State<StatefulWidget> createState() => _ConversionState();
}

class _CalculatorState extends State<Calculator> {
  // __number stores the intermediate number if the user is
  // entering multidigit number which he will....

  double result = 0.toDouble();
  String? firstNumber;
  String? __number;
  String? secondNumber;
  String? operator;

  int precision = 4;
  double buttonPadding = 25.0;

  double? firstNumberVal;
  double? secondNumberVal;

  void onButtonClick(var character) {
    if (character == '=') {
      setState(() {
        if (firstNumber == null || secondNumber == null) return;

        double firstNumberVal = double.parse(firstNumber!);
        double secondNumberVal = double.parse(secondNumber!);

        if (operator == '+') {
          result = firstNumberVal + secondNumberVal;
        } else if (operator == '-') {
          result = firstNumberVal - secondNumberVal;
        } else if (operator == 'x') {
          result = firstNumberVal * secondNumberVal;
        } else if (operator == '/') {
          result = firstNumberVal / secondNumberVal;
        } else if (operator == '%') {
          result = (firstNumberVal * secondNumberVal) / 100;
        }

        setState(() {
          // Below statement means that we can continue the next operation
          // once user presses '=' by taking previous result as first number
          firstNumber = result.toString();
          operator = null;
          secondNumber = null;
        });
      });

      return;
    }

    if (character == 'bksp') {
      return setState(() {
        if (firstNumber == null) {
          return;
        } else if (secondNumber == null) {
          // Basically removing the last digit by dividing by 10
          // and then removing the decimal by floor()
          return setState(() {
            firstNumber = (double.parse(firstNumber!) / 10).floor().toString();
          });
        } else {
          return setState(() {
            firstNumber = (double.parse(secondNumber!) / 10).floor().toString();
          });
        }
      });
    }

    // TODO: Add Decimal point use
    // Have to convert first and second number to double
    if (character == '.') {
      if (firstNumber == null) return;
      return setState(() {
        firstNumber = '$firstNumber.';
        print('$firstNumber');
      });
    }

    if (character.runtimeType == String) {
      if (character == '.') return;

      if (firstNumber == null) {
        return;
      }
      return setState(() {
        operator = character;
      });
    }

    if (character.runtimeType == int) {
      character = character.toDouble();
      if (operator == null) {
        return setState(() {
          // If the user wants to enter multidigit then we are
          // multipling the previous number with 10 and adding the new digit
          __number = character.toString();
          firstNumber =
              firstNumber == null ? __number : '$firstNumber$__number';
        });
      }
      if (firstNumber != null) {
        return setState(() {
          __number = character.toString();
          secondNumber =
              secondNumber == null ? __number : '$secondNumber$__number';
        });
      }
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          color: Color.fromRGBO(20, 20, 20, 1),
          width: width,
          height: height * 0.35,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    (() {
                      if (firstNumber == null) {
                        return '';
                      }
                      if (operator == null) {
                        return '$firstNumber';
                      }
                      if (secondNumber == null) {
                        return '$firstNumber $operator';
                      }
                      return '$firstNumber $operator $secondNumber';
                    })(),
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.8),
                      fontSize: 48,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      // If the result has .0 then remove it else print
                      // with precision which is mention
                      result.toStringAsFixed(
                          result.truncateToDouble() == result ? 0 : precision),
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 96,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            width: width,
            height: height * 0.65,
            child: Column(
              children: [
                // Row 1
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      KeyButton(
                        text: 'AC',
                        onClick: () {
                          setState(() {
                            result = 0.toDouble();
                            firstNumber = null;
                            secondNumber = null;
                            operator = null;
                          });
                        },
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            onButtonClick('bksp');
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(35),
                            shape: CircleBorder(),
                            elevation: 6,
                            shadowColor: Color.fromRGBO(0, 0, 0, 1),
                          ),
                          child: Icon(
                            Icons.backspace,
                          ),
                        ),
                      ),
                      KeyButton(
                        text: '%',
                        onClick: () {
                          onButtonClick('%');
                        },
                      ),
                      KeyButton(
                        text: '/',
                        onClick: () {
                          onButtonClick('/');
                        },
                      ),
                    ],
                  ),
                ),

                // Row 2
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      KeyButton(
                        text: '7',
                        onClick: () {
                          onButtonClick(7);
                        },
                      ),
                      KeyButton(
                        text: '8',
                        onClick: () {
                          onButtonClick(8);
                        },
                      ),
                      KeyButton(
                        text: '9',
                        onClick: () {
                          onButtonClick(9);
                        },
                      ),
                      KeyButton(
                        text: 'x',
                        onClick: () {
                          onButtonClick('x');
                        },
                      ),
                    ],
                  ),
                ),

                // Row 3
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      KeyButton(
                        text: '4',
                        onClick: () {
                          onButtonClick(4);
                        },
                      ),
                      KeyButton(
                        text: '5',
                        onClick: () {
                          onButtonClick(5);
                        },
                      ),
                      KeyButton(
                        text: '6',
                        onClick: () {
                          onButtonClick(6);
                        },
                      ),
                      KeyButton(
                        text: '-',
                        onClick: () {
                          onButtonClick('-');
                        },
                      ),
                    ],
                  ),
                ),

                // Row 4
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      KeyButton(
                        text: '1',
                        onClick: () {
                          onButtonClick(1);
                        },
                      ),
                      KeyButton(
                        text: '2',
                        onClick: () {
                          onButtonClick(2);
                        },
                      ),
                      KeyButton(
                        text: '3',
                        onClick: () {
                          onButtonClick(3);
                        },
                      ),
                      KeyButton(
                        text: '+',
                        onClick: () {
                          onButtonClick('+');
                        },
                      ),
                    ],
                  ),
                ),

                // Row 5
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      KeyButton(
                        text: 'C',
                        onClick: () {
                          setState(() {
                            if (firstNumber != null) {
                              return firstNumber = null;
                            }
                            if (secondNumber != null) {
                              return secondNumber = null;
                            }
                          });
                        },
                      ),
                      KeyButton(
                        text: '0',
                        onClick: () {
                          onButtonClick(0);
                        },
                      ),
                      KeyButton(
                        text: '.',
                        onClick: () {
                          onButtonClick('.');
                        },
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            onButtonClick('=');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: theme.colorScheme.onPrimary,
                            padding: EdgeInsets.all(25),
                            textStyle: TextStyle(
                              fontSize: 35,
                            ),
                            shape: CircleBorder(),
                            elevation: 6,
                            shadowColor: Color.fromRGBO(0, 0, 0, 1),
                          ),
                          child: Text('='),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _ConversionState extends State<Conversion> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
      ),
      drawer: Drawer(
        child: Text('land'),
      ),
      drawerScrimColor: Color.fromRGBO(0, 0, 0, 0.5),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {},
          child: Text('Hello'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text('Hello'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text('Hello'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text('Hello'),
        )
      ],
    );
  }
}

class KeyButton extends StatelessWidget {
  final String text;
  final Function onClick;
  const KeyButton({super.key, required this.text, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          onClick();
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(25),
          textStyle: TextStyle(
            fontSize: 35,
          ),
          shape: CircleBorder(),
          elevation: 6,
          shadowColor: Color.fromRGBO(0, 0, 0, 1),
        ),
        child: Text(text),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int bottomNavigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    Widget page;
    switch (bottomNavigationIndex) {
      case 0:
        // Calculator();
        page = Calculator();
        break;
      case 1:
        // Converter();
        page = Conversion();
        break;
      default:
        throw UnimplementedError('No widget for $bottomNavigationIndex');
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.scale),
            label: 'Conversion',
          ),
        ],
        selectedItemColor: theme.colorScheme.primary,
        currentIndex: bottomNavigationIndex,
        onTap: (int index) {
          setState(() {
            bottomNavigationIndex = index;
          });
        },
      ),
      body: Container(
        child: page,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
