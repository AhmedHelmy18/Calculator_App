import 'package:flutter/material.dart';
import 'button_value.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String number1 = '';
  String operand = '';
  String number2 = '';

  bool ThemeColor = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorTheme(),
      appBar: AppBar(
        backgroundColor: ColorTheme(),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Image.asset('asset/playstore.png'),
        ),
        title: Text(
          'Calculator',
          style: TextStyle(
            color: ThemeColor ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                ThemeColor = !ThemeColor;
              });
            },
            icon: ThemeColor
                ? Icon(
                    Icons.brightness_3,
                    color: ThemeColor ? Colors.white : Colors.black,
                  )
                : Icon(
                    Icons.wb_sunny,
                    color: ThemeColor ? Colors.white : Colors.black,
                  ),
          )
        ],
      ),
      body: Column(
        children: [
          // Display Section (flexible to take available space)
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                reverse: true,
                child: Text(
                  _getDisplayText(),
                  style:  TextStyle(
                    color: ThemeColor ? Colors.white : Colors.black,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ),
          // Buttons Section (fixed at the bottom)
          Wrap(
            children: Btn.buttonValues
                .map(
                  (value) => SizedBox(
                    width: value == Btn.n0
                        ? screenSize.width / 2
                        : (screenSize.width / 4),
                    height: screenSize.width / 5,
                    child: BuildButton(value),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget BuildButton(String value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: getBtnColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white24,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: InkWell(
          onTap: () => onBtnTap(value),
          child: Center(
            child: Text(
              value,
              style:  TextStyle(
                color: ThemeColor ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getDisplayText() {
    final displayText = '$number1$operand$number2';
    return displayText.isEmpty ? '0' : displayText;
  }

  void onBtnTap(String value) {
    if (value == Btn.del) {
      delete();
      return;
    }

    if (value == Btn.clr) {
      clearAll();
      return;
    }

    if (value == Btn.per) {
      convertToPercentage();
      return;
    }

    if (value == Btn.calculate) {
      calculate();
      return;
    }
    appendValue(value);
  }

  void calculate() {
    if (number1.isEmpty) return;
    if (operand.isEmpty) return;
    if (number2.isEmpty) return;

    final double num1 = double.parse(number1);
    final double num2 = double.parse(number2);

    var result = 0.0;

    switch (operand) {
      case Btn.add:
        result = num1 + num2;
        break;
      case Btn.subtract:
        result = num1 - num2;
        break;
      case Btn.multiply:
        result = num1 * num2;
        break;
      case Btn.divide:
        result = num1 / num2;
        break;

      default:
    }
    setState(() {
      number1 = "$result";
      if (number1.endsWith(".0")) {
        number1 = number1.substring(0, number1.length - 2);
      }
    });
    operand = "";
    number2 = "";
  }

  void convertToPercentage() {
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      calculate();
    }
    if (operand.isNotEmpty) {
      return;
    }
    final number = double.parse(number1);
    setState(() {
      number1 = "${(number / 100)}";
      operand = "";
      number2 = "";
    });
  }

  void clearAll() {
    setState(() {
      number1 = "";
      operand = "";
      number2 = "";
    });
  }

  void delete() {
    if (number2.isNotEmpty) {
      number2 = number2.substring(0, number2.length - 1);
    } else if (operand.isNotEmpty) {
      operand = "";
    } else if (number1.isNotEmpty) {
      number1 = number1.substring(0, number1.length - 1);
    }
    setState(() {});
  }

  void appendValue(String value) {
    if (value != Btn.dot && int.tryParse(value) == null) {
      if (operand.isNotEmpty && number2.isNotEmpty) {
        calculate();
      }
      operand = value;
    } else if (number1.isEmpty || operand.isEmpty) {
      if (value == Btn.dot && number1.contains(Btn.dot)) return;
      if (value == Btn.dot && (number1.isEmpty || number1 == Btn.n0)) {
        value = '0.';
      }
      number1 += value;
    } else if (number2.isEmpty || operand.isNotEmpty) {
      if (value == Btn.dot && number2.contains(Btn.dot)) return;
      if (value == Btn.dot && (number2.isEmpty || number2 == Btn.n0)) {
        value = '0.';
      }
      number2 += value;
    }

    setState(() {});
  }

  Color getBtnColor(String value) {
    return ThemeColor ? [Btn.del, Btn.clr].contains(value)
        ? Colors.blueGrey
        : [
            Btn.per,
            Btn.multiply,
            Btn.subtract,
            Btn.add,
            Btn.divide,
            Btn.calculate
          ].contains(value)
            ? Colors.orange
            : Color.fromARGB(36,36,36,255) : [Btn.del, Btn.clr].contains(value)
            ? Colors.blueGrey.shade300
            : [
                Btn.per,
                Btn.multiply,
                Btn.subtract,
                Btn.add,
                Btn.divide,
                Btn.calculate
              ].contains(value)
                ? Colors.orange
                : Color.fromARGB(255,255,255,255);
  }

  dynamic ColorTheme() {
    if (ThemeColor) {
      return Color.fromARGB(0,0,0,255);
    } else {
      return Color.fromARGB(247,247,247,255);
    }
  }
}
