import 'package:flutter/material.dart';

import 'button_value.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator App'),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // outputs
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.all(16),
                  child: Text('0',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.end),
                ),
              ),
            ),
            //buttons
            Wrap(
              children: Btn.buttonValues
                  .map(
                    (value) => SizedBox(
                      width: screenSize.width / 4,
                      height: screenSize.width / 5,
                      child: BuildButton(value),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget BuildButton(value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: [Btn.del, Btn.clr].contains(value)
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
                : Colors.black87,
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white24,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: InkWell(
          onTap: () {},
          child: Center(
            child: Text(value),
          ),
        ),
      ),
    );
  }
}
